import 'package:flutter_test/flutter_test.dart';
import 'package:medical_center/features/home/data/models/doctor_schedule_model.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';

void main() {
  group('DoctorsModel Scheduling Logic', () {
    test('getNextAvailableSlot returns today if available now', () {
      final now = DateTime.now();
      final todayWeekday = now.weekday;

      // Create a schedule for TODAY that ends late tonight
      final schedule = DoctorScheduleModel(
        dayOfWeek: todayWeekday,
        startTime: '00:00', // Started start of day
        endTime: '23:59', // Ends end of day
      );

      final doctor = DoctorsModel(
        id: 1,
        specializationId: 1,
        arName: 'Test',
        enName: 'Test',
        arSpecialization: 'Spec',
        enSpecialization: 'Spec',
        image: '',
        isAvailable: true,
        numberOfPatients: 0,
        schedules: [schedule],
      );

      final nextSlot = doctor.getNextAvailableSlot();
      expect(nextSlot, isNotNull);
      expect(nextSlot!.dayOfWeek, equals(todayWeekday));
    });

    test('getNextAvailableSlot skips today if time is past endTime', () {
      final now = DateTime.now();
      final todayWeekday = now.weekday;

      final earlySchedule = DoctorScheduleModel(
        dayOfWeek: todayWeekday,
        startTime: '00:00',
        endTime: '00:01',
      );

      // Find next day weekday
      final nextDayWeekday = (todayWeekday % 7) + 1;
      final nextDaySchedule = DoctorScheduleModel(
        dayOfWeek: nextDayWeekday,
        startTime: '09:00',
        endTime: '17:00',
      );

      final doctor = DoctorsModel(
        id: 1,
        specializationId: 1,
        arName: 'Test',
        enName: 'Test',
        arSpecialization: 'Spec',
        enSpecialization: 'Spec',
        image: '',
        isAvailable: true,
        numberOfPatients: 0,
        schedules: [earlySchedule, nextDaySchedule],
      );

      // Assuming test runs after 00:01
      if (now.hour > 0 || now.minute > 1) {
        final nextSlot = doctor.getNextAvailableSlot();
        expect(nextSlot!.dayOfWeek, equals(nextDayWeekday));
      }
    });

    test('getNextAvailableSlot wraps around to next week', () {
      final now = DateTime.now();
      final todayWeekday = now.weekday;

      // Only schedule is yesterday (or a previous day in week order)
      var yesterday = todayWeekday - 1;
      if (yesterday < 1) yesterday = 7;

      final schedule = DoctorScheduleModel(
        dayOfWeek: yesterday,
        startTime: '09:00',
        endTime: '17:00',
      );

      final doctor = DoctorsModel(
        id: 1,
        specializationId: 1,
        arName: 'Test',
        enName: 'Test',
        arSpecialization: 'Spec',
        enSpecialization: 'Spec',
        image: '',
        isAvailable: true,
        numberOfPatients: 0,
        schedules: [schedule],
      );

      final nextSlot = doctor.getNextAvailableSlot();
      expect(nextSlot!.dayOfWeek, equals(yesterday));
    });
  });
}
