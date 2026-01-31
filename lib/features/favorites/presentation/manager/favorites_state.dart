import 'package:equatable/equatable.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';

/// Base state for favorites
abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class FavoritesInitial extends FavoritesState {}

/// Loading favorites
class FavoritesLoading extends FavoritesState {}

/// Favorites loaded successfully
class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded(this.doctors);
  final List<DoctorsModel> doctors;

  @override
  List<Object?> get props => [doctors];
}

/// Favorite added
class FavoriteAdded extends FavoritesState {
  const FavoriteAdded(this.doctorId);
  final String doctorId;

  @override
  List<Object?> get props => [doctorId];
}

/// Favorite removed
class FavoriteRemoved extends FavoritesState {
  const FavoriteRemoved(this.doctorId);
  final String doctorId;

  @override
  List<Object?> get props => [doctorId];
}

/// Error state
class FavoritesError extends FavoritesState {
  const FavoritesError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
