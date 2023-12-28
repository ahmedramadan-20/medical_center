import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../home/data/models/blood_type_model.dart';

class BloodTypeListItem extends StatelessWidget {
  final BloodTypeModel bloodType;

  const BloodTypeListItem({Key? key, required this.bloodType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          color: AppColors.babyBlue,
        ),
      ),
      tileColor: AppColors.white,
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.babyBlue.withOpacity(0.3),
        child: Text(
          bloodType.bloodType,
          style: AppTextStyles.cairo400Style20,
          textAlign: TextAlign.center,
        ),
      ),
      title: Text(
        '${bloodType.firstName} ${bloodType.lastName}',
        style: AppTextStyles.cairo400Style20,
      ),
      subtitle: Text(
        bloodType.phone,
        style: AppTextStyles.cairo300style16,
      ),
    );
  }
}