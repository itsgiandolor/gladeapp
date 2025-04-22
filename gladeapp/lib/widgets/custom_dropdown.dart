import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DepartmentDropdown extends StatefulWidget {
  final Function(String?) onChanged;

  const DepartmentDropdown({Key? key, required this.onChanged})
      : super(key: key);

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
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.inputBackground,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedDepartment,
          hint: const Text(
            'Select Department',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
              fontWeight: FontWeight.w200,
              color: Color(0xFF9E9E9E),
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: AppTheme.black),
          isExpanded: true,
          items: departments.map((String department) {
            return DropdownMenuItem<String>(
              value: department,
              child: Text(
                department,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  fontWeight: FontWeight.w200,
                  color: AppTheme.black,
                ),
              ),
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

  const YearLevelDropdown({Key? key, required this.onChanged})
      : super(key: key);

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
      width: 250,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.inputBackground,
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedYear,
          hint: const Text(
            'Select Year Level',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
              fontWeight: FontWeight.w200,
              color: Color(0xFF9E9E9E),
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: AppTheme.black),
          isExpanded: true,
          items: yearLevels.map((String year) {
            return DropdownMenuItem<String>(
              value: year,
              child: Text(
                year,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  fontWeight: FontWeight.w200,
                  color: AppTheme.black,
                ),
              ),
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
