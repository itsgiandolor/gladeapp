import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DepartmentDropdown extends StatefulWidget {
  final Function(String?) onChanged;

  const DepartmentDropdown({super.key, required this.onChanged});

  @override
  _DepartmentDropdownState createState() => _DepartmentDropdownState();
}

class _DepartmentDropdownState extends State<DepartmentDropdown> {
  String? selectedDepartment;

  final List<String> departments = [
    'College of Computer Science',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryPurple, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedDepartment,
          hint: const Text(
            'Select Department',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppTheme.primaryPurple,
            ),
          ),
          icon:
              const Icon(Icons.arrow_drop_down, color: AppTheme.primaryPurple),
          isExpanded: true,
          dropdownColor: AppTheme.backgroundColor,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppTheme.black,
          ),
          items: departments.map((String department) {
            return DropdownMenuItem<String>(
              value: department,
              child: Text(department),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              selectedDepartment = value;
              widget.onChanged(value);
            });
          },
        ),
      ),
    );
  }
}

class YearLevelDropdown extends StatefulWidget {
  final Function(String?) onChanged;

  const YearLevelDropdown({super.key, required this.onChanged});

  @override
  _YearLevelDropdownState createState() => _YearLevelDropdownState();
}

class _YearLevelDropdownState extends State<YearLevelDropdown> {
  String? selectedYear;

  final List<String> yearLevels = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryPurple, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedYear,
          hint: const Text(
            'Select Year Level',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppTheme.primaryPurple,
            ),
          ),
          icon:
              const Icon(Icons.arrow_drop_down, color: AppTheme.primaryPurple),
          isExpanded: true,
          dropdownColor: AppTheme.backgroundColor,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppTheme.black,
          ),
          items: yearLevels.map((String year) {
            return DropdownMenuItem<String>(
              value: year,
              child: Text(year),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              selectedYear = value;
              widget.onChanged(value);
            });
          },
        ),
      ),
    );
  }
}
