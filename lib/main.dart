import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/medical_center_app.dart';
import 'features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => OnBoardingCubit(),
      ),

    ],
    child: MedicalCenter(),
  ));
}
