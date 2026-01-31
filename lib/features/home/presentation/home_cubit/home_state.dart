import 'package:medical_center/features/home/data/models/user_model.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class GetDoctorsLoadingState extends HomeState {}

class GetDoctorsSuccessState extends HomeState {}

class GetDoctorsErrorState extends HomeState {
  GetDoctorsErrorState({required this.error});
  final String error;
}

// category states
class ChangeCategoryState extends HomeState {}

/// Emitted after filtering doctors based on the selected category.
class DoctorsFilteredState extends HomeState {}

// get user data
class GetUserDataLoadingState extends HomeState {}

class GetUserDataSuccessState extends HomeState {
  GetUserDataSuccessState(this.originalUser);
  final UserModel? originalUser;
}

class GetUserDataErrorState extends HomeState {
  GetUserDataErrorState({required this.error});
  final String error;
}

// get specialities
class GetSpecialitiesLoadingState extends HomeState {}

class GetSpecialitiesSuccessState extends HomeState {}

class GetSpecialitiesErrorState extends HomeState {
  GetSpecialitiesErrorState({required this.error});
  final String error;
}
