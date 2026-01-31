import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/features/home/data/models/category_model.dart';

abstract class AdminSpecialitiesState {}

class AdminSpecialitiesInitial extends AdminSpecialitiesState {}

class AdminSpecialitiesLoading extends AdminSpecialitiesState {}

class AdminSpecialitiesLoaded extends AdminSpecialitiesState {
  AdminSpecialitiesLoaded(this.specialities);
  final List<SpecialityModel> specialities;
}

class AdminSpecialitiesOperationSuccess extends AdminSpecialitiesLoaded {
  AdminSpecialitiesOperationSuccess(this.message, super.specialities);
  final String message;
}

class AdminSpecialitiesError extends AdminSpecialitiesState {
  AdminSpecialitiesError(this.message);
  final String message;
}

/// Manages admin operations for medical specialities.
///
/// This cubit handles:
/// - Loading all specialities with real-time updates
/// - Adding new specialities
/// - Deleting existing specialities
///
/// Uses Firestore snapshots for live data synchronization.
class AdminSpecialitiesCubit extends Cubit<AdminSpecialitiesState> {
  AdminSpecialitiesCubit() : super(AdminSpecialitiesInitial());

  final _logger = LoggerService('AdminSpecialitiesCubit');
  final CollectionReference specialitiesCollection =
      FirebaseFirestore.instance.collection('specialities');

  StreamSubscription<QuerySnapshot>? _specialitiesSubscription;

  List<SpecialityModel> _allSpecialities = [];

  /// Loads all specialities with real-time updates.
  Future<void> getSpecialities() async {
    emit(AdminSpecialitiesLoading());
    _logger.info('Loading all specialities');
    try {
      await _specialitiesSubscription?.cancel();
      _specialitiesSubscription =
          specialitiesCollection.snapshots().listen((snapshot) {
        _allSpecialities = snapshot.docs
            .map(
              (doc) =>
                  SpecialityModel.fromJson(doc.data()! as Map<String, dynamic>),
            )
            .toList();
        _logger.info('Loaded ${_allSpecialities.length} specialities');
        emit(AdminSpecialitiesLoaded(_allSpecialities));
      });
    } catch (e) {
      _logger.error('Error loading specialities', e);
      emit(AdminSpecialitiesError(e.toString()));
    }
  }

  /// Adds a new speciality to the system.
  Future<void> addSpeciality(SpecialityModel speciality) async {
    emit(AdminSpecialitiesLoading());
    _logger.info('Adding new speciality: ${speciality.enCategoryName}');
    try {
      final newId = _allSpecialities.isEmpty
          ? 1
          : _allSpecialities.map((e) => e.id).reduce((a, b) => a > b ? a : b) +
              1;

      final newSpec = SpecialityModel(
        id: newId,
        enCategoryName: speciality.enCategoryName,
        arCategoryName: speciality.arCategoryName,
        image: speciality.image,
      );

      await specialitiesCollection.doc(newId.toString()).set(newSpec.toMap());
      _logger.info('Speciality added successfully with ID: $newId');
      emit(
        AdminSpecialitiesOperationSuccess(
          'Speciality added successfully',
          _allSpecialities,
        ),
      );
    } catch (e) {
      _logger.error('Error adding speciality', e);
      emit(AdminSpecialitiesError(e.toString()));
    }
  }

  /// Deletes a speciality from the system.
  Future<void> deleteSpeciality(int id) async {
    emit(AdminSpecialitiesLoading());
    _logger.info('Deleting speciality with ID: $id');
    try {
      await specialitiesCollection.doc(id.toString()).delete();
      _logger.info('Speciality deleted successfully');
      emit(
        AdminSpecialitiesOperationSuccess(
          'Speciality deleted successfully',
          _allSpecialities,
        ),
      );
    } catch (e) {
      _logger.error('Error deleting speciality', e);
      emit(AdminSpecialitiesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _logger.info('Closing AdminSpecialitiesCubit');
    _specialitiesSubscription?.cancel();
    return super.close();
  }
}
