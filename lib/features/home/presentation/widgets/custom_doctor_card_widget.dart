import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/doctors_model.dart';
import '../home_cubit/home_cubit.dart';
import '../home_cubit/home_state.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.model,
  });

  final DoctorsModel model;

  @override
  Widget build(BuildContext context) {
    List<String> workingDays = model.workinghours.keys.toList();
    // Map<String, dynamic> workingHours = model.workinghours;

    // Format day names based on app language
    List<String> localizedDays =
    context.read<HomeCubit>().formatLocalizedDays(workingDays, context);
    // Format working hours based on app language
    // Map<String, String> localizedHours =
    // context.read<HomeCubit>().formatLocalizedHours(workingHours, context);

    // DateTime now = DateTime.now();
    // DateTime start = DateFormat('hh:mm a', AppStrings.englishCode)
    //     .parse(workingHours['start']);
    // DateTime end = DateFormat('hh:mm a', AppStrings.englishCode)
    //     .parse(workingHours['end']);
    //Format working hours based on app language
    // Map<String, String> localizedHours = {};
    // workingDays.forEach((day) {
    //   String start = workingHours[day]['start'];
    //   String end = workingHours[day]['end'];
    //   localizedHours[day] =
    //       '(${_formatHour(start, context)} - ${_formatHour(end, context)})';
    // });
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0, right: 10, left: 10),
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightBlue.withOpacity(0.4),
                  blurRadius: 7,
                  offset: const Offset(0, 7), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.all(20),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: NetworkImage(model.image))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 230,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).dr,
                            style: AppTextStyles.cairo400Style20.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              Localizations.localeOf(context).languageCode ==
                                  AppStrings.arabicCode
                                  ? model.arname
                                  : model.enname,
                              style: AppTextStyles.cairo400Style20
                                  .copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      Localizations.localeOf(context).languageCode ==
                          AppStrings.arabicCode
                          ? model.arspecialization
                          : model.enspecialization,
                      style: AppTextStyles.cairo400Style20
                          .copyWith(color: AppColors.white, fontSize: 16),
                    ),
                    // Text(
                    //   'Working Days: ${localizedDays.join(', ')}',
                    //   style: AppTextStyles.cairo400Style20.copyWith(
                    //     color: AppColors.white,
                    //   ),
                    // ),

                    // Display working hours
                    // Text(
                    //   'Working Hours: ${localizedHours.values.join(', ')}',
                    //   style: AppTextStyles.cairo400Style20.copyWith(
                    //     color: AppColors.white,
                    //   ),
                    // ),

                    // for (int i = 0; i < workingDays.length; i++)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                          '${S.of(context).workingDays} ${localizedDays.join(', ')}',
                          // '${localizedDays[i]}: ${_formatHour(workingHours[workingDays[i]]['start'], context)}',

                          style:
                          AppTextStyles.cairo300style16.copyWith(fontSize: 12)),
                    ),
                    // Display working hours
                    // for (var entry in localizedHours.entries)
                    //   Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 7),
                    //     margin: const EdgeInsets.symmetric(vertical: 5),
                    //     decoration: BoxDecoration(
                    //         color: AppColors.offWhite,
                    //         borderRadius: BorderRadius.circular(5)),
                    //     child: Text(
                    //       entry.value,
                    //       style: AppTextStyles.cairo300style16,
                    //     ),
                    //   ),
                    // for (var day in workingDays)
                    //   Text(
                    //     '$day: ${workingHours[day]['start']} - ${workingHours[day]['end']}',
                    //     style: AppTextStyles.cairo400Style20.copyWith(
                    //       color: AppColors.white,
                    //     ),
                    //   ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}