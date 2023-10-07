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
      title: 'احجز مواعيدك ',
      subTitle: 'مع طبيبك المفضل بكل سهولة في مركزنا الطبي.',
    ),
    OnBoardingModel(
      imagePath: AppAssets.onBoarding2,
      title: 'استكشف مجموعة واسعة',
      subTitle: 'من التخصصات الطبية لاحتياجاتك الصحية',
    ),
    OnBoardingModel(
      imagePath: AppAssets.onBoarding3,
      title: 'اكتشف توافر الأطباء',
      subTitle: 'في أيام معينة لتخطيط زيارتك بسهولة',
    ),
  ];

  int currentIndex = 0;

  int onPageChanged(int index) {
    currentIndex = index;
    emit(OnBoardingChangePage());
    return currentIndex;
  }

}