import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


// Home Screen Widgets
class DailyStreakCard extends StatefulWidget {
  const DailyStreakCard({super.key});

  @override
  _DailyStreakCardState createState() => _DailyStreakCardState();
}

class _DailyStreakCardState extends State<DailyStreakCard> {
  int streak = 0;
  DateTime? lastCheckedIn;
  bool isLoading = false; // Track loading state
  bool isCheckedInToday = false; // Track if user has checked in today

  @override
  void initState() {
    super.initState();
    _fetchStreakData();
  }

  // Fetch the streak data from Firestore
  Future<void> _fetchStreakData() async {
    setState(() {
      isLoading = true; // Start loading
    });

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          streak = doc['streak'] ?? 0;
          lastCheckedIn = (doc['lastCheckedIn'] as Timestamp?)?.toDate();
          isCheckedInToday = _isSameDay(DateTime.now(), lastCheckedIn!);
          isLoading = false; // Stop loading
        });
      } else {
        // Create the document if it doesn't exist
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'streak': 0,
          'lastCheckedIn': Timestamp.fromDate(DateTime.now()), // Set the current date
        });
        setState(() {
          streak = 0;
          lastCheckedIn = DateTime.now();
          isCheckedInToday = false; // Not checked in yet
          isLoading = false; // Stop loading
        });
      }
    }
  }

  // Handle the "Check In Today" button press
  Future<void> _handleCheckIn() async {
    final today = DateTime.now();

    // If there is no last check-in date or if it's a new day
    setState(() {
      if (lastCheckedIn != null && today.difference(lastCheckedIn!).inDays > 1) {
        // Streak is broken, reset it
        streak = 1;
      } else {
        // Continue the streak
        streak += 1;
      }
      isCheckedInToday = true; // Mark as checked in today
    });

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      setState(() {
        isLoading = true; // Start loading
      });
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'streak': streak,
        'lastCheckedIn': Timestamp.fromDate(today),
      });
      setState(() {
        lastCheckedIn = today;
        isLoading = false; // Stop loading
      });
    }
  }

  // Helper function to check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.cardWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Daily Streak', style: AppTextStyle.cardTitle),
          const SizedBox(height: 20),
          Container(
            width: 106,
            height: 106,
            decoration: const BoxDecoration(
              color: AppTheme.primaryPurple,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator() // Show loading spinner
                  : Text(
                      '$streak',
                      style: AppTextStyle.streakNumber,
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Keep your streak going by checking in daily!',
            style: AppTextStyle.streakDescription,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLoading || isCheckedInToday ? null : _handleCheckIn, // Disable button if checked in today or loading
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryPurple,
              minimumSize: const Size(145, 42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              isLoading
                  ? 'Updating...'
                  : isCheckedInToday
                      ? 'Already Checked In'
                      : 'Check In Today', // Change text based on status
              style: AppTextStyle.streakDescription.copyWith(
                color: AppTheme.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}





class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;

  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.cardWidth,
      height: AppDimensions.actionCardHeight,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 4),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          SizedBox(
            width: 43,
            height: 43,
            child: icon,
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: AppTextStyle.actionCardTitle),
                Text(subtitle, style: AppTextStyle.actionCardSubtitle),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// Task Screen Widgets
class Task {
  final String taskName;
  final String subjectCode;
  final String activityType; // Type of activity (Quiz, Exam, Project)
  final String deadline; // Task deadline
  final String imageUrl;
  final bool isChecked; // Whether the task is completed

  Task({
    required this.taskName,
    required this.subjectCode,
    required this.activityType,
    required this.deadline,
    required this.imageUrl,
    this.isChecked = false,
  });
}


class TaskCard extends StatefulWidget {
  final Task task;
  final ValueChanged<bool?> onCheckChanged;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onCheckChanged,
    required this.onDelete,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 352),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.taskName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.task.subjectCode,
                    style: const TextStyle(
                      color: Color(0xFF828282),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
              Checkbox(
                value: widget.task.isChecked,
                onChanged: (value) {
                  setState(() {
                    widget.task.isChecked = value ?? false; // Update task state
                  });
                  widget.onCheckChanged(value); // Notify parent widget
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.task.activityType,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deadline: ${widget.task.deadline}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: AppTheme.primaryPurple),
                onPressed: widget.onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}



// Settings > Task Reminders Widgets
class TimePickerField extends StatelessWidget {
  final String time;
  final VoidCallback onTap;

  const TimePickerField({
    super.key,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 132,
        height: 43,
        decoration: BoxDecoration(
          color: AppTheme.inputBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 5,
              top: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  time,
                  style: AppTextStyle.timeText,
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 0,
              bottom: 0,
              child: Center(
                child: Icon(
                  Icons.access_time,
                  size: 20,
                  color: Colors.black.withOpacity(0.87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 51,
        height: 31,
        decoration: BoxDecoration(
          color: AppTheme.togglePurple,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.all(2),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  spreadRadius: 0,
                  blurRadius: 1,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
