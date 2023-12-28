
class BloodState {}

class BloodInitial extends BloodState {}
class ChangeBloodTypeIndexState extends BloodState{}


 class GettingBloodTypesLoadingState extends BloodState{}

 class GettingBloodTypesSuccessState extends BloodState{

 }
 class GettingBloodTypesErrorState extends BloodState{
   final String error;
   GettingBloodTypesErrorState({required this.error});
 }

 class GettingSpecificBloodTypesLoadingState extends BloodState{}

 class GettingSpecificBloodTypesSuccessState extends BloodState{

 }
 class GettingSpecificBloodTypesErrorState extends BloodState{
   final String error;
   GettingSpecificBloodTypesErrorState({required this.error});
 }
