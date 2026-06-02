import 'package:wathiq/app/injector.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';

Future<void> showDeleteAccountBottomSheet(BuildContext context) async {
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
                  Assets.imagesDeleteAccount,
                ),
                const SizedBox(height: 16),
                Text('حذف الحساب؟', // Format DateTime
                    style: AppStyles.stylBold24(context)),
                const SizedBox(height: 16),
                Text(
                    'هل أنت متأكد أنك تريد حذف الحساب نهائيا؟', // Format DateTime
                    style: AppStyles.styleSemiBold18(context).copyWith(
                      color: AppColors.typographySubTitle(context),
                    )),
                const SizedBox(height: 24),
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
                            style: AppStyles.styleBold16(context).copyWith(
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
                      const SizedBox(width: 24),
                      Expanded(
                        child: BlocProvider(
                          create: (context) => serviceLocator<ProfileCubit>(),
                          child: Builder(builder: (context) {
                            return ElevatedButton(
                              onPressed: () {
                                context.read<ProfileCubit>().deleteAccount();
                              },
                              child: BlocConsumer<ProfileCubit, ProfileState>(
                                listener: (context, state) {
                                  if (state.deleteAccountRequestState ==
                                      RequestState.loaded) {
                                    context
                                        .navigateToWithReplacementAndClearStack(
                                      Routes.login,
                                    );
                                    mySnackBar(
                                      state.deleteAccountMsg ?? 'تم حذف حسابك',
                                      context,
                                      isError: false,
                                    );
                                  } else if (state.deleteAccountRequestState ==
                                      RequestState.error) {
                                    mySnackBar(
                                      state.deleteAccountError?.message ??
                                          'هناك شئ ما خطأ حاول مجددا',
                                      context,
                                      isError: true,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state.deleteAccountRequestState ==
                                      RequestState.loading) {
                                    return Lottie.asset(
                                      AppAnimationAssets.loading,
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.imagesDelete,
                                          color: AppColors.white(context),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'حذف', // Format DateTime
                                          style: AppStyles.styleBold16(context)
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
                        ),
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
