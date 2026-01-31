import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/admin/presentation/manager/admin_doctors_cubit.dart';
import 'package:medical_center/features/home/data/models/category_model.dart';
import 'package:medical_center/features/home/data/models/doctor_schedule_model.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';
import 'package:medical_center/generated/l10n.dart';

class AddEditDoctorScreen extends StatefulWidget {
  const AddEditDoctorScreen({super.key, this.doctor});
  final DoctorsModel? doctor;

  @override
  State<AddEditDoctorScreen> createState() => _AddEditDoctorScreenState();
}

class _AddEditDoctorScreenState extends State<AddEditDoctorScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _arNameController;
  late TextEditingController _enNameController;
  late TextEditingController _imageController;

  SpecialityModel? _selectedSpeciality;
  List<DoctorScheduleModel> _schedules = [];

  @override
  void initState() {
    super.initState();
    context.read<AdminDoctorsCubit>().getSpecialities();

    _arNameController =
        TextEditingController(text: widget.doctor?.arName ?? '');
    _enNameController =
        TextEditingController(text: widget.doctor?.enName ?? '');

    _imageController = TextEditingController(text: widget.doctor?.image ?? '');

    if (widget.doctor != null) {
      _schedules = List.from(widget.doctor!.schedules);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          title: Text(
            widget.doctor == null
                ? S.of(context).add_new_doctor
                : S.of(context).edit_doctor_profile,
            style: AppTextStyles.cairo400Style20.copyWith(
                color: AppColors.deepBlue, fontWeight: FontWeight.bold,),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: AppColors.deepBlue),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton.icon(
                onPressed: _saveDoctor,
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.primaryColor,
                ),
                label: Text(
                  S.of(context).save,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<AdminDoctorsCubit, AdminDoctorsState>(
          builder: (context, state) {
            final cubit = context.read<AdminDoctorsCubit>();

            if (cubit.specialities.isEmpty && state is AdminDoctorsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_selectedSpeciality == null &&
                widget.doctor != null &&
                cubit.specialities.isNotEmpty) {
              final matching = cubit.specialities
                  .where((s) => s.id == widget.doctor!.specializationId)
                  .toList(growable: false);
              if (matching.isNotEmpty) {
                _selectedSpeciality = matching.first;
              } else {
                // Doctor specialization might have been deleted. Fallback safely.
                _selectedSpeciality = cubit.specialities.first;
              }
            } else if (_selectedSpeciality == null &&
                cubit.specialities.isNotEmpty) {
              _selectedSpeciality = cubit.specialities.first;
            }

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfilePreview(),
                    const SizedBox(height: 24),
                    _buildSectionTitle(S.of(context).basic_information),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _enNameController,
                      label: S.of(context).doctor_name_en,
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _arNameController,
                      label: S.of(context).doctor_name_ar,
                      icon: Icons.person_outline,
                      isArabic: true,
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle(S.of(context).specialization),
                    const SizedBox(height: 16),
                    if (cubit.specialities.isNotEmpty)
                      _buildSpecialityDropdown(cubit.specialities)
                    else
                      Center(child: Text(S.of(context).loading_specialities)),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _imageController,
                      label: S.of(context).profile_image_url,
                      icon: Icons.image_outlined,
                      onChanged: (v) => setState(() {}),
                    ),
                    const SizedBox(height: 32),
                    _buildScheduleSection(),
                    const SizedBox(height: 100), // Space for fab-like save
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget _buildProfilePreview() => Center(
        child: Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: _imageController.text.isNotEmpty
                    ? Image.network(
                        _imageController.text,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.medical_services_outlined,
                          size: 50,
                          color: AppColors.primaryColor,
                        ),
                      )
                    : const Icon(
                        Icons.person_add_outlined,
                        size: 50,
                        color: AppColors.primaryColor,
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      );

  Widget _buildSectionTitle(String title) => Text(
        title,
        style: AppTextStyles.cairo300style16.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.deepBlue,
          fontSize: 18,
        ),
      );

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isArabic = false,
    Function(String)? onChanged,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(fontWeight: FontWeight.w600),
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 22),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            labelStyle: TextStyle(color: Colors.grey[600]),
          ),
          validator: (v) => v!.isEmpty ? S.of(context).field_is_required : null,
        ),
      );

  Widget _buildSpecialityDropdown(List<SpecialityModel> specialities) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: DropdownButtonFormField<SpecialityModel>(
          decoration: InputDecoration(
            labelText: S.of(context).specialization,
            prefixIcon: const Icon(
              Icons.category_outlined,
              color: AppColors.primaryColor,
              size: 22,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          initialValue: _selectedSpeciality,
          items: specialities
              .map(
                (s) => DropdownMenuItem(
                  value: s,
                  child: Text(s.enCategoryName),
                ),
              )
              .toList(),
          onChanged: (val) {
            setState(() {
              _selectedSpeciality = val;
            });
          },
          validator: (v) => v == null ? S.of(context).field_is_required : null,
        ),
      );

  Widget _buildScheduleSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle(S.of(context).working_hours),
              TextButton.icon(
                onPressed: _addScheduleDialog,
                icon: const Icon(Icons.more_time, size: 20),
                label: Text(S.of(context).add_shift),
                style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_schedules.isEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.event_busy_rounded,
                    color: Colors.grey[400],
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    S.of(context).no_schedules_added_yet,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _schedules.length,
              itemBuilder: (context, index) {
                final schedule = _schedules[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: Colors.grey[100] ?? Colors.grey.shade100,),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.access_time_filled,
                        color: AppColors.primaryColor,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      schedule.dayName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${schedule.startTime} - ${schedule.endTime}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _schedules.remove(schedule);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
        ],
      );

  void _addScheduleDialog() {
    var selectedDay = 1; // Mon
    var start = const TimeOfDay(hour: 9, minute: 0);
    var end = const TimeOfDay(hour: 17, minute: 0);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text(S.of(context).add_schedule),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<int>(
                value: selectedDay,
                items: [
                  DropdownMenuItem(
                    value: 1,
                    child: Text(S.of(context).monday),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text(S.of(context).tuesday),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text(S.of(context).wednesday),
                  ),
                  DropdownMenuItem(
                    value: 4,
                    child: Text(S.of(context).thursday),
                  ),
                  DropdownMenuItem(
                    value: 5,
                    child: Text(S.of(context).friday),
                  ),
                  DropdownMenuItem(
                    value: 6,
                    child: Text(S.of(context).saturday),
                  ),
                  DropdownMenuItem(
                    value: 7,
                    child: Text(S.of(context).sunday),
                  ),
                ],
                onChanged: (v) {
                  if (v != null) {
                    setStateDialog(() => selectedDay = v);
                  }
                },
              ),
              ListTile(
                title: Text(S.of(context).start_time),
                trailing: Text(start.format(context)),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: start,
                  );
                  if (time != null) setStateDialog(() => start = time);
                },
              ),
              ListTile(
                title: Text(S.of(context).end_time),
                trailing: Text(end.format(context)),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: end,
                  );
                  if (time != null) setStateDialog(() => end = time);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () {
                final newSchedule = DoctorScheduleModel(
                  dayOfWeek: selectedDay,
                  startTime:
                      '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}',
                  endTime:
                      '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}',
                );

                setState(() {
                  // Remove existing for same day if strictly one shift per day needed, or allow multiple
                  _schedules.add(newSchedule);
                });
                Navigator.pop(context);
              },
              child: Text(S.of(context).add),
            ),
          ],
        ),
      ),
    );
  }

  void _saveDoctor() {
    if (_formKey.currentState!.validate()) {
      final doctor = DoctorsModel(
        id: widget.doctor?.id ?? 0,
        docId: widget.doctor?.docId,
        specializationId: _selectedSpeciality?.id ?? 1,
        arName: _arNameController.text,
        enName: _enNameController.text,
        arSpecialization: _selectedSpeciality?.arCategoryName ?? '',
        enSpecialization: _selectedSpeciality?.enCategoryName ?? '',
        image: _imageController.text.isEmpty
            ? 'https://placehold.co/150.png'
            : _imageController.text,
        isAvailable: true,
        schedules: _schedules,
        numberOfPatients: 0,
      );

      if (widget.doctor == null) {
        context.read<AdminDoctorsCubit>().addDoctor(doctor);
      } else {
        context.read<AdminDoctorsCubit>().updateDoctor(doctor);
      }
      Navigator.pop(context);
    }
  }
}
