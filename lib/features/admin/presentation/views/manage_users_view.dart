import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_empty_widget.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_users_cubit.dart';
import 'package:medical_center/features/home/data/models/user_model.dart';
import 'package:medical_center/generated/l10n.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AdminUsersCubit()..getUsers(),
        child: Scaffold(
          backgroundColor: AppColors.offWhite,
          appBar: AppBar(
            title: Text(
              S.of(context).manage_users,
              style: AppTextStyles.cairo400Style20,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const BackButton(color: Colors.black),
          ),
          body: BlocListener<AdminUsersCubit, AdminUsersState>(
            listener: (context, state) {
              if (state is AdminUsersOperationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else if (state is AdminUsersError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: BlocBuilder<AdminUsersCubit, AdminUsersState>(
              builder: (context, state) {
                if (state is AdminUsersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AdminUsersLoaded ||
                    state is AdminUsersOperationSuccess) {
                  // Determine users list
                  var users = <UserModel>[];
                  if (state is AdminUsersLoaded) {
                    users = state.users;
                  } else {
                    // If success state, try to get from current cubit state if it happens to be Loaded
                    final currentState = context.read<AdminUsersCubit>().state;
                    if (currentState is AdminUsersLoaded) {
                      users = currentState.users;
                    }
                  }

                  if (users.isEmpty && state is! AdminUsersLoading) {
                    return CustomEmptyWidget(
                      title: S.of(context).no_users_found,
                      subtitle: S.of(context).no_users_registered,
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor:
                                AppColors.primaryColor.withValues(alpha: 0.1),
                            child: Text(
                              user.firstName.isNotEmpty
                                  ? user.firstName[0]
                                  : 'U',
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            '${user.firstName} ${user.lastName}',
                            style: AppTextStyles.cairo300style16
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.email,
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: user.isAdmin
                                      ? Colors.orange.withValues(alpha: 0.1)
                                      : Colors.blue.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  user.isAdmin ? 'Admin' : 'User',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: user.isAdmin
                                        ? Colors.orange
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            icon:
                                const Icon(Icons.more_vert, color: Colors.grey),
                            onSelected: (value) {
                              if (value == 'role') {
                                _showRoleConfirmation(context, user);
                              } else if (value == 'delete') {
                                _showDeleteConfirmation(context, user);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'role',
                                child: Row(
                                  children: [
                                    Icon(
                                      user.isAdmin
                                          ? Icons.person_outline
                                          : Icons.admin_panel_settings_outlined,
                                      color: Colors.orange,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      user.isAdmin
                                          ? 'Make Regular User'
                                          : 'Make Administrator',
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      S.of(context).delete_user,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is AdminUsersError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

  void _showRoleConfirmation(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(user.isAdmin ? 'Revoke Admin' : 'Make Administrator'),
        content: Text(
          'Are you sure you want to ${user.isAdmin ? 'remove admin privileges from' : 'grant admin privileges to'} ${user.firstName} ${user.lastName}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              context
                  .read<AdminUsersCubit>()
                  .toggleAdminStatus(user.email, user.isAdmin);
              Navigator.pop(dialogContext);
            },
            child: Text(
              S.of(context).confirm,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(S.of(dialogContext).delete_user),
        content: Text(
          S
              .of(dialogContext)
              .delete_user_confirmation('${user.firstName} ${user.lastName}'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              context.read<AdminUsersCubit>().deleteUser(user.email);
              Navigator.pop(dialogContext);
            },
            child: Text(
              S.of(context).delete,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
