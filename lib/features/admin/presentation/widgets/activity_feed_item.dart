import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  Color _getColor(BuildContext context) {
    switch (activity.type) {
      case 'appointment':
        return Colors.blue;
      case 'review':
        return Colors.amber;
      case 'user':
        return Colors.green;
      case 'doctor':
        return Theme.of(context).colorScheme.primary;
      case 'blood':
        return Colors.red;
      default:
        return Theme.of(context).colorScheme.onSurfaceVariant;
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
    final color = _getColor(context);
    final icon = _getIcon();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color:
                Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),),
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
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
