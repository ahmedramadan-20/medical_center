import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_empty_widget.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_specialities_cubit.dart';
import 'package:medical_center/features/home/data/models/category_model.dart';
import 'package:medical_center/generated/l10n.dart';

class ManageSpecialitiesScreen extends StatelessWidget {
  const ManageSpecialitiesScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AdminSpecialitiesCubit()..getSpecialities(),
        child: Scaffold(
          backgroundColor: AppColors.offWhite,
          appBar: AppBar(
            title: Text(
              S.of(context).manage_specialities,
              style: AppTextStyles.cairo400Style20,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const BackButton(color: Colors.black),
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () => _showAddSpecialityDialog(context),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
          body: BlocBuilder<AdminSpecialitiesCubit, AdminSpecialitiesState>(
            builder: (context, state) {
              if (state is AdminSpecialitiesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AdminSpecialitiesLoaded) {
                if (state.specialities.isEmpty) {
                  return CustomEmptyWidget(
                    title: S.of(context).no_specialties,
                    subtitle: S.of(context).no_specialties_added,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.specialities.length,
                  itemBuilder: (context, index) {
                    final spec = state.specialities[index];
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: Text(
                          spec.enCategoryName,
                          style: AppTextStyles.cairo300style16
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          spec.arCategoryName,
                          style: AppTextStyles.cairo300style16
                              .copyWith(fontSize: 12),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => context
                              .read<AdminSpecialitiesCubit>()
                              .deleteSpeciality(spec.id),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is AdminSpecialitiesError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );

  void _showAddSpecialityDialog(BuildContext context) {
    final enController = TextEditingController();
    final arController = TextEditingController();
    final imgController = TextEditingController(text: 'assets/images/all.png');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context).add_speciality),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: enController,
              decoration: const InputDecoration(labelText: 'English Name'),
            ),
            TextField(
              controller: arController,
              decoration: const InputDecoration(labelText: 'Arabic Name'),
            ),
            TextField(
              controller: imgController,
              decoration: const InputDecoration(labelText: 'Image Asset Path'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<AdminSpecialitiesCubit>().addSpeciality(
                    SpecialityModel(
                      id: 0,
                      enCategoryName: enController.text,
                      arCategoryName: arController.text,
                      image: imgController.text,
                    ),
                  );
              Navigator.pop(dialogContext);
            },
            child: Text(S.of(context).add),
          ),
        ],
      ),
    );
  }
}
