import 'package:flutter/material.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';

/// A reusable custom button widget with consistent styling.
///
/// This button follows the app's design system and provides
/// a consistent look and feel across the application.
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    super.key,
    this.color,
    this.onPressed,
  });

  /// The background color of the button. Defaults to primary color.
  final Color? color;

  /// The text to display on the button.
  final String text;

  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            style: AppTextStyles.cairo700style32.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      );
}
