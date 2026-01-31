import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/widgets/custom_header_text.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_cubit.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_state.dart';
import 'package:medical_center/features/profile/presentation/widgets/custom_appbar_title_widget.dart';
import 'package:medical_center/features/profile/presentation/widgets/custom_profile_view_list_tile.dart';
import 'package:medical_center/features/profile/presentation/widgets/profile_avatar_and_name_widget.dart';
import 'package:medical_center/generated/l10n.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) => state is GetProfileUserDataLoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
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
                        child: CustomHeaderText(text: S.of(context).account),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 24),
                      ),
                      const SliverToBoxAdapter(
                        child: CustomProfileListTile(),
                      ),
                    ],
                  ),
                ),
              ),
      );
}
