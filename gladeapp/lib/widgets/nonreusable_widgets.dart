import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// Home Screen Widgets
class DailyStreakCard extends StatelessWidget {
  const DailyStreakCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.cardWidth,
      height: AppDimensions.streakCardHeight,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('Daily Streak', style: AppTextStyle.cardTitle),
          const SizedBox(height: 20),
          Container(
            width: 106,
            height: 106,
            decoration: const BoxDecoration(
              color: AppTheme.primaryPurple,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('1', style: AppTextStyle.streakNumber),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Keep your streak going by checking in daily!',
            style: AppTextStyle.streakDescription,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryPurple,
              minimumSize: const Size(145, 42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Check In Today',
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
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

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
class TaskCard extends StatefulWidget {
  final String taskName;
  final String subjectCode;
  final String activityType; // New parameter for type of activity
  final String deadline; // New parameter for deadline
  final String imageUrl;
  final bool isChecked;
  final ValueChanged<bool?> onCheckChanged;
  final VoidCallback onDelete;

  const TaskCard({
    Key? key,
    required this.taskName,
    required this.subjectCode,
    required this.activityType,
    required this.deadline,
    required this.imageUrl,
    required this.isChecked,
    required this.onCheckChanged,
    required this.onDelete,
  }) : super(key: key);

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
                    widget.taskName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.subjectCode,
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
                value: widget.isChecked,
                onChanged: widget.onCheckChanged,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${widget.activityType}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deadline: ${widget.deadline}',
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
    Key? key,
    required this.time,
    required this.onTap,
  }) : super(key: key);

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
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

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
