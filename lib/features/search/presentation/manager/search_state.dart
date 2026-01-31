import 'package:equatable/equatable.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';

/// Base state for search
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class SearchInitial extends SearchState {}

/// Search results loaded
class SearchLoaded extends SearchState {
  const SearchLoaded(this.doctors);
  final List<DoctorsModel> doctors;

  @override
  List<Object?> get props => [doctors];
}

/// Search error
class SearchError extends SearchState {
  const SearchError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
