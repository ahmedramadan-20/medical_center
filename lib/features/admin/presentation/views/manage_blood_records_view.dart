import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_empty_widget.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_blood_cubit.dart';
import 'package:medical_center/generated/l10n.dart';

class ManageBloodRecordsScreen extends StatelessWidget {
  const ManageBloodRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AdminBloodCubit()..getBloodRecords(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: Text(
              S.of(context).blood_donation_records,
              style: AppTextStyles.cairo400Style20,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const BackButton(color: Colors.black),
          ),
          body: BlocBuilder<AdminBloodCubit, AdminBloodState>(
            builder: (context, state) {
              if (state is AdminBloodLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AdminBloodLoaded) {
                if (state.records.isEmpty) {
                  return CustomEmptyWidget(
                    title: S.of(context).no_blood_records,
                    subtitle: S.of(context).no_blood_records_registered,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    final record = state.records[index];
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
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .error
                                .withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              record.bloodType,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          '${record.firstName} ${record.lastName}',
                          style: AppTextStyles.cairo300style16
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone: ${record.phone}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Gender: ${record.gender}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    );
                  },
                );
              } else if (state is AdminBloodError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );
}
