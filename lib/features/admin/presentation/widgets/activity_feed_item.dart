import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/features/admin/data/models/dashboard_stats_model.dart';

/// Activity feed item widget
class ActivityFeedItem extends StatelessWidget {
  const ActivityFeedItem({
    required this.activity,
    super.key,
  });

  final ActivityModel activity;

  IconData _getIcon() {
    switch (activity.type) {
      case 'appointment':
        return Icons.calendar_today;
      case 'review':
        return Icons.star;
      case 'user':
        return Icons.person_add;
      case 'doctor':
        return Icons.medical_services;
      case 'blood':
        return Icons.bloodtype;
      default:
        return Icons.info;
    }
  }

  Color _getColor() {
    switch (activity.type) {
      case 'appointment':
        return AppColors.blue;
      case 'review':
        return AppColors.yellow;
      case 'user':
        return AppColors.green;
      case 'doctor':
        return AppColors.primaryColor;
      case 'blood':
        return AppColors.red;
      default:
        return AppColors.grey;
    }
  }

  String _formatTimestamp(String timestamp) {
    try {
      if (timestamp.isEmpty) return 'Recently';
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else {
        return DateFormat('MMM dd').format(dateTime);
      }
    } catch (e) {
      return 'Recently';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final icon = _getIcon();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatTimestamp(activity.timestamp),
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.deepGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
