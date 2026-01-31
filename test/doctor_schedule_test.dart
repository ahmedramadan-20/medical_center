import 'package:flutter_test/flutter_test.dart';
import 'package:medical_center/features/home/data/models/doctor_schedule_model.dart';

void main() {
  group('Doctor Schedule Logic', () {
    test('isOpen returns true when current time is within schedule', () {
      const schedule = DoctorScheduleModel(
        dayOfWeek: 1, // Monday
        startTime: '09:00',
        endTime: '17:00',
      );

      // Monday 10:00 AM
      final monday = DateTime(2023, 10, 23, 10); // Oct 23 2023 is Monday
      expect(schedule.isOpen(monday), true);
    });

    test('isOpen returns false when current time is outside schedule', () {
      const schedule = DoctorScheduleModel(
        dayOfWeek: 1, // Monday
        startTime: '09:00',
        endTime: '17:00',
      );

      // Monday 08:00 AM
      final mondayEarly = DateTime(2023, 10, 23, 8);
      expect(schedule.isOpen(mondayEarly), false);

      // Monday 18:00 PM
      final mondayLate = DateTime(2023, 10, 23, 18);
      expect(schedule.isOpen(mondayLate), false);
    });

    test('isOpen returns false when day does not match', () {
      const schedule = DoctorScheduleModel(
        dayOfWeek: 1, // Monday
        startTime: '09:00',
        endTime: '17:00',
      );

      // Tuesday 10:00 AM
      final tuesday = DateTime(2023, 10, 24, 10);
      expect(schedule.isOpen(tuesday), false);
    });
  });

  group('DoctorsModel getNextAvailableSlot', () {
    // Note: This test is tricky because getNextAvailableSlot uses DateTime.now() internally
    // ideally the method should accept a 'now' parameter for testing.
    // For this test, we'll assume the method logic is purely sorting-based and works relative to "now".
    // To properly test, we might need to refactor getNextAvailableSlot to accept an optional DateTime.
  });
}
