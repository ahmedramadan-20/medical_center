import '../../data/models/user_model.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class GetDoctorsLoadingState extends HomeState {}

class GetDoctorsSuccessState extends HomeState {}

class GetDoctorsErrorState extends HomeState {
  final String error;

  GetDoctorsErrorState({required this.error});
}

// category states
class ChangeCategoryState extends HomeState {}

// get user data
class GetUserDataLoadingState extends HomeState {}

class GetUserDataSuccessState extends HomeState {
  final UserModel? originalUser;

  GetUserDataSuccessState(this.originalUser);
}

class GetUserDataErrorState extends HomeState {
  final String error;

  GetUserDataErrorState({required this.error});
}

// get specialities
class GetSpecialitiesLoadingState extends HomeState {}

class GetSpecialitiesSuccessState extends HomeState {}

class GetSpecialitiesErrorState extends HomeState {
  final String error;

  GetSpecialitiesErrorState({required this.error});
}
