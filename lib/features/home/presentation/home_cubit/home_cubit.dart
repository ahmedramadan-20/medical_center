import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';
import 'package:medical_center/features/home/data/models/user_model.dart';

import '../../../../core/utils/app_strings.dart';
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
  // List<CategoryModel> categoryList(context) => [
  //       CategoryModel(categoryName: S.of(context).all, image: AppAssets.all),
  //       CategoryModel(
  //           categoryName: S.of(context).general_surgery,
  //           image: AppAssets.generalSurgery),
  //       CategoryModel(
  //           categoryName: S.of(context).pediatrics,
  //           image: AppAssets.pediatrics),
  //       CategoryModel(
  //           categoryName: S.of(context).ent,
  //           image: AppAssets.earNoseAndThroatENT),
  //       CategoryModel(
  //           categoryName: S.of(context).dentistry, image: AppAssets.dentistry),
  //       CategoryModel(
  //           categoryName: S.of(context).dermatology,
  //           image: AppAssets.dermatology),
  //       CategoryModel(
  //           categoryName: S.of(context).obgyn,
  //           image: AppAssets.obstetricsAndGynecology),
  //       CategoryModel(
  //           categoryName: S.of(context).internal_medicine,
  //           image: AppAssets.internalMedicine),
  //       CategoryModel(
  //           categoryName: S.of(context).nutrition_therapy,
  //           image: AppAssets.nutritionalTherapy),
  //       CategoryModel(
  //           categoryName: S.of(context).rheumatology_joint,
  //           image: AppAssets.rheumatologyAndJoint),
  //       CategoryModel(
  //           categoryName: S.of(context).ophthalmology,
  //           image: AppAssets.ophthalmology),
  //       CategoryModel(
  //           categoryName: S.of(context).cardiology,
  //           image: AppAssets.cardiology),
  //       CategoryModel(
  //           categoryName: S.of(context).nephrology_urology,
  //           image: AppAssets.nephrologyAndUrology),
  //       CategoryModel(
  //           categoryName: S.of(context).speech_behavior_modification,
  //           image: AppAssets.speechAndBehaviorModification),
  //       CategoryModel(
  //           categoryName: S.of(context).neurology, image: AppAssets.neurology),
  //     ];

  // final CollectionReference doctorsCollection =
  //     FirebaseFirestore.instance.collection('doctors');
  //
  // Future<List<DoctorsModel>> getDoctorsData() async {
  //   QuerySnapshot querySnapshot = await doctorsCollection.get();
  //   return querySnapshot.docs
  //       .map((doc) => DoctorsModel.fromJson(doc.data()))
  //       .toList();
  // }
  // List<SpecialityModel> specialityList = [
  //   SpecialityModel(
  //     id: 1,
  //     enCategoryName: "All",
  //     arCategoryName: "جميع التخصصات",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/all.png?alt=media&token=e85c6e63-ba68-417c-b2da-cbdf12d3b705",
  //   ),
  //   SpecialityModel(
  //     id: 2,
  //     enCategoryName: "General Surgery",
  //     arCategoryName: "جراحة عامة",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/General%20Surgery.png?alt=media&token=cc86af96-5d12-424f-a496-1764ce174b79",
  //   ),
  //   SpecialityModel(
  //     id: 3,
  //     enCategoryName: "Pediatrics",
  //     arCategoryName: "الأطفال",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/pediatric.png?alt=media&token=c4ad79d7-2c91-4b24-a68e-8e30b362bee9",
  //   ),
  //   // Add more specialties as needed
  //   SpecialityModel(
  //     id: 4,
  //     enCategoryName: "Ear, Nose, and Throat (ENT)",
  //     arCategoryName: "أنف وأذن وحنجرة",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/ent.png?alt=media&token=2f0aa575-d3cb-4661-8ad3-fcf273649b40",
  //   ),
  //   SpecialityModel(
  //     id: 5,
  //     enCategoryName: "Dentistry",
  //     arCategoryName: "الأسنان",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/dentistry.png?alt=media&token=d8928b0a-8417-4d64-9dab-0219f8ea5579",
  //   ),
  //   SpecialityModel(
  //     id: 6,
  //     enCategoryName: "Dermatology",
  //     arCategoryName: "الجلدية",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/dermatology.png?alt=media&token=ba2f362e-a217-42a0-9f17-bc0f39fa34eb",
  //   ),
  //   SpecialityModel(
  //     id: 7,
  //     enCategoryName: "Obstetrics and Gynecology",
  //     arCategoryName: "النساء والتوليد",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/obstetricsAndGynecology.png?alt=media&token=1868ad08-9a32-4cd2-b78b-24fc0830c5ee",
  //   ),
  //   SpecialityModel(
  //     id: 8,
  //     enCategoryName: "Internal Medicine",
  //     arCategoryName: "الباطنة",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/gastroenterology.png?alt=media&token=4f6789e5-26d4-454b-b826-bfcd8177b997",
  //   ),
  //   SpecialityModel(
  //     id: 9,
  //     enCategoryName: "Nutritional Therapy",
  //     arCategoryName: "التغذية العلاجية",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/nutritionalTherapy.png?alt=media&token=2cb52a3a-6d87-4fc2-a65b-42b18197486a",
  //   ),
  //   SpecialityModel(
  //     id: 10,
  //     enCategoryName: "Rheumatology and Joint",
  //     arCategoryName: "المفاصل والرماتيزم",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/rheumatologyAndJoint.png?alt=media&token=abf240df-8b56-4d64-b631-2e80e3788397",
  //   ),
  //   SpecialityModel(
  //     id: 11,
  //     enCategoryName: "Ophthalmology",
  //     arCategoryName: "العيون",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/ophthalmology.png?alt=media&token=e1e434e8-f38b-43db-8729-af7f7d68b656",
  //   ),
  //   SpecialityModel(
  //     id: 12,
  //     enCategoryName: "Cardiology",
  //     arCategoryName: "القلب",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/cardiology.png?alt=media&token=0f7fb5fb-0966-4217-8864-a0d5b2a88d02",
  //   ),
  //   SpecialityModel(
  //     id: 13,
  //     enCategoryName: "Nephrology and Urology",
  //     arCategoryName: "الكلى والمسالك",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/nephrologyAndUrology.png?alt=media&token=f1bf026e-5547-48af-a1c3-148c86b1ec9c",
  //   ),
  //   SpecialityModel(
  //     id: 14,
  //     enCategoryName: "Speech and Behavior Modification",
  //     arCategoryName: "تخاطب وتعديل السلوك",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/speechAndBehaviorModification.png?alt=media&token=28911fde-471d-4664-b0a4-1d975cb13319",
  //   ),
  //   SpecialityModel(
  //     id: 15,
  //     enCategoryName: "Neurology",
  //     arCategoryName: "الأعصاب",
  //     image:
  //         "https://firebasestorage.googleapis.com/v0/b/medical-center-df926.appspot.com/o/neurology.png?alt=media&token=58c17598-4122-4569-a719-9553426a56fc",
  //   ),
  // ];
  //
  // Future<void> addSpecialitiesToFirestore(List<SpecialityModel> specialities) async {
  //   final CollectionReference specialitiesCollection = FirebaseFirestore.instance.collection('specialities');
  //
  //   for (var speciality in specialities) {
  //     // Assuming that the IDs are integers
  //     String paddedId = speciality.id.toString().padLeft(2, '0'); // Adjust the padding length as needed
  //     await specialitiesCollection.doc(paddedId).set(speciality.toMap());
  //   }
  // }





  // get all doctors data
  List<DoctorsModel> allDoctors = [];

  //
  // getAllDoctorsData(context) async {
  //   try {
  //     emit(GetDoctorsLoadingState());
  //     await FirebaseFirestore.instance
  //         .collection(FirebaseStrings.doctors)
  //         .get()
  //         .then((value) {
  //       allDoctors = value.docs
  //           .map((element) => DoctorsModel.fromJson(element.data()))
  //           .toList();
  //
  //       // Filter doctors based on selected category
  //       if (selectedIndex == 0) {
  //         // Show all doctors
  //         filteredDoctors = List.from(allDoctors);
  //       } else {
  //         // // Filter doctors based on selected category
  //         // String selectedCategory =
  //         //     categoryList(context)[selectedIndex].categoryName;
  //
  //         filteredDoctors = allDoctors
  //             .where((doctor) =>
  //                 Localizations.localeOf(context).languageCode == 'en'
  //                     ? doctor.enSpecialization == selectedCategory
  //                     : doctor.arSpecialization == selectedCategory)
  //             .toList();
  //       }
  //     });
  //
  //     emit(GetDoctorsSuccessState());
  //   } on Exception catch (e) {
  //     emit(GetDoctorsErrorState(error: e.toString()));
  //   }
  // }

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

  //
  void changeIndex(int index) {
    selectedIndex = index;
    emit(ChangeCategoryState());
     // Fetch doctors based on the new selected category
  }

  List<DoctorsModel> filteredDoctors = []; // List to store filtered doctors

  UserModel? originalUser;

  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        originalUser = UserModel.fromJson(value.docs.first.data());
        emit(GetUserDataSuccessState(originalUser));
      } else {
        // Handle the case where no user with the specified email is found
        emit(GetUserDataErrorState(error: "User not found"));
      }
    }).catchError((error) {
      emit(GetUserDataErrorState(error: error.toString()));
    });
  }
  
  
  // get specialities from firebase
  List<SpecialityModel> specialities = [];
  
  Future<void> getSpecialities() async {
    emit(GetSpecialitiesLoadingState());
    await FirebaseFirestore.instance.collection('specialities').get().then((value) {
      specialities = value.docs.map((e) => SpecialityModel.fromJson(e.data())).toList();
      emit(GetSpecialitiesSuccessState());
    }).catchError((error){
      emit(GetSpecialitiesErrorState(error: error.toString()));
    });
  }
}
