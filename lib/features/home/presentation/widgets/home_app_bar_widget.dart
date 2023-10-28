
import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../generated/l10n.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
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
            IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_none_outlined),),
            IconButton(onPressed: (){}, icon: const Icon(Icons.search_outlined),),
          ]),
    );
  }
}