import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_center/core/functions/custom_toast.dart';

import 'package:medical_center/features/admin/data/models/dashboard_stats_model.dart';
import 'package:medical_center/generated/l10n.dart';

/// Export data dialog
class ExportDialog extends StatelessWidget {
  const ExportDialog({
    required this.stats,
    super.key,
  });

  final DashboardStatsModel stats;

  String _generateCSV() {
    final buffer = StringBuffer();

    // Header
    buffer.writeln('Medical Center Dashboard Statistics');
    buffer.writeln('Generated: ${DateTime.now()}');
    buffer.writeln();

    // Basic Statistics
    buffer.writeln('Category,Value');
    buffer.writeln('Total Users,${stats.totalUsers}');
    buffer.writeln('Total Doctors,${stats.totalDoctors}');
    buffer.writeln('Total Appointments,${stats.totalAppointments}');
    buffer.writeln('Total Specialities,${stats.totalSpecialities}');
    buffer.writeln('Total Reviews,${stats.totalReviews}');
    buffer.writeln('Active Blood Requests,${stats.activeBloodRequests}');
    buffer.writeln('Pending Appointments,${stats.pendingAppointments}');
    buffer.writeln('Confirmed Appointments,${stats.confirmedAppointments}');
    buffer.writeln('Cancelled Appointments,${stats.cancelledAppointments}');
    buffer.writeln('Today Appointments,${stats.todayAppointments}');
    buffer.writeln('Admin Users,${stats.adminUsers}');
    buffer.writeln('Regular Users,${stats.regularUsers}');
    buffer.writeln('Average Rating,${stats.averageRating.toStringAsFixed(2)}');
    buffer.writeln();

    // Top Specialities
    buffer.writeln('Top Specialities');
    buffer.writeln('Speciality,Doctors,Appointments,Avg Rating');
    for (final speciality in stats.topSpecialities) {
      buffer.writeln('${speciality.speciality},${speciality.doctorCount},'
          '${speciality.appointmentCount},${speciality.averageRating.toStringAsFixed(2)}');
    }

    return buffer.toString();
  }

  String _generateJSON() =>
      const JsonEncoder.withIndent('  ').convert(stats.toJson());

  void _copyToClipboard(BuildContext context, String data, String format) {
    Clipboard.setData(ClipboardData(text: data));
    Navigator.pop(context);
    final message = format == 'CSV'
        ? S.of(context).csv_data_copied
        : S.of(context).json_data_copied;
    showToast(context, message);
  }

  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.file_download,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      S.of(context).export_dashboard_data,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                S.of(context).select_export_format,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              _ExportOptionCard(
                icon: Icons.table_chart,
                title: S.of(context).csv_format,
                description: S.of(context).export_csv_description,
                color: Colors.green,
                onTap: () => _copyToClipboard(context, _generateCSV(), 'CSV'),
              ),
              const SizedBox(height: 12),
              _ExportOptionCard(
                icon: Icons.code,
                title: S.of(context).json_format,
                description: S.of(context).export_json_description,
                color: Colors.blue,
                onTap: () => _copyToClipboard(context, _generateJSON(), 'JSON'),
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).data_copied_to_clipboard,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      );
}

class _ExportOptionCard extends StatelessWidget {
  const _ExportOptionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: color),
            ],
          ),
        ),
      );
}
