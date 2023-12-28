import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_cubit.dart';
import '../../../../core/widgets/custom_header_text.dart';
import '../../../../generated/l10n.dart';
import '../profile_cubit/profile_state.dart';
import '../widgets/custom_appbar_title_widget.dart';
import '../widgets/custom_profile_view_list_tile.dart';
import '../widgets/profile_avatar_and_name_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return
          state is GetProfileUserDataLoadingState
              ? const Center(
            child: CircularProgressIndicator(),
          )
              :
          Scaffold(
          backgroundColor: AppColors.offWhite,
          body: SafeArea(
            child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 12),
                  ),
                  SliverToBoxAdapter(
                    child: CustomAppBarTitle(text: S.of(context).profile),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 24),
                  ),
                  const SliverToBoxAdapter(
                    child: ProfileAvatarAndName(),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 32),
                  ),
                  SliverToBoxAdapter(
                      child: CustomHeaderText(text: S.of(context).account)),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 24),
                  ),
                  const SliverToBoxAdapter(
                    child: CustomProfileListTile(),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
