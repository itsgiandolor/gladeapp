import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/top_navbar.dart';
import '../../widgets/nonreusable_widgets.dart';

class TaskReminderScreen extends StatefulWidget {
  const TaskReminderScreen({Key? key}) : super(key: key);

  @override
  State<TaskReminderScreen> createState() => _TaskReminderScreenState();
}

class _TaskReminderScreenState extends State<TaskReminderScreen> {
  bool _isReminderEnabled = true;
  String _selectedTime = '9:00 AM';

  void _toggleReminder(bool value) {
    setState(() {
      _isReminderEnabled = value;
    });
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = '${picked.format(context)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensure screen resizes with the keyboard
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        // Make the screen scrollable when the keyboard is displayed
        child: Column(
          children: [
            const SubSettingsTopNavbar(title: 'Task Reminders'),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20), // Adjusted padding for consistency
              child: _buildReminderCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 20), // Add vertical padding for balanced spacing
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align content to the left
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications,
                size: 21,
                color: AppTheme.primaryPurple,
              ),
              const SizedBox(width: 10),
              Text(
                'Task Reminders',
                style: AppTextStyle.cardTitle,
              ),
              const Spacer(), // Push the toggle switch to the right
              CustomToggleSwitch(
                value: _isReminderEnabled,
                onChanged: _toggleReminder,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Remind me at:',
            style: AppTextStyle.label,
          ),
          const SizedBox(height: 10),
          TimePickerField(
            time: _selectedTime,
            onTap: _showTimePicker, // Pass the onTap callback
          ),
        ],
      ),
    );
  }
}
