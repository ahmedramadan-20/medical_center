class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileUserDataLoadingState extends ProfileState {}

class GetProfileUserDataSuccessState extends ProfileState {}

class GetProfileUserDataErrorState extends ProfileState {
  GetProfileUserDataErrorState({required this.error});
  final String error;
}

class ProfileUpdateLoading extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  ProfileUpdateSuccess(this.message);
  final String message;
}

class ProfileUpdateError extends ProfileState {
  ProfileUpdateError(this.error);
  final String error;
}
