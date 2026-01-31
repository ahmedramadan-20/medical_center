import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({
    required this.title,
    super.key,
    this.subtitle,
    this.onActionPressed,
    this.actionLabel,
  });
  final String title;
  final String? subtitle;
  final VoidCallback? onActionPressed;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/no-data.json',
                width: 200,
                repeat: true,
              ),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.cairo400Style20.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 12),
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.cairo300style16.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (onActionPressed != null && actionLabel != null) ...[
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: onActionPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    actionLabel!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
}
