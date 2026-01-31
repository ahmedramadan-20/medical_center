import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:medical_center/features/notifications/presentation/manager/notifications_state.dart';
import 'package:medical_center/generated/l10n.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.email;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          S.of(context).notifications,
          style: AppTextStyles.cairo400Style20.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
        actions: [
          IconButton(
            icon: Icon(
              Icons.done_all,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            tooltip: S.of(context).mark_all_as_read,
            onPressed: () =>
                context.read<NotificationsCubit>().markAllAsRead(userId!),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_sweep_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            tooltip: S.of(context).clear_all,
            onPressed: () => _showClearAllDialog(context, userId!),
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationsError) {
            return Center(child: Text(state.message));
          }

          if (state is NotificationsSuccess) {
            if (state.notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_off_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).no_notifications,
                      style: AppTextStyles.cairo300style16.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final notification = state.notifications[index];
                return Dismissible(
                  key: Key(notification.id!),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    context
                        .read<NotificationsCubit>()
                        .deleteNotification(notification.id!);
                  },
                  child: InkWell(
                    onTap: () {
                      if (!notification.isRead) {
                        context
                            .read<NotificationsCubit>()
                            .markAsRead(notification.id!);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: notification.isRead
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: notification.isRead
                              ? Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withValues(alpha: 0.2)
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _getNotificationColor(
                                context,
                                notification.data?['type'] ?? '',
                              ).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _getNotificationIcon(
                                notification.data?['type'] ?? '',
                              ),
                              color: _getNotificationColor(
                                context,
                                notification.data?['type'] ?? '',
                              ),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        Localizations.localeOf(context)
                                                    .languageCode ==
                                                'ar'
                                            ? (notification.titleAr ??
                                                notification.title)
                                            : notification.title,
                                        style: AppTextStyles.cairo400Style20
                                            .copyWith(
                                          fontSize: 16,
                                          fontWeight: notification.isRead
                                              ? FontWeight.w500
                                              : FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                    ),
                                    if (!notification.isRead)
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  Localizations.localeOf(context)
                                              .languageCode ==
                                          'ar'
                                      ? (notification.bodyAr ??
                                          notification.body)
                                      : notification.body,
                                  style: AppTextStyles.cairo300style16.copyWith(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _formatTime(notification.createdAt, context),
                                  style: AppTextStyles.cairo300style16.copyWith(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(S.of(context).clear_all),
        content:
            const Text('Are you sure you want to delete all notifications?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<NotificationsCubit>().clearAll(userId);
              Navigator.pop(dialogContext);
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'appointment':
        return Icons.event_available;
      case 'cancellation':
        return Icons.event_busy;
      case 'review':
        return Icons.star;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(BuildContext context, String type) {
    switch (type) {
      case 'appointment':
        return Colors.green;
      case 'cancellation':
        return Colors.red;
      case 'review':
        return Colors.amber;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  String _formatTime(DateTime time, BuildContext context) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return DateFormat.yMMMd().format(time);
    }
  }
}
