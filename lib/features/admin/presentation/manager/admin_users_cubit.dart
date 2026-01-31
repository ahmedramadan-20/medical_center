import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/features/home/data/models/user_model.dart';

abstract class AdminUsersState {}

class AdminUsersInitial extends AdminUsersState {}

class AdminUsersLoading extends AdminUsersState {}

class AdminUsersLoaded extends AdminUsersState {
  AdminUsersLoaded(this.users);
  final List<UserModel> users;
}

class AdminUsersOperationSuccess extends AdminUsersLoaded {
  AdminUsersOperationSuccess(this.message, super.users);
  final String message;
}

class AdminUsersError extends AdminUsersState {
  AdminUsersError(this.message);
  final String message;
}

/// Manages admin operations for user management.
///
/// This cubit handles:
/// - Loading all users with real-time updates
/// - Toggling admin status for users
/// - Deleting users from the system
///
/// Uses Firestore snapshots for live data synchronization.
class AdminUsersCubit extends Cubit<AdminUsersState> {
  AdminUsersCubit() : super(AdminUsersInitial());

  final _logger = LoggerService('AdminUsersCubit');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  StreamSubscription<QuerySnapshot>? _usersSubscription;

  List<UserModel> _allUsers = [];
  List<UserModel> _filteredUsers = [];
  String _searchQuery = '';

  /// Loads all users with real-time updates.
  Future<void> getUsers() async {
    emit(AdminUsersLoading());
    _logger.info('Loading all users');
    try {
      await _usersSubscription?.cancel();
      _usersSubscription = usersCollection.snapshots().listen((snapshot) {
        _allUsers = snapshot.docs
            .map(
              (doc) => UserModel.fromJson(doc.data()! as Map<String, dynamic>),
            )
            .toList();
        _logger.info('Loaded ${_allUsers.length} users');
        _applySearch();
      });
    } catch (e) {
      _logger.error('Error loading users', e);
      emit(AdminUsersError(e.toString()));
    }
  }

  /// Toggles admin status for a user.
  Future<void> toggleAdminStatus(String email, bool currentStatus) async {
    emit(AdminUsersLoading());
    _logger.info('Toggling admin status for $email');
    try {
      final query =
          await usersCollection.where('email', isEqualTo: email).get();
      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.update({'isAdmin': !currentStatus});
        _logger.info('Admin status updated for $email');
        emit(AdminUsersOperationSuccess('Admin status updated', _allUsers));
      } else {
        _logger.warning('User not found: $email');
        emit(AdminUsersError('User not found'));
      }
    } catch (e) {
      _logger.error('Error updating admin status', e);
      emit(AdminUsersError(e.toString()));
    }
  }

  /// Deletes a user from the system.
  Future<void> deleteUser(String email) async {
    emit(AdminUsersLoading());
    _logger.info('Deleting user: $email');
    try {
      final query =
          await usersCollection.where('email', isEqualTo: email).get();
      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.delete();
        _logger.info('User deleted successfully: $email');
        emit(
          AdminUsersOperationSuccess('User deleted successfully', _allUsers),
        );
      } else {
        _logger.warning('User not found: $email');
        emit(AdminUsersError('User not found'));
      }
    } catch (e) {
      _logger.error('Error deleting user', e);
      emit(AdminUsersError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _logger.info('Closing AdminUsersCubit');
    _usersSubscription?.cancel();
    return super.close();
  }

  /// Searches users by name or email.
  void searchUsers(String query) {
    _searchQuery = query.toLowerCase();
    _applySearch();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredUsers = _allUsers;
    } else {
      _filteredUsers = _allUsers
          .where(
            (user) =>
                user.firstName.toLowerCase().contains(_searchQuery) ||
                user.lastName.toLowerCase().contains(_searchQuery) ||
                user.email.toLowerCase().contains(_searchQuery),
          )
          .toList();
    }
    emit(AdminUsersLoaded(_filteredUsers));
  }
}
