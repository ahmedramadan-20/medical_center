import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/app/global_cubit/theme_cubit.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_change_lang_button.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_cubit.dart';
import 'package:medical_center/generated/l10n.dart';

class CustomProfileListTile extends StatelessWidget {
  const CustomProfileListTile({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).general,
              style: AppTextStyles.cairo400Style20.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
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
              ),
              child: Column(
                children: [
                  _buildModernTile(
                    context: context,
                    icon: Icons.favorite_outline,
                    title: S.of(context).my_favorites,
                    onTap: () {
                      context.push('/favorites');
                    },
                    showArrow: true,
                  ),
                  _buildDivider(context),
                  _buildModernExpansionTile(
                    context: context,
                    icon: Icons.location_on_outlined,
                    title: S.of(context).address,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${S.of(context).clinics}: ${S.of(context).mit_azzoun}',
                              style: AppTextStyles.cairo300style16.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${S.of(context).joint}: ${S.of(context).street}',
                              style: AppTextStyles.cairo300style16.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _buildDivider(context),
                  _buildModernExpansionTile(
                    context: context,
                    icon: Icons.phone_outlined,
                    title: S.of(context).booking,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${S.of(context).phone}: 01202027567',
                              style: AppTextStyles.cairo300style16.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${S.of(context).landline}: 0502053187',
                              style: AppTextStyles.cairo300style16.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _buildDivider(context),
                  _buildLanguageTile(context),
                  _buildDivider(context),
                  _buildThemeTile(context),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [Colors.red.shade400, Colors.red.shade600],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (!context.mounted) return;
                  context.go('/signIn');
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: Text(
                  S.of(context).sign_out,
                  style: AppTextStyles.cairo400Style20.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (context.read<ProfileCubit>().originalUser?.isAdmin ?? false)
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextButton.icon(
                  onPressed: () {
                    context.push('/adminDashboard');
                  },
                  icon: const Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                  ),
                  label: Text(
                    S.of(context).admin_dashboard,
                    style: AppTextStyles.cairo400Style20.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );

  Widget _buildModernTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showArrow = false,
  }) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.cairo400Style20.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              if (showArrow)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            ],
          ),
        ),
      );

  Widget _buildModernExpansionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) =>
      Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(16),
          childrenPadding: EdgeInsets.zero,
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 22,
            ),
          ),
          title: Text(
            title,
            style: AppTextStyles.cairo400Style20.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          iconColor: Theme.of(context).colorScheme.primary,
          collapsedIconColor: Theme.of(context).colorScheme.onSurfaceVariant,
          children: children,
        ),
      );

  Widget _buildLanguageTile(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.language,
                color: Theme.of(context).colorScheme.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                S.of(context).language,
                style: AppTextStyles.cairo400Style20.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const ChangeLanguageButton(),
          ],
        ),
      );

  Widget _buildThemeTile(BuildContext context) =>
      BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isDark = context.read<ThemeCubit>().isDark;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: Theme.of(context).colorScheme.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    isDark ? 'Dark Mode' : 'Light Mode',
                    style: AppTextStyles.cairo400Style20.copyWith(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: isDark,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
              ],
            ),
          );
        },
      );

  Widget _buildDivider(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Divider(
          height: 1,
          color: Theme.of(context)
              .colorScheme
              .outlineVariant
              .withValues(alpha: 0.3),
        ),
      );
}
