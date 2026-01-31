import 'package:flutter_test/flutter_test.dart';
import 'package:medical_center/app/medical_center_app.dart';
import 'package:medical_center/core/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Widget tests don't have real platform plugins.
    // Mock SharedPreferences so our service locator can register it.
    SharedPreferences.setMockInitialValues(<String, Object>{});

    // The app relies on GetIt registrations (LocaleCubit, etc.).
    // In production this is done before runApp; in tests we must do it manually.
    await setupServiceLocator();
  });

  testWidgets('App smoke test (builds without crashing)', (tester) async {
    await tester.pumpWidget(const MedicalCenter());

    // Pump a frame. We intentionally do NOT use pumpAndSettle() here because
    // the Splash screen schedules a delayed navigation timer.
    await tester.pump();

    // If we got here, the widget tree built successfully.
    expect(find.byType(MedicalCenter), findsOneWidget);
  });
}
