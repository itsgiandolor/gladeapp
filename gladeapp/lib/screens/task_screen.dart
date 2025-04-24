import 'package:flutter/material.dart';
import '../widgets/nonreusable_widgets.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/top_navbar.dart';
import '../theme/app_theme.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Map<String, dynamic>> ongoingTasks = [];
  List<Map<String, dynamic>> completedTasks = [];

  void addTask(String name, String code, String activityType, String deadline) {
    setState(() {
      ongoingTasks.add({
        'taskName': name,
        'subjectCode': code,
        'activityType': activityType,
        'deadline': deadline,
        'imageUrl': 'URL_${ongoingTasks.length + 1}',
        'isChecked': false,
      });
    });
  }

  void toggleTaskCompletion(int index, bool isCompleted) {
    setState(() {
      if (isCompleted) {
        completedTasks.add(ongoingTasks.removeAt(index));
      } else {
        ongoingTasks.add(completedTasks.removeAt(index));
      }
    });
  }

  void deleteTask(int index, bool isCompleted) {
    setState(() {
      if (isCompleted) {
        completedTasks.removeAt(index);
      } else {
        ongoingTasks.removeAt(index);
      }
    });
  }

  void showAddTaskModal() {
    String taskName = '';
    String subjectCode = '';
    String? activityType = 'Quiz'; // Placeholder for the dropdown
    String? deadline;

    // Function to open the DatePicker
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != DateTime.now()) {
        setState(() {
          deadline = "${picked.toLocal()}".split(' ')[0]; // Format date
        });
      }
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add New Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Task Name'),
              onChanged: (value) => taskName = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Subject Code'),
              onChanged: (value) => subjectCode = value,
            ),
            const SizedBox(height: 10),
            // Activity Type Dropdown
            DropdownButtonFormField<String>(
              value: activityType,
              onChanged: (newValue) {
                setState(() {
                  activityType = newValue;
                });
              },
              items: <String>['Quiz', 'Exam', 'Project']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Type of Activity'),
              isExpanded: true, // Makes the dropdown expand to full width
            ),
            const SizedBox(height: 10),
            // Deadline Picker
            GestureDetector(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Deadline',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  deadline ?? 'Select a date',
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (taskName.isNotEmpty &&
                    subjectCode.isNotEmpty &&
                    activityType != 'Type of Activity' &&
                    deadline != null) {
                  addTask(taskName, subjectCode, activityType!, deadline!);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text(
                'Add Task',
                style: TextStyle(
                  color: AppTheme.white, // Use your white color here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE7F6),
      body: SafeArea(
        child: Column(
          children: [
            const TasksTopNavbar(),
            Expanded(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            'Ongoing Tasks',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ...ongoingTasks.asMap().entries.map((entry) {
                          int index = entry.key;
                          var task = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 6),
                            child: TaskCard(
                              taskName: task['taskName'],
                              subjectCode: task['subjectCode'],
                              activityType: task['activityType'],
                              deadline: task['deadline'],
                              imageUrl: task['imageUrl'],
                              isChecked: task['isChecked'],
                              onCheckChanged: (val) =>
                                  toggleTaskCompletion(index, true),
                              onDelete: () => deleteTask(index, false),
                            ),
                          );
                        }).toList(),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 20, bottom: 10),
                          child: Text(
                            'Completed Tasks',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ...completedTasks.asMap().entries.map((entry) {
                          int index = entry.key;
                          var task = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 6),
                            child: TaskCard(
                              taskName: task['taskName'],
                              subjectCode: task['subjectCode'],
                              activityType: task['activityType'],
                              deadline: task['deadline'],
                              imageUrl: task['imageUrl'],
                              isChecked: true,
                              onCheckChanged: (val) =>
                                  toggleTaskCompletion(index, false),
                              onDelete: () => deleteTask(index, true),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskModal,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
    );
  }
}
