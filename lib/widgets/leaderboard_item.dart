import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LeaderboardItem extends StatelessWidget {
  final String name;
  final String points;
  final String? rank;
  final IconData? iconData;

  const LeaderboardItem({
    super.key,
    required this.name,
    required this.points,
    this.rank,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Name and points
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                points,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          // Icon and rank
          if (iconData != null && rank != null)
            Column(
              children: [
                Icon(
                  iconData,
                  color: AppTheme.primaryPurple,
                  size: 30,
                ),
                const SizedBox(height: 4),
                Text(
                  '#$rank',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
