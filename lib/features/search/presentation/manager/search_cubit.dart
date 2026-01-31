import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';
import 'package:medical_center/features/search/presentation/manager/search_history_service.dart';
import 'package:medical_center/features/search/presentation/manager/search_state.dart';

enum SearchSortType { rating, experience }

/// Cubit for managing doctor search and filtering.
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final SearchHistoryService _historyService = SearchHistoryService();
  List<DoctorsModel> _allDoctors = [];
  List<DoctorsModel> _filteredDoctors = [];
  List<String> _history = [];

  String _searchQuery = '';
  String? _selectedSpecialty;
  double? _minRating;
  double? _maxPrice;
  bool? _availableOnly;
  SearchSortType _sortType = SearchSortType.rating;

  List<DoctorsModel> get filteredDoctors => _filteredDoctors;

  /// Initialize search with all doctors and load history
  Future<void> initializeSearch(List<DoctorsModel> doctors) async {
    _allDoctors = doctors;
    _filteredDoctors = doctors;
    await _loadHistory();
    _applyFilters();
  }

  Future<void> _loadHistory() async {
    _history = await _historyService.getHistory();
  }

  /// Update search query and save to history
  Future<void> updateSearchQuery(String query) async {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isNotEmpty) {
      await _historyService.addQuery(query);
      await _loadHistory();
    }
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

  /// Change sorting type
  void updateSortType(SearchSortType sortType) {
    _sortType = sortType;
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

  /// Apply all active filters and sorting
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

    // Sorting logic
    if (_sortType == SearchSortType.rating) {
      _filteredDoctors
          .sort((a, b) => b.averageRating.compareTo(a.averageRating));
    } else if (_sortType == SearchSortType.experience) {
      _filteredDoctors
          .sort((a, b) => b.experienceYears.compareTo(a.experienceYears));
    }

    emit(SearchLoaded(_filteredDoctors, history: _history));
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
