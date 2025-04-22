import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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
            'Activity: ${widget.activityType}',
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
