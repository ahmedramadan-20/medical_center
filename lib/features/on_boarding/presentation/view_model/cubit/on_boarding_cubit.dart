import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/on_boarding_model.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  PageController controller = PageController(initialPage: 0);

  List<OnBoardingModel> onBoardingData(context) => [
    OnBoardingModel(
      imagePath: AppAssets.onBoarding1,
      title: S.of(context).book_your_appointment,
      subTitle:  S.of(context).in_our_medical_center,
    ),
    OnBoardingModel(
      imagePath: AppAssets.onBoarding2,
      title:  S.of(context).explore,
      subTitle:  S.of(context).of_medical_specialists,
    ),
    OnBoardingModel(
      imagePath: AppAssets.onBoarding3,
      title:  S.of(context).discover_doctor_availability,
      subTitle:  S.of(context).on_specific_days,
    ),
  ];

  int currentIndex = 0;

  int onPageChanged(int index) {
    currentIndex = index;
    emit(OnBoardingChangePage());
    return currentIndex;
  }

}