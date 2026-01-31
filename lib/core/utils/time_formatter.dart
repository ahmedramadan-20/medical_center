import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeFormatter {
  /// Formats a time range (start - end) into a localized 12-hour style string.
  /// Standardizes parsing to avoid locale-specific digit issues.
  static String formatTimeRange(
    String start,
    String end,
    BuildContext context,
  ) {
    final formattedStart = formatSingleTime(start, context);
    final formattedEnd = formatSingleTime(end, context);

    return '$formattedStart - $formattedEnd';
  }

  /// Formats a single time string (e.g., "17:00" or "5:00") into a localized 12-hour style.
  static String formatSingleTime(String time, BuildContext context) {
    if (time.isEmpty) return '';

    final trimmedTime = time.trim();

    try {
      DateTime parsedTime;

      // Always parse using 'en' locale to handle Western digits reliably
      try {
        parsedTime = DateFormat('HH:mm', 'en').parse(trimmedTime);
      } catch (e) {
        try {
          parsedTime = DateFormat('H:mm', 'en').parse(trimmedTime);
        } catch (e) {
          // Fallback to simpler manual parsing if DateFormat fails
          final parts = trimmedTime.split(':');
          if (parts.length >= 2) {
            final hour = int.parse(parts[0]);
            final minute = int.parse(parts[1].substring(0, 2));
            parsedTime = DateTime(1970, 1, 1, hour, minute);
          } else {
            return time; // Return raw if we can't parse it at all
          }
        }
      }

      // Use jm() for standard localized 12-hour time of day (e.g., 5:00 PM)
      // or h:mm a for explicit AM/PM
      return DateFormat('h:mm a', Localizations.localeOf(context).languageCode)
          .format(parsedTime);
    } catch (e) {
      return time; // Return raw as absolute fallback
    }
  }
}
