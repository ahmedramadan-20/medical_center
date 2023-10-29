
import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../generated/l10n.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key, this.onPressed});
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        S.of(context).hello,
                        style: AppTextStyles.cairo300style16
                            .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Ahmed',
                        style: AppTextStyles.cairo300style16
                            .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Text(
                    S.of(context).subtitle,
                    style: AppTextStyles.cairo300style16
                        .copyWith(fontSize: 12, ),
                  ),
                ],
              )),
          IconButton(onPressed: onPressed, icon: const Icon(Icons.drag_handle_outlined),),
        ]);
  }
}