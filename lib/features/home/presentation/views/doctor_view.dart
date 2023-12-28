import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/core/functions/navigator.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_strings.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../generated/l10n.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({
    super.key,
    required this.model,
  });

  final DoctorsModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(child: DoctorDetailsAppBar(model: model)),
          SliverToBoxAdapter(child: DoctorImage(model: model)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(child: DoctorDetails(model: model)),
        ]),
      ),
    );
  }
}

class DoctorDetailsAppBar extends StatelessWidget {
  const DoctorDetailsAppBar({super.key, required this.model});

  final DoctorsModel model;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        color: AppColors.primaryColor,
        onPressed: () {
          navigatePop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      centerTitle: true,
      title: Text(
        '${S.of(context).dr}${Localizations.localeOf(context).languageCode == AppStrings.englishCode ? model.enName : model.arName}',
        style: AppTextStyles.cairo400Style20,
      ),
    );
  }
}

class DoctorImage extends StatelessWidget {
  const DoctorImage({super.key, required this.model});

  final DoctorsModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Hero(
        tag: model.enName,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: model.image,
          placeholder: (context, url) => Animate(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(5)),
            ).animate().shimmer(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class DoctorDetails extends StatelessWidget {
  DoctorDetails({Key? key, required this.model}) : super(key: key);

  final DoctorsModel model;
  final String currentDay =
      DateFormat('EEEE', AppStrings.englishCode).format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    // Function to check if it's the working day and before start hour
    bool isWorkingNow() {
      if (kDebugMode) {
        print('Current Day: $currentDay');
      }

      if (kDebugMode) {
        print('Working Hours: ${model.workingHours}');
      }

      if (model.workingHours.containsKey(currentDay)) {
        String startTime = model.workingHours[currentDay]['start'];

        if (kDebugMode) {
          print('Start Time: $startTime');
        }

        DateTime currentTime = DateTime.now();
        TimeOfDay startTimeOfDay = TimeOfDay.fromDateTime(
          DateFormat('hh:mm a', AppStrings.englishCode).parse(startTime),
        );

        if (kDebugMode) {
          print('Current Time: $currentTime');
        }
        if (kDebugMode) {
          print('Start TimeOfDay: $startTimeOfDay');
        }

        if (currentTime.hour < startTimeOfDay.hour ||
            (currentTime.hour == startTimeOfDay.hour &&
                currentTime.minute < startTimeOfDay.minute)) {
          return true;
        }
      } else {
        if (kDebugMode) {
          print('Current Day not found in working hours');
        }
      }

      return false;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${S.of(context).specialty}\n${Localizations.localeOf(context).languageCode == AppStrings.englishCode ? model.enSpecialization : model.arSpecialization}',
            style: AppTextStyles.cairo400Style20,
          ),
          const SizedBox(height: 24),
          Text(
            S.of(context).workingDays,
            style: AppTextStyles.cairo400Style20,
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getLocalizedWorkingDaysWithHours(model, context),
          ),
          const SizedBox(height: 24),
          // Add appointment button if it's the working day and before start hour
          if (isWorkingNow())
            CustomButton(text: 'Make an Appointment', onPressed: () {}),
          if (!model.workingHours.containsKey(currentDay))
            const Center(
              child: Text(
                'Doctor is not working today',
              ),
            )
        ],
      ),
    );
  }

  List<Widget> getLocalizedWorkingDaysWithHours(
      DoctorsModel model, BuildContext context) {
    List<Widget> workingDaysWidgets = [];

    Map<String, String> localizedHours =
        formatLocalizedHours(model.workingHours, context);

    localizedHours.forEach((day, hours) {
      workingDaysWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: (8.0)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              hours,
              style: AppTextStyles.cairo400Style20
                  .copyWith(color: AppColors.white),
            ),
          ),
        ),
      );
    });

    return workingDaysWidgets;
  }

  Map<String, String> formatLocalizedHours(
      Map<String, dynamic> workingHours, BuildContext context) {
    Map<String, String> localizedHours = {};

    workingHours.forEach((day, hours) {
      String start = hours['start'];
      String end = hours['end'];
      localizedHours[day] =
          '${_localizedDay(day, context)}: ${_formatHour(day, start, end, context)}';
    });

    return localizedHours;
  }

  String _formatHour(
      String day, String start, String end, BuildContext context) {
    String formattedStart = DateFormat.jm()
        .format(DateFormat('hh:mm a', AppStrings.englishCode).parse(start));
    // String formattedEnd = DateFormat.jm()
    //     .format(DateFormat('hh:mm a', AppStrings.englishCode).parse(end));

    return '$formattedStart ';
  }

  String _localizedDay(String day, BuildContext context) {
    return _localizedDayHelper(day, context);
  }

  String _localizedDayHelper(String day, BuildContext context) {
    return DateFormat.EEEE(Localizations.localeOf(context).languageCode).format(
      DateTime.now().subtract(
        Duration(days: DateTime.now().weekday - _dayNumber(day)),
      ),
    );
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
}
