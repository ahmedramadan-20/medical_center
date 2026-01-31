import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_button.dart';
import 'package:medical_center/features/appointments/data/models/appointment_model.dart';
import 'package:medical_center/features/appointments/presentation/manager/appointment_cubit.dart';
import 'package:medical_center/features/appointments/presentation/manager/appointment_state.dart';
import 'package:medical_center/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/generated/l10n.dart';
import 'package:uuid/uuid.dart';

class BookAppointmentView extends StatefulWidget {
  const BookAppointmentView({required this.doctor, super.key});
  final DoctorsModel doctor;

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _patientPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    final homeCubit = context.read<HomeCubit>();
    if (homeCubit.originalUser != null) {
      _patientNameController.text =
          '${homeCubit.originalUser!.firstName} ${homeCubit.originalUser!.lastName}';
      _patientPhoneController.text = homeCubit.originalUser!.phone;
    }
    // Initialize with next available date based on doctor's schedule
    final schedule = widget.doctor.getNextAvailableSlot();
    if (schedule != null) {
      _selectedDate = _getNextDateForDay(schedule.dayOfWeek);
      // Set default time to start time
      final timeParts = schedule.startTime.split(':');
      _selectedTime = TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      );
    }
  }

  DateTime _getNextDateForDay(int dayOfWeek) {
    final now = DateTime.now();
    final daysUntil = (dayOfWeek - now.weekday + 7) % 7;
    if (daysUntil == 0) {
      return now;
    }
    return now.add(Duration(days: daysUntil));
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _patientPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AppointmentCubit(),
        child: Scaffold(
          backgroundColor: AppColors.offWhite,
          appBar: AppBar(
            title: Text(
              S.of(context).book_appointment,
              style: AppTextStyles.cairo400Style20,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const BackButton(color: Colors.black),
          ),
          body: BlocListener<AppointmentCubit, AppointmentState>(
            listener: (context, state) {
              if (state is AppointmentSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                Navigator.pop(context);
              } else if (state is AppointmentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDoctorCard(),
                    const SizedBox(height: 32),
                    Text(
                      S.of(context).select_appointment_date,
                      style: AppTextStyles.cairo400Style20.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDateTimePicker(),
                    const SizedBox(height: 32),
                    Text(
                      'Patient Information',
                      style: AppTextStyles.cairo400Style20.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).patient_information,
                      style: AppTextStyles.cairo400Style20.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      labelText: S.of(context).full_name,
                      controller: _patientNameController,
                      keyboardType: TextInputType.name,
                      suffixIcon: const Icon(Icons.person_outline),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).please_enter_patient_name;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      labelText: S.of(context).phone,
                      controller: _patientPhoneController,
                      keyboardType: TextInputType.phone,
                      suffixIcon: const Icon(Icons.phone_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).please_enter_phone_number;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(24),
            child: BlocBuilder<AppointmentCubit, AppointmentState>(
              builder: (context, state) => CustomButton(
                text: state is AppointmentLoading
                    ? S.of(context).booking
                    : S.of(context).confirm_appointment,
                onPressed: state is AppointmentLoading
                    ? null
                    : () => _submitBooking(context),
              ),
            ),
          ),
        ),
      );

  Widget _buildDoctorCard() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(widget.doctor.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.doctor.enName,
                    style: AppTextStyles.cairo400Style20.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepBlue,
                    ),
                  ),
                  Text(
                    widget.doctor.enSpecialization,
                    style: AppTextStyles.cairo300style16.copyWith(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: AppColors.babyBlue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Today: ${DateFormat('MMM dd, yyyy').format(DateTime.now())}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.babyBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildDateTimePicker() => Container(
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
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today,
                  color: AppColors.primaryColor,),
              title: Text(
                _selectedDate != null
                    ? DateFormat('EEEE, MMM dd, yyyy').format(_selectedDate!)
                    : S.of(context).select_appointment_date,
                style: AppTextStyles.cairo300style16,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                );
                if (picked != null) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading:
                  const Icon(Icons.access_time, color: AppColors.primaryColor),
              title: Text(
                _selectedTime != null
                    ? _selectedTime!.format(context)
                    : S.of(context).select_appointment_time,
                style: AppTextStyles.cairo300style16,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime ?? TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    _selectedTime = picked;
                  });
                }
              },
            ),
          ],
        ),
      );

  void _submitBooking(BuildContext context) {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).select_appointment_date),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final homeCubit = context.read<HomeCubit>();
    final user = homeCubit.originalUser;
    final schedule = widget.doctor.getNextAvailableSlot();

    // Combine date and time
    final appointmentDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final appointment = AppointmentModel(
      id: const Uuid().v4(),
      doctorId: widget.doctor.docId ?? widget.doctor.id.toString(),
      doctorName: widget.doctor.enName,
      userId: user?.email ?? 'anonymous',
      patientName: _patientNameController.text,
      patientPhone: _patientPhoneController.text,
      doctorSpecialty: widget.doctor.enSpecialization,
      date: DateFormat('yyyy-MM-dd').format(appointmentDateTime),
      time: DateFormat('HH:mm').format(appointmentDateTime),
      status: 'pending',
      doctorWorkingDay: schedule?.dayName ?? 'N/A',
      doctorWorkingHours: schedule != null
          ? '${schedule.startTime} - ${schedule.endTime}'
          : 'N/A',
      bookingCreatedAt: DateTime.now().toIso8601String(),
      userData: user?.toMap() ?? {},
      doctorData: widget.doctor.toMap(),
    );
    context.read<AppointmentCubit>().bookAppointment(appointment);
  }
}
