import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

Future<void> showLogOutBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white(context),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                SvgPicture.asset(
                  height: 48,
                  width: 48,
                  AppAssets.app_imagesLogout,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 340,
                  height: 64,
                  child: Text('هل ترغب بتسجيل الخروج ؟',
                      textAlign: TextAlign.center, // Format DateTime
                      style: AppStyles.styleMedium20(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      )),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            context.pop();
                          },
                          label: Text(
                            'إلغاء',
                            style: AppStyles.styleMedium16(context).copyWith(
                                color: AppColors.iconsTertiary(context)),
                          ),
                          icon: SvgPicture.asset(
                            Assets.imagesClose,
                          ),
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 46),
                              side: BorderSide(
                                color: AppColors.iconsTertiary(context),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              foregroundColor: AppColors.iconsTertiary(context),
                              backgroundColor: AppColors.white(context)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Builder(builder: (context) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<ProfileCubit>().logOut();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.danger(context)),
                            child: BlocConsumer<ProfileCubit, ProfileState>(
                              listener: (context, state) {
                                if (state.logOutRequestState ==
                                    RequestState.loaded) {
                                  context
                                      .navigateToWithReplacementAndClearStack(
                                    Routes.login,
                                  );
                                  mySnackBar(
                                    state.logOutMsg ?? 'تم تسجيل الخروج بنجاح',
                                    context,
                                    isError: false,
                                  );
                                } else if (state.logOutRequestState ==
                                    RequestState.error) {
                                  mySnackBar(
                                    state.logOutError?.message ??
                                        'هناك شئ ما خطأ حاول مجددا',
                                    context,
                                    isError: true,
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state.logOutRequestState ==
                                    RequestState.loading) {
                                  return Lottie.asset(
                                    AppAnimationAssets.loading,
                                  );
                                } else {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        Assets.imagesLogout,
                                        color: AppColors.white(context),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'تسجيل الخروج', // Format DateTime
                                        style: AppStyles.styleMedium16(context)
                                            .copyWith(
                                          color: AppColors.white(context),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
