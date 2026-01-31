import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/core/services/image_service.dart';

import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_cubit.dart';

class ProfileAvatarAndName extends StatelessWidget {
  const ProfileAvatarAndName({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    final user = profileCubit.originalUser!;
    final imageService = ImageService();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.shadow.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.1),
                    Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: user.image.isNotEmpty && !user.image.startsWith('http')
                    ? Image.memory(
                        imageService.getImageFromBase64(user.image)!,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: user.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Animate(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
                            ),
                          ).animate().shimmer(),
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.1),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${user.firstName} ${user.lastName}',
                          style: AppTextStyles.cairo400Style20.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        onPressed: () async {
                          final result = await context.push('/editProfile');
                          // Refresh if profile was updated
                          if (result == true && context.mounted) {
                            await profileCubit.getUserData();
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    user.email,
                    style: AppTextStyles.cairo300style16.copyWith(
                      fontSize: 14,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: user.isAdmin
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.1)
                          : Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      user.isAdmin ? 'Admin' : 'Patient',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: user.isAdmin
                            ? Theme.of(context).colorScheme.primary
                            : Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
