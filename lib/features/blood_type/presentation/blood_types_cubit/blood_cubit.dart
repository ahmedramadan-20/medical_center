import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/blood_type/presentation/blood_types_cubit/blood_state.dart';
import 'package:medical_center/features/blood_type/data/models/blood_type_model.dart';
import 'package:medical_center/generated/l10n.dart';

class BloodCubit extends Cubit<BloodState> {
  BloodCubit() : super(BloodInitial());
  List<String> bloodTypesList = [
    S.current.all_blood_types,
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  int bloodTypeIndex = 0;

  void changeIndex(int index, context) {
    bloodTypeIndex = index;
    emit(ChangeBloodTypeIndexState());

    if (index == 0) {
      getAllBloodTypes();
    } else {
      getSpecificBloodType(bloodTypesList[index]);
    }
  }

  List<BloodTypeModel> firebaseBloodTypes = [];

  Future<void> getAllBloodTypes() async {
    emit(GettingBloodTypesLoadingState());
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('bloodTypes').get();
      firebaseBloodTypes = snapshot.docs
          .map((doc) => BloodTypeModel.fromJson(doc.data()))
          .toList();
      emit(GettingBloodTypesSuccessState(List.from(firebaseBloodTypes)));
    } catch (e) {
      emit(GettingBloodTypesErrorState(error: e.toString()));
    }
  }

  Future<void> getSpecificBloodType(String bloodType) async {
    emit(GettingSpecificBloodTypesLoadingState());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('bloodTypes')
          .where('bloodType', isEqualTo: bloodType)
          .get();
      firebaseBloodTypes = snapshot.docs
          .map((doc) => BloodTypeModel.fromJson(doc.data()))
          .toList();
      emit(
        GettingSpecificBloodTypesSuccessState(List.from(firebaseBloodTypes)),
      );
    } catch (e) {
      emit(GettingSpecificBloodTypesErrorState(error: e.toString()));
    }
  }
}
