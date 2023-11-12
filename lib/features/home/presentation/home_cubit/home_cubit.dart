import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/utils/app_assets.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/category_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

//    DoctorsModel? model;
// // Helper function to convert day names to numbers
//   int _dayNumber(String day) {
//     switch (day.toLowerCase()) {
//       case 'sunday':
//         return 7;
//       case 'monday':
//         return 1;
//       case 'tuesday':
//         return 2;
//       case 'wednesday':
//         return 3;
//       case 'thursday':
//         return 4;
//       case 'friday':
//         return 5;
//       case 'saturday':
//         return 6;
//       default:
//         return 0;
//     }
//   }
//
//   // Helper function to format hours
//   String _formatHour(String hour, context) {
//     return DateFormat.jm(Localizations.localeOf(context).languageCode).format(
//       DateFormat('hh:mm a', AppStrings.englishCode).parse(hour),
//     );
//   }
//
//
//   Map<String, dynamic> workingHours = model!.workinghours;
//   int days = DateTime.now().weekday;
//   List<String> localizedDays = workingDays.map((day) {
//     return DateFormat.EEEE(Localizations.localeOf(context).languageCode)
//         .format(
//         DateTime.now().subtract(Duration(days: days - _dayNumber(day))));
//   }).toList();
//
//   // Format working hours based on app language
//   Map<String, String> localizedHours = {};
//   workingDays.forEach((day) {
//   String start = workingHours[day]['start'];
//   String end = workingHours[day]['end'];
//   localizedHours[day] =
//   '(${_formatHour(start, context)} - ${_formatHour(end, context)})';
//   });
  //! Categories
  List<CategoryModel> categoryList(context) => [
        CategoryModel(categoryName: S.of(context).all, image: AppAssets.all),
        CategoryModel(
            categoryName: S.of(context).general_surgery,
            image: AppAssets.generalSurgery),
        CategoryModel(
            categoryName: S.of(context).pediatrics,
            image: AppAssets.pediatrics),
        CategoryModel(
            categoryName: S.of(context).ent,
            image: AppAssets.earNoseAndThroatENT),
        CategoryModel(
            categoryName: S.of(context).dentistry, image: AppAssets.dentistry),
        CategoryModel(
            categoryName: S.of(context).dermatology,
            image: AppAssets.dermatology),
        CategoryModel(
            categoryName: S.of(context).obgyn,
            image: AppAssets.obstetricsAndGynecology),
        CategoryModel(
            categoryName: S.of(context).internal_medicine,
            image: AppAssets.internalMedicine),
        CategoryModel(
            categoryName: S.of(context).nutrition_therapy,
            image: AppAssets.nutritionalTherapy),
        CategoryModel(
            categoryName: S.of(context).rheumatology_joint,
            image: AppAssets.rheumatologyAndJoint),
        CategoryModel(
            categoryName: S.of(context).ophthalmology,
            image: AppAssets.ophthalmology),
        CategoryModel(
            categoryName: S.of(context).cardiology,
            image: AppAssets.cardiology),
        CategoryModel(
            categoryName: S.of(context).nephrology_urology,
            image: AppAssets.nephrologyAndUrology),
        CategoryModel(
            categoryName: S.of(context).speech_behavior_modification,
            image: AppAssets.speechAndBehaviorModification),
        CategoryModel(
            categoryName: S.of(context).neurology, image: AppAssets.neurology),
      ];

  // final CollectionReference doctorsCollection =
  //     FirebaseFirestore.instance.collection('doctors');
  //
  // Future<List<DoctorsModel>> getDoctorsData() async {
  //   QuerySnapshot querySnapshot = await doctorsCollection.get();
  //   return querySnapshot.docs
  //       .map((doc) => DoctorsModel.fromJson(doc.data()))
  //       .toList();
  // }

  // get all doctors data
  List<DoctorsModel> allDoctors = [];

  getAllDoctorsData(context) async {
    try {
      emit(GetDoctorsLoadingState());
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.doctors)
          .get()
          .then((value) {
        allDoctors = value.docs
            .map((element) => DoctorsModel.fromJson(element.data()))
            .toList();

        // Filter doctors based on selected category
        if (selectedIndex == 0) {
          // Show all doctors
          filteredDoctors = List.from(allDoctors);
        } else {
          // Filter doctors based on selected category
          String selectedCategory =
              categoryList(context)[selectedIndex].categoryName;

          filteredDoctors = allDoctors
              .where((doctor) =>
                  Localizations.localeOf(context).languageCode == 'en'
                      ? doctor.enspecialization == selectedCategory
                      : doctor.arspecialization == selectedCategory)
              .toList();
        }
      });

      emit(GetDoctorsSuccessState());
    } on Exception catch (e) {
      emit(GetDoctorsErrorState(error: e.toString()));
    }
  }

  Map<String, String> formatLocalizedHours(
      Map<String, dynamic> workingHours, BuildContext context) {
    Map<String, String> localizedHours = {};

    workingHours.forEach((day, hours) {
      String start = hours['start'];
      String end = hours['end'];
      localizedHours[day] =
          '${_localizedDay(day, context)}: ${_formatHour(day, start, end, context)} ';
    });

    return localizedHours;
  }

  String _formatHour(
      String day, String start, String end, BuildContext context) {
    // String formattedDay = _localizedDay(day, context);

    String formattedStart = DateFormat.jm()
        .format(DateFormat('hh:mm a', AppStrings.englishCode).parse(start));
    String formattedEnd = DateFormat.jm()
        .format(DateFormat('hh:mm a', AppStrings.englishCode).parse(end));

    return '$formattedStart - $formattedEnd';
  }

  List<String> formatLocalizedDays(
      List<String> workingDays, BuildContext context) {
    return workingDays.map((day) {
      return _localizedDay(day, context);
    }).toList();
  }

  String _localizedDay(String day, BuildContext context) {
    return DateFormat.EEEE(Localizations.localeOf(context).languageCode).format(
        DateTime.now().subtract(
            Duration(days: DateTime.now().weekday - _dayNumber(day))));
  }

  int _dayNumber(String day) {
    switch (day.toLowerCase()) {
      case 'sunday':
        return 7;
      case 'monday':
        return 1;
      case 'tuesday':
        return 2;
      case 'wednesday':
        return 3;
      case 'thursday':
        return 4;
      case 'friday':
        return 5;
      case 'saturday':
        return 6;
      default:
        return 0;
    }
  }

  // category change selected index
  int selectedIndex = 0;

  void changeIndex(int index, context) {
    selectedIndex = index;
    emit(ChangeCategoryState());
    getAllDoctorsData(
        context); // Fetch doctors based on the new selected category
  }

  List<DoctorsModel> filteredDoctors = []; // List to store filtered doctors
}
