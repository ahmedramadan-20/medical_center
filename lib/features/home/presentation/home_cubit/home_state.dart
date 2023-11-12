
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



