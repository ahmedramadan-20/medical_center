import 'package:medical_center/features/blood_type/data/models/blood_type_model.dart';

class BloodState {}

class BloodInitial extends BloodState {}

class ChangeBloodTypeIndexState extends BloodState {}

class GettingBloodTypesLoadingState extends BloodState {}

class GettingBloodTypesSuccessState extends BloodState {
  GettingBloodTypesSuccessState(this.bloodTypes);
  final List<BloodTypeModel> bloodTypes;
}

class GettingBloodTypesErrorState extends BloodState {
  GettingBloodTypesErrorState({required this.error});
  final String error;
}

class GettingSpecificBloodTypesLoadingState extends BloodState {}

class GettingSpecificBloodTypesSuccessState extends BloodState {
  GettingSpecificBloodTypesSuccessState(this.bloodTypes);
  final List<BloodTypeModel> bloodTypes;
}

class GettingSpecificBloodTypesErrorState extends BloodState {
  GettingSpecificBloodTypesErrorState({required this.error});
  final String error;
}
