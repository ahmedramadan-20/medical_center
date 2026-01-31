import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';
import 'package:medical_center/features/search/presentation/manager/search_state.dart';

/// Cubit for managing doctor search and filtering.
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  List<DoctorsModel> _allDoctors = [];
  List<DoctorsModel> _filteredDoctors = [];

  String _searchQuery = '';
  String? _selectedSpecialty;
  double? _minRating;
  double? _maxPrice;
  bool? _availableOnly;

  List<DoctorsModel> get filteredDoctors => _filteredDoctors;

  /// Initialize search with all doctors
  void initializeSearch(List<DoctorsModel> doctors) {
    _allDoctors = doctors;
    _filteredDoctors = doctors;
    emit(SearchLoaded(_filteredDoctors));
  }

  /// Update search query
  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  /// Filter by specialty
  void filterBySpecialty(String? specialty) {
    _selectedSpecialty = specialty;
    _applyFilters();
  }

  /// Filter by minimum rating
  void filterByRating(double? rating) {
    _minRating = rating;
    _applyFilters();
  }

  /// Filter by maximum price
  void filterByPrice(double? price) {
    _maxPrice = price;
    _applyFilters();
  }

  /// Filter by availability
  void filterByAvailability(bool? available) {
    _availableOnly = available;
    _applyFilters();
  }

  /// Clear all filters
  void clearFilters() {
    _searchQuery = '';
    _selectedSpecialty = null;
    _minRating = null;
    _maxPrice = null;
    _availableOnly = null;
    _applyFilters();
  }

  /// Apply all active filters
  void _applyFilters() {
    _filteredDoctors = _allDoctors.where((doctor) {
      // Search query filter (name or specialty)
      if (_searchQuery.isNotEmpty) {
        final nameMatch = doctor.enName.toLowerCase().contains(_searchQuery) ||
            doctor.arName.toLowerCase().contains(_searchQuery);
        final specialtyMatch =
            doctor.enSpecialization.toLowerCase().contains(_searchQuery) ||
                doctor.arSpecialization.toLowerCase().contains(_searchQuery);
        if (!nameMatch && !specialtyMatch) return false;
      }

      // Specialty filter
      if (_selectedSpecialty != null &&
          _selectedSpecialty!.isNotEmpty &&
          _selectedSpecialty != 'all') {
        if (doctor.specializationId.toString() != _selectedSpecialty) {
          return false;
        }
      }

      // Rating filter
      final minRating = _minRating;
      if (minRating != null && doctor.averageRating < minRating) {
        return false;
      }

      // Price filter
      final maxPrice = _maxPrice;
      if (maxPrice != null && doctor.ticketPrice > maxPrice) {
        return false;
      }

      // Availability filter
      if ((_availableOnly ?? false) && !doctor.isAvailable) {
        return false;
      }

      return true;
    }).toList();

    // Sort by rating (highest first) if no search query
    if (_searchQuery.isEmpty) {
      _filteredDoctors
          .sort((a, b) => b.averageRating.compareTo(a.averageRating));
    }

    emit(SearchLoaded(_filteredDoctors));
  }

  /// Get current filter status
  bool get hasActiveFilters =>
      _searchQuery.isNotEmpty ||
      (_selectedSpecialty != null && _selectedSpecialty != 'all') ||
      _minRating != null ||
      _maxPrice != null ||
      (_availableOnly ?? false);

  int get activeFilterCount {
    var count = 0;
    if (_searchQuery.isNotEmpty) count++;
    if (_selectedSpecialty != null && _selectedSpecialty != 'all') count++;
    if (_minRating != null) count++;
    if (_maxPrice != null) count++;
    if (_availableOnly ?? false) count++;
    return count;
  }
}
