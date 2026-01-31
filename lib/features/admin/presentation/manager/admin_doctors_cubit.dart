import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/core/services/notification_service.dart';
import 'package:medical_center/core/utils/app_strings.dart';
import 'package:medical_center/features/home/data/models/category_model.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';

// States
abstract class AdminDoctorsState {}

class AdminDoctorsInitial extends AdminDoctorsState {}

class AdminDoctorsLoading extends AdminDoctorsState {}

class AdminDoctorsLoaded extends AdminDoctorsState {
  AdminDoctorsLoaded(this.doctors);
  final List<DoctorsModel> doctors;
}

class AdminDoctorsOperationSuccess extends AdminDoctorsLoaded {
  AdminDoctorsOperationSuccess(this.message, super.doctors);
  final String message;
}

class AdminDoctorsError extends AdminDoctorsState {
  AdminDoctorsError(this.message);
  final String message;
}

/// Manages admin operations for doctor management.
///
/// This cubit handles:
/// - Loading all doctors with real-time updates
/// - Adding new doctors with auto-generated IDs
/// - Updating existing doctor information
/// - Deleting doctors from the system
/// - Loading specialities for doctor assignment
///
/// **Real-time Updates:**
/// Uses Firestore snapshots for live data synchronization.
///
/// **Usage:**
/// ```dart
/// final cubit = context.read<AdminDoctorsCubit>();
/// await cubit.getAllDoctors();
/// await cubit.addDoctor(doctorModel);
/// ```
class AdminDoctorsCubit extends Cubit<AdminDoctorsState> {
  AdminDoctorsCubit() : super(AdminDoctorsInitial());

  final _logger = LoggerService('AdminDoctorsCubit');
  final CollectionReference doctorsCollection =
      FirebaseFirestore.instance.collection(FirebaseStrings.doctors);

  /// Stream subscription for real-time doctors updates.
  StreamSubscription<QuerySnapshot>? _doctorSubscription;

  /// Internal list of all doctors.
  List<DoctorsModel> _allDoctors = [];
  List<DoctorsModel> _filteredDoctors = [];
  String _searchQuery = '';

  /// Loads all doctors with real-time updates.
  ///
  /// Sets up a Firestore snapshot listener to automatically receive
  /// updates when doctors are added, modified, or removed.
  ///
  /// **Important:** Cancels previous subscription to prevent memory leaks.
  ///
  /// Emits [AdminDoctorsLoading] initially, then [AdminDoctorsLoaded]
  /// with the complete doctors list, or [AdminDoctorsError] on failure.
  Future<void> getAllDoctors() async {
    emit(AdminDoctorsLoading());
    _logger.info('Loading all doctors for admin management');

    try {
      await _doctorSubscription?.cancel();
      _doctorSubscription = doctorsCollection.snapshots().listen(
        (snapshot) {
          _allDoctors = snapshot.docs.map(DoctorsModel.fromFirestore).toList();
          _logger.info('Loaded ${_allDoctors.length} doctors');
          _applySearch();
        },
        onError: (error, stackTrace) {
          _logger.error('Error in doctors stream', error, stackTrace);
          emit(AdminDoctorsError(error.toString()));
        },
      );
    } catch (e, stackTrace) {
      _logger.error('Failed to setup doctors stream', e, stackTrace);
      emit(AdminDoctorsError(e.toString()));
    }
  }

  /// Adds a new doctor to the system.
  ///
  /// Automatically generates a unique ID based on existing doctors.
  /// The ID is incremented from the highest existing doctor ID.
  ///
  /// **Parameters:**
  /// - [doctor]: Doctor model with all information (ID will be auto-generated)
  ///
  /// **Process:**
  /// 1. Ensures doctors list is loaded
  /// 2. Generates new unique ID
  /// 3. Creates doctor document with generated ID as document key
  /// 4. Real-time listener automatically updates the list
  ///
  /// Emits [AdminDoctorsOperationSuccess] with message on success,
  /// or [AdminDoctorsError] on failure.
  Future<void> addDoctor(DoctorsModel doctor) async {
    emit(AdminDoctorsLoading());
    _logger.info('Adding new doctor: ${doctor.enName}');

    try {
      if (_allDoctors.isEmpty) await getAllDoctors();

      final newId = _allDoctors.isEmpty
          ? 1
          : _allDoctors.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;

      final newDoctor = doctor.copyWith(id: newId);
      _logger.debug('Generated new doctor ID: $newId');

      await doctorsCollection.doc(newId.toString()).set(newDoctor.toMap());

      _logger.info('Doctor added successfully: ${doctor.enName} (ID: $newId)');
      emit(
        AdminDoctorsOperationSuccess(
          'Doctor added successfully',
          _allDoctors,
        ),
      );
    } catch (e, stackTrace) {
      _logger.error('Failed to add doctor', e, stackTrace);
      emit(AdminDoctorsError(e.toString()));
    }
  }

