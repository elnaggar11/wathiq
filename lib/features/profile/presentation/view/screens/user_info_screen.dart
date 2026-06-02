import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import 'package:wathiq/app/app.dart';
import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/core/widgets/guest_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/user_info/loaded_user_info_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/user_info/shimmer_user_info_widget%20.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().getProfile();
    _updateStatusBar();

    super.initState();
  }

  void _updateStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    Future.delayed(const Duration(milliseconds: 500)).then((v) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primarySurface(context),
        bottomSheet: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return (profileCubit.imageFile == null &&
                    profileCubit.editUserInfoCountryID == null)
                ? const SizedBox.shrink()
                : Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.white(context),
                    child: ElevatedButton(
                      onPressed: () {
                        profileCubit.changeProfileImage();
                      },
                      child: state.changeProfileImageRequestState ==
                              RequestState.loading
                          ? Lottie.asset(
                              AppAnimationAssets.loading,
                            )
                          : Text(
                              'حفظ التعديلات',
                              style: AppStyles.styleBold18(context)
                                  .copyWith(color: AppColors.white(context)),
                            ),
                    ),
                  );
          },
        ),
        appBar: CoustomAppBarWidget(
          title: 'البيانات الشخصية',
        ),
        body: KisGuest == true
            ? const GuestWidget()
            : BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  switch (state.profileRequestState) {
                    case RequestState.loading:
                    case RequestState.ideal:
                      return const ShimmerUserInfoWidget();
                    case RequestState.error:
                      return ErrorAppWidget(
                        text: state.profileError?.message ?? 'حدث شئ ما خطأ',
                        onTap: () {
                          profileCubit.getProfile();
                        },
                      );
                    case RequestState.loaded:
                      return LoadedUserInfoWidget(
                        profileModel: state.profileModel!,
                      );
                  }
                },
              ),
      ),
    );
  }
}
