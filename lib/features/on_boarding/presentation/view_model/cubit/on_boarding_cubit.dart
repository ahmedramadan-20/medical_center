import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../data/models/on_boarding_model.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  PageController controller = PageController(initialPage: 0);

  List<OnBoardingModel> onBoardingData = [
    OnBoardingModel(
      imagePath: AppAssets.onBoarding1,
      title: 'Easily book appointments',
      subTitle: 'with your preferred doctor at our medical center.',
    ),
    OnBoardingModel(
      imagePath: AppAssets.onBoarding2,
      title: 'Explore a comprehensive',
      subTitle: 'range of medical specialties for your healthcare needs.',
    ),
    OnBoardingModel(
      imagePath: AppAssets.onBoarding3,
      title: 'Discover doctors\'',
      subTitle: 'availability on specific days to plan your visit conveniently.',
    ),
  ];

  int currentIndex = 0;

  int onPageChanged(int index) {
    currentIndex = index;
    emit(OnBoardingChangePage());
    return currentIndex;
  }

}