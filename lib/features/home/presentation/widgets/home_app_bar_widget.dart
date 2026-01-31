import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/core/utils/app_assets.dart';

import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_state.dart';
import 'package:medical_center/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:medical_center/features/notifications/presentation/manager/notifications_state.dart';
import 'package:medical_center/generated/l10n.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => current is GetUserDataSuccessState,
        builder: (context, state) {
          final user = context.read<HomeCubit>().originalUser;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${S.of(context).hello}${user?.firstName ?? ''} 👋',
                        style: AppTextStyles.cairo400Style20.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        S.of(context).subtitle,
                        style: AppTextStyles.cairo300style16.copyWith(
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _buildSearchIcon(context),
                const SizedBox(width: 8),
                _buildNotificationIcon(context),
                const SizedBox(width: 8),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .shadow
                            .withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1),
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    AppAssets.appLogo,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget _buildSearchIcon(BuildContext context) => Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: IconButton(
          icon: Icon(
            Icons.search_rounded,
            color: Theme.of(context).colorScheme.onSurface,
            size: 26,
          ),
          onPressed: () {
            context.push('/search');
          },
        ),
      );

  Widget _buildNotificationIcon(BuildContext context) =>
      BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          var unreadCount = 0;
          if (state is NotificationsSuccess) {
            unreadCount = state.unreadCount;
          }

          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .shadow
                          .withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withValues(alpha: 0.2),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 26,
                  ),
                  onPressed: () {
                    context.push('/notifications');
                  },
                ),
              ),
              if (unreadCount > 0)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      unreadCount > 9 ? '9+' : '$unreadCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          );
        },
      );
}
