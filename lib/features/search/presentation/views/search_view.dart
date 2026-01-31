import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:medical_center/features/home/presentation/home_cubit/home_state.dart';
import 'package:medical_center/features/home/presentation/widgets/custom_doctor_card_widget.dart';
import 'package:medical_center/features/search/presentation/manager/search_cubit.dart';
import 'package:medical_center/features/search/presentation/manager/search_state.dart';
import 'package:medical_center/generated/l10n.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) {
          final homeCubit = context.read<HomeCubit>();
          final searchCubit = SearchCubit();
          if (homeCubit.state is GetDoctorsSuccessState) {
            searchCubit.initializeSearch(homeCubit.allDoctors);
          }
          return searchCubit;
        },
        child: Scaffold(
          backgroundColor: AppColors.offWhite,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'Search Doctors',
              style: AppTextStyles.cairo400Style20,
            ),
          ),
          body: Column(
            children: [
              _buildSearchBar(),
              _buildFilterChips(),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoaded) {
                      if (state.doctors.isEmpty) {
                        return _buildEmptyState();
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        itemCount: state.doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = state.doctors[index];
                          return DoctorCard(
                            model: doctor,
                            onTap: () {
                              context.push('/doctor', extra: doctor);
                            },
                          );
                        },
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildSearchBar() => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                context.read<SearchCubit>().updateSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'Search by name or specialty',
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.primaryColor),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<SearchCubit>().updateSearchQuery('');
                          setState(() {});
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.offWhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      final searchCubit = context.read<SearchCubit>();
                      final count = searchCubit.activeFilterCount;

                      return OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _showFilters = !_showFilters;
                          });
                        },
                        icon: const Icon(Icons.filter_list),
                        label: Text(
                          count > 0 ? 'Filters ($count)' : 'Filters',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                          side: const BorderSide(color: AppColors.primaryColor),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    final searchCubit = context.read<SearchCubit>();
                    if (!searchCubit.hasActiveFilters) {
                      return const SizedBox.shrink();
                    }
                    return TextButton.icon(
                      onPressed: () {
                        _searchController.clear();
                        context.read<SearchCubit>().clearFilters();
                        setState(() {});
                      },
                      icon: const Icon(Icons.clear_all, size: 18),
                      label: const Text('Clear All'),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildFilterChips() {
    if (!_showFilters) return const SizedBox.shrink();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),
          const SizedBox(height: 16),
          _buildSpecialtyFilter(),
          const SizedBox(height: 12),
          _buildRatingFilter(),
          const SizedBox(height: 12),
          _buildAvailabilityFilter(),
        ],
      ),
    );
  }

  Widget _buildSpecialtyFilter() => BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is GetSpecialitiesSuccessState) {
            final homeCubit = context.read<HomeCubit>();
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChip(
                  label: Text(S.of(context).all),
                  selected:
                      context.watch<SearchCubit>().hasActiveFilters == false,
                  onSelected: (_) {
                    context.read<SearchCubit>().filterBySpecialty(null);
                  },
                ),
                ...homeCubit.specialities.map(
                  (specialty) => FilterChip(
                    label: Text(
                      Localizations.localeOf(context).languageCode == 'ar'
                          ? specialty.arCategoryName
                          : specialty.enCategoryName,
                    ),
                    onSelected: (selected) {
                      context
                          .read<SearchCubit>()
                          .filterBySpecialty(specialty.id.toString());
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      );

  Widget _buildRatingFilter() => Row(
        children: [
          const Icon(Icons.star, size: 18, color: Colors.amber),
          const SizedBox(width: 8),
          Text(
            'Minimum Rating',
            style: AppTextStyles.cairo300style16.copyWith(fontSize: 14),
          ),
          const Spacer(),
          ...List.generate(5, (index) {
            final rating = (index + 1).toDouble();
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: FilterChip(
                label: Text('$rating+'),
                onSelected: (selected) {
                  context
                      .read<SearchCubit>()
                      .filterByRating(selected ? rating : null);
                },
              ),
            );
          }),
        ],
      );

  Widget _buildAvailabilityFilter() => BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) => CheckboxListTile(
          value: context.watch<SearchCubit>().hasActiveFilters,
          onChanged: (value) {
            context.read<SearchCubit>().filterByAvailability(value);
          },
          title: Text(
            'Available Now',
            style: AppTextStyles.cairo300style16.copyWith(fontSize: 14),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
      );

  Widget _buildEmptyState() => Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.search_off,
                  size: 80,
                  color: AppColors.primaryColor.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                S.of(context).no_doctors_found,
                style: AppTextStyles.cairo400Style20.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Try adjusting your search or filters',
                style: AppTextStyles.cairo300style16.copyWith(
                  fontSize: 15,
                  color: AppColors.deepGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              OutlinedButton.icon(
                onPressed: () {
                  _searchController.clear();
                  context.read<SearchCubit>().clearFilters();
                  setState(() {
                    _showFilters = false;
                  });
                },
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear Filters'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  side: const BorderSide(color: AppColors.primaryColor),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
