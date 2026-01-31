import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/core/utils/app_assets.dart';
import 'package:medical_center/core/utils/app_strings.dart';
import 'package:medical_center/core/utils/time_formatter.dart';
import 'package:medical_center/features/home/data/models/category_model.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';
import 'package:medical_center/features/home/data/models/user_model.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_state.dart';
import 'package:medical_center/generated/l10n.dart';

/// Manages the home screen state and business logic.
///
/// This cubit follows clean architecture principles and handles:
/// - Real-time doctor data from Firestore with snapshots
/// - Category-based filtering of doctors
/// - User profile data loading
/// - Speciality/category management
///
/// **Memory Management:**
/// Properly cancels stream subscriptions in [close()] to prevent leaks.
///
/// **Usage:**
/// ```dart
/// final cubit = HomeCubit();
/// await cubit.initHome(context);
/// ```
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final _logger = LoggerService('HomeCubit');

  /// Stream subscription for real-time doctor updates.
  /// Cancelled in [close()] to prevent memory leaks.
  StreamSubscription<QuerySnapshot>? _doctorSubscription;

  /// Complete list of all doctors loaded from Firestore.
  List<DoctorsModel> allDoctors = [];

  /// Filtered list of doctors based on selected category.
  List<DoctorsModel> filteredDoctors = [];

  /// List of specialities loaded from Firestore.
  /// First item (index 0) should be "All" speciality.
  List<SpecialityModel> specialities = [];

  /// Currently selected category index (0 = "All").
  int selectedIndex = 0;

  /// Current user's profile data.
  UserModel? originalUser;

  /// Returns localized categories for display in the UI.
  ///
  /// This is a UI-only list for displaying category cards.
  /// The actual filtering uses [specialities] from Firestore.
  List<CategoryModel> categoryList(BuildContext context) => [
        CategoryModel(categoryName: S.of(context).all, image: AppAssets.all),
        CategoryModel(
          categoryName: S.of(context).general_surgery,
          image: AppAssets.generalSurgery,
        ),
        CategoryModel(
          categoryName: S.of(context).pediatrics,
          image: AppAssets.pediatrics,
        ),
        CategoryModel(
          categoryName: S.of(context).ent,
          image: AppAssets.earNoseAndThroatENT,
        ),
        CategoryModel(
          categoryName: S.of(context).dentistry,
          image: AppAssets.dentistry,
        ),
        CategoryModel(
          categoryName: S.of(context).dermatology,
          image: AppAssets.dermatology,
        ),
        CategoryModel(
          categoryName: S.of(context).obgyn,
          image: AppAssets.obstetricsAndGynecology,
        ),
        CategoryModel(
          categoryName: S.of(context).internal_medicine,
          image: AppAssets.internalMedicine,
        ),
        CategoryModel(
          categoryName: S.of(context).nutrition_therapy,
          image: AppAssets.nutritionalTherapy,
        ),
        CategoryModel(
          categoryName: S.of(context).rheumatology_joint,
          image: AppAssets.rheumatologyAndJoint,
        ),
        CategoryModel(
          categoryName: S.of(context).ophthalmology,
          image: AppAssets.ophthalmology,
        ),
        CategoryModel(
          categoryName: S.of(context).cardiology,
          image: AppAssets.cardiology,
        ),
        CategoryModel(
          categoryName: S.of(context).nephrology_urology,
          image: AppAssets.nephrologyAndUrology,
        ),
        CategoryModel(
          categoryName: S.of(context).speech_behavior_modification,
          image: AppAssets.speechAndBehaviorModification,
        ),
        CategoryModel(
          categoryName: S.of(context).neurology,
          image: AppAssets.neurology,
        ),
      ];

  /// Fetches the current user's profile data from Firestore.
  ///
  /// Queries by the authenticated user's email and loads their profile.
  /// Emits [GetUserDataSuccessState] on success or [GetUserDataErrorState] on failure.
  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());

    try {
      final currentUserEmail = FirebaseAuth.instance.currentUser?.email;

      if (currentUserEmail == null) {
        _logger.warning('No authenticated user found');
        emit(GetUserDataErrorState(error: 'No authenticated user'));
        return;
      }

      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: currentUserEmail)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        _logger.warning('User document not found for $currentUserEmail');
        emit(GetUserDataErrorState(error: S.current.no_user_found));
        return;
      }

      originalUser = UserModel.fromJson(querySnapshot.docs.first.data());
      _logger.info('User data loaded successfully');
      emit(GetUserDataSuccessState(originalUser));
    } catch (error, stackTrace) {
      _logger.error('Failed to load user data', error, stackTrace);
      emit(GetUserDataErrorState(error: error.toString()));
    }
  }

  /// Loads specialities from Firestore.
  ///
  /// Specialities are used for category-based filtering of doctors.
  /// Emits [GetSpecialitiesSuccessState] on success.
  Future<void> getSpecialities() async {
    emit(GetSpecialitiesLoadingState());

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('specialities')
          .orderBy('id') // Ensure consistent ordering
          .get();

      specialities = querySnapshot.docs
          .map((doc) => SpecialityModel.fromJson(doc.data()))
          .toList();

      _logger.info('Loaded ${specialities.length} specialities');
      emit(GetSpecialitiesSuccessState());
    } catch (error, stackTrace) {
      _logger.error('Failed to load specialities', error, stackTrace);
      emit(GetSpecialitiesErrorState(error: error.toString()));
    }
  }

  /// Loads all doctors from Firestore with real-time updates.
  ///
  /// Uses Firestore snapshots to get real-time updates when doctors are added,
  /// modified, or removed. Automatically filters doctors based on selected category.
  ///
  /// **Important:** Cancels previous subscription to prevent memory leaks.
  Future<void> getAllDoctorsData() async {
    try {
      emit(GetDoctorsLoadingState());

      // Cancel any existing subscription to prevent memory leaks
      await _doctorSubscription?.cancel();

      _doctorSubscription = FirebaseFirestore.instance
          .collection(FirebaseStrings.doctors)
          .snapshots()
          .listen(
        (snapshot) {
          allDoctors = snapshot.docs.map(DoctorsModel.fromFirestore).toList();
          _filterDoctors();
          _logger.info('Loaded ${allDoctors.length} doctors');
          emit(GetDoctorsSuccessState());
        },
        onError: (error, stackTrace) {
          _logger.error('Error in doctors stream', error, stackTrace);
          emit(GetDoctorsErrorState(error: error.toString()));
        },
      );
    } catch (error, stackTrace) {
      _logger.error('Failed to setup doctors stream', error, stackTrace);
      emit(GetDoctorsErrorState(error: error.toString()));
    }
  }

  /// Filters doctors based on the currently selected category.
  ///
  /// - If [selectedIndex] is 0, shows all doctors ("All" category)
  /// - Otherwise, filters by matching [specializationId]
  ///
  /// This is called automatically after:
  /// - Loading doctors from Firestore
  /// - Changing the selected category via [changeIndex]
  void _filterDoctors() {
    if (selectedIndex == 0) {
      // Show all doctors - "All" category
      filteredDoctors = List.from(allDoctors);
    } else {
      // Filter by selected speciality
      if (specialities.isNotEmpty && selectedIndex < specialities.length) {
        final selectedSpecialityId = specialities[selectedIndex].id;
        filteredDoctors = allDoctors
            .where((doctor) => doctor.specializationId == selectedSpecialityId)
            .toList();
      } else {
        // Fallback: show all if index is out of range
        filteredDoctors = List.from(allDoctors);
        _logger.warning(
          'Selected index $selectedIndex out of range (${specialities.length})',
        );
      }
    }

    _logger.debug('Filtered to ${filteredDoctors.length} doctors');
  }

  /// Changes the selected category and triggers filtering.
  ///
  /// Call this when user taps a category chip/button.
  void changeIndex(int index) {
    if (index == selectedIndex) return; // No change needed

    selectedIndex = index;
    _filterDoctors();

    // Emit explicit states so the UI updates immediately.
    emit(ChangeCategoryState());
    emit(DoctorsFilteredState());

    _logger.debug('Category changed to index $index');
  }

  /// Formats working hours with localized day names.
  ///
  /// Converts a map of working hours to localized strings.
  /// Example: {'monday': {'start': '09:00', 'end': '17:00'}}
  /// becomes {'monday': 'Monday: 9:00 AM - 5:00 PM'}
  Map<String, String> formatLocalizedHours(
    Map<String, dynamic> workingHours,
    BuildContext context,
  ) {
    final localizedHours = <String, String>{};

    workingHours.forEach((day, hours) {
      final start = hours['start'] as String;
      final end = hours['end'] as String;
      localizedHours[day] =
          '${_localizedDay(day, context)}: ${TimeFormatter.formatTimeRange(start, end, context)} ';
    });

    return localizedHours;
  }

  /// Converts a list of day names to localized day names.
  ///
  /// Example: ['monday', 'tuesday'] becomes ['Monday', 'Tuesday'] in English
  /// or ['الإثنين', 'الثلاثاء'] in Arabic.
  List<String> formatLocalizedDays(
    List<String> workingDays,
    BuildContext context,
  ) =>
      workingDays.map((day) => _localizedDay(day, context)).toList();

  /// Converts an English day name to a localized day name.
  ///
  /// Uses [DateFormat.EEEE] with the current locale to get the localized name.
  String _localizedDay(String day, BuildContext context) =>
      DateFormat.EEEE(Localizations.localeOf(context).languageCode).format(
        DateTime.now().subtract(
          Duration(days: DateTime.now().weekday - _dayNumber(day)),
        ),
      );

  /// Converts day name to weekday number (1=Monday, 7=Sunday).
  int _dayNumber(String day) {
    switch (day.toLowerCase()) {
      case 'sunday':
        return DateTime.sunday;
      case 'monday':
        return DateTime.monday;
      case 'tuesday':
        return DateTime.tuesday;
      case 'wednesday':
        return DateTime.wednesday;
      case 'thursday':
        return DateTime.thursday;
      case 'friday':
        return DateTime.friday;
      case 'saturday':
        return DateTime.saturday;
      default:
        return DateTime.monday;
    }
  }

  /// Initializes all home screen data.
  ///
  /// Loads user data, specialities, and doctors in sequence.
  /// Call this in the home screen's [initState] or when refreshing data.
  ///
  /// **Usage:**
  /// ```dart
  /// @override
  /// void initState() {
  ///   super.initState();
  ///   context.read<HomeCubit>().initHome(context);
  /// }
  /// ```
  Future<void> initHome() async {
    _logger.info('Initializing home screen data');
    await getUserData();
    await getSpecialities();
    await getAllDoctorsData();
  }

  @override
  Future<void> close() {
    _logger.info('Closing HomeCubit and cancelling subscriptions');
    _doctorSubscription?.cancel();
    return super.close();
  }
}
