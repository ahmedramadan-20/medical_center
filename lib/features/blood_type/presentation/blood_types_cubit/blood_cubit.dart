import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../home/data/models/blood_type_model.dart';
import 'blood_state.dart';

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

  void changeIndex(int index,context) {
    bloodTypeIndex = index;
    emit(ChangeBloodTypeIndexState());

    if (index == 0) {
      getAllBloodTypes();
    } else {
      getSpecificBloodType(bloodTypesList[index]);
    }
  }

  List<BloodTypeModel> firebaseBloodTypes = [];

  void getAllBloodTypes() {
    emit(GettingBloodTypesLoadingState());
    FirebaseFirestore.instance
        .collection('bloodTypes')
        .where('gender', isEqualTo: 'male')
        .get()
        .then((value) {
      firebaseBloodTypes.clear();
      for (var element in value.docs) {
        firebaseBloodTypes.add(BloodTypeModel.fromJson(element.data()));
      }
      emit(GettingBloodTypesSuccessState());
    }).catchError((e) {
      emit(GettingBloodTypesErrorState(error: e.toString()));
    });
  }

  void getSpecificBloodType(String bloodType) {
    emit(GettingSpecificBloodTypesLoadingState());
    FirebaseFirestore.instance
        .collection('bloodTypes')
        .where('gender', isEqualTo: 'male')
        .where('bloodType', isEqualTo: bloodType)
        .get()
        .then((value) {
      firebaseBloodTypes
          .clear(); // Clear the list before adding new blood types
      for (var element in value.docs) {
        firebaseBloodTypes.add(BloodTypeModel.fromJson(element.data()));
      }
      emit(GettingSpecificBloodTypesSuccessState());
    }).catchError((e) {
      emit(GettingSpecificBloodTypesErrorState(error: e.toString()));
    });
  }
}
