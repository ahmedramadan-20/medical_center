 class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileUserDataLoadingState extends ProfileState {}

class GetProfileUserDataSuccessState extends ProfileState {}

class GetProfileUserDataErrorState extends ProfileState {
  final String error;

  GetProfileUserDataErrorState({required this.error});
}