  /// Updates an existing doctor's information.
  ///
  /// Uses the doctor's Firestore document ID (docId) if available,
  /// otherwise falls back to using the integer ID as string.
  ///
  /// **Parameters:**
  /// - [doctor]: Updated doctor model with all new information
  ///
  /// **Important:** The real-time listener will automatically
  /// update the UI after this operation completes.
  ///
  /// Emits [AdminDoctorsOperationSuccess] with message on success,
  /// or [AdminDoctorsError] on failure.
  Future<void> updateDoctor(DoctorsModel doctor) async {
    emit(AdminDoctorsLoading());
    final docKey = doctor.docId ?? doctor.id.toString();
    _logger.info('Updating doctor: ${doctor.enName} (doc: $docKey)');

    try {
      await doctorsCollection.doc(docKey).update(doctor.toMap());
      _logger.info('Doctor updated successfully: ${doctor.enName}');

      // Notify users if availability changed
      await NotificationService().sendBroadcastNotification(
        title: 'Doctor Status Update',
        body: "Important update regarding Dr. ${doctor.enName}'s availability.",
        data: {'type': 'doctor_update', 'id': doctor.id},
      );

      emit(
        AdminDoctorsOperationSuccess(
          'Doctor updated successfully',
          _allDoctors,
        ),
      );
    } catch (e, stackTrace) {
      _logger.error('Failed to update doctor', e, stackTrace);
      emit(AdminDoctorsError(e.toString()));
    }
  }

  // Specialities
  List<SpecialityModel> specialities = [];

  Future<void> getSpecialities() async {
    // Only fetch if empty to avoid unnecessary reads
    if (specialities.isNotEmpty) return;

    emit(AdminDoctorsLoading());
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('specialities').get();
      specialities = snapshot.docs
          .map((doc) => SpecialityModel.fromJson(doc.data()))
          .toList();
      emit(
        AdminDoctorsLoaded(
          _allDoctors,
        ),
      ); // Re-emit loaded state with doctors, but now specialities are ready
    } catch (e) {
      emit(AdminDoctorsError(e.toString()));
    }
  }

  /// Deletes a doctor from the system.
  ///
  /// Permanently removes the doctor document from Firestore.
  /// The real-time listener will automatically update the UI.
  ///
  /// **Parameters:**
  /// - [doctor]: The doctor to delete
  ///
  /// **Warning:** This operation cannot be undone.
  ///
  /// Emits [AdminDoctorsOperationSuccess] with message on success,
  /// or [AdminDoctorsError] on failure.
  Future<void> deleteDoctor(DoctorsModel doctor) async {
    emit(AdminDoctorsLoading());
    final docKey = doctor.docId ?? doctor.id.toString();
    _logger.info('Deleting doctor: ${doctor.enName} (doc: $docKey)');

    try {
      await doctorsCollection.doc(docKey).delete();
      _logger.info('Doctor deleted successfully: ${doctor.enName}');
      emit(
        AdminDoctorsOperationSuccess(
          'Doctor deleted successfully',
          _allDoctors,
        ),
      );
    } catch (e, stackTrace) {
      _logger.error('Failed to delete doctor', e, stackTrace);
      emit(AdminDoctorsError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _logger.info('Closing AdminDoctorsCubit and cancelling subscriptions');
    _doctorSubscription?.cancel();
    return super.close();
  }

  /// Searches doctors by name or specialty.
  void searchDoctors(String query) {
    _searchQuery = query.toLowerCase();
    _applySearch();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredDoctors = _allDoctors;
    } else {
      _filteredDoctors = _allDoctors
          .where(
            (doctor) =>
                doctor.enName.toLowerCase().contains(_searchQuery) ||
                doctor.arName.toLowerCase().contains(_searchQuery) ||
                doctor.enSpecialization.toLowerCase().contains(_searchQuery) ||
                doctor.arSpecialization.toLowerCase().contains(_searchQuery),
          )
          .toList();
    }
    emit(AdminDoctorsLoaded(_filteredDoctors));
  }
}
