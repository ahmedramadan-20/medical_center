import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../home_cubit/home_cubit.dart';
import '../home_cubit/home_state.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: 110,
          child: ListView.separated(

              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => SizedBox(
                width: 70,
                child: InkWell(
                  onTap: () {

                    BlocProvider.of<HomeCubit>(context).changeIndex(index, context);
                    BlocProvider.of<HomeCubit>(context).selectedIndex =
                        index;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: BlocProvider.of<HomeCubit>(context)
                        .selectedIndex ==
                        index
                        ? AppColors.primaryColor
                        :Colors.transparent,borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color:  AppColors.offWhite,
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: AssetImage(
                                  BlocProvider.of<HomeCubit>(context)
                                      .categoryList(context)[index]
                                      .image,
                                ),
                              )),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: Text(
                              textAlign: TextAlign.center,
                              BlocProvider.of<HomeCubit>(context)
                                  .categoryList(context)[index]
                                  .categoryName,
                              style: AppTextStyles.cairo300style16
                                  .copyWith(fontSize: 12,color: BlocProvider.of<HomeCubit>(context)
                                  .selectedIndex ==index?AppColors.white:AppColors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: BlocProvider.of<HomeCubit>(context)
                  .categoryList(context)
                  .length),
        );
      },
    );
  }
}