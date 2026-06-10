import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/login/login_password_widget.dart';

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/custom_progress_bar.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/auth_app_logo_widget.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/nav_to_another_screen_row.dart';
import 'package:animate_do/animate_do.dart';

class LoginMobileLayoutWidget extends StatelessWidget {
  const LoginMobileLayoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return Form(
      key: cubit.loginFormKey,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.verticalSpace,
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: const AuthAppLogoWidget(),
                    ),
                    48.verticalSpace,
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 200),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: CustomProgressBar(
                          totalSteps: 2,
                          currentStep: 1,
                        ),
                      ),
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 400),
                      child: Column(
                        children: [
                          32.verticalSpace,
                          Row(
                      children: [
                        Text(
                          'تسجيل الدخول',
                          style: AppStyles.styleBold24(context).copyWith(
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                      ],
                    ),
                    24.verticalSpace,
                    TextFormFieldWithTitleWidget(
                      controller: cubit.identityNumberController,
                      label: 'رقم الهوية الوطنة / الاقامة',
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى إدخال رقم الهوية الوطنية / الاقامة';
                        }
                        if (value.isEmpty) {
                          return 'يرجى إدخال رقم الهوية الوطنية / الاقامة';
                        }
                        if (value.length != 10) {
                          return 'رقم الهوية الوطنية يجب ان يتكون من 10 ارقام';
                        }
                        if (!value.startsWith('1') && !value.startsWith('2')) {
                          return 'رقم الهوية الوطنية / الاقامة خطأ';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      keyboardType: TextInputType.number,
                      prefix: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 16,
                        ),
                        child: SvgPicture.asset(AppAssets.app_imagesNationalId),
                      ),
                    ),
                    20.verticalSpace,
                    const LoginPasswordWidget(),
                    24.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const RememberUserWidget(),
                        InkWell(
                          onTap: () {
                            context.navigateTo(Routes.forgetPasswordScreen);
                          },
                          child: Text(
                            'نسيت كلمة المرور',
                            style: AppStyles.styleBold16(context)
                                .copyWith(color: AppColors.primary(context)),
                          ),
                        ),
                      ],
                    ),
                    30.verticalSpace,
                    const LoginButtonWidget(),
                    30.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.separatingBorder1(context),
                          ),
                        ),
                        6.horizontalSpace,
                        Text(
                          'او',
                          style: AppStyles.styleBold14(context).copyWith(
                              color: AppColors.typographyBody(context)),
                        ),
                        6.horizontalSpace,
                        Expanded(
                          child: Divider(
                            color: AppColors.separatingBorder1(context),
                          ),
                        )
                      ],
                    ),
                    24.verticalSpace,
                    OutlinedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.app_imagesNafathLogo),
                          const SizedBox(width: 12),
                          Text(
                            'تسجيل الدخول عبر نفاذ',
                            style: AppStyles.styleBold14(context).copyWith(
                              color: AppColors.typographyBody(context),
                              height: 1.77,
                            ),
                          ),
                        ],
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 55),
                        side: BorderSide(
                          color: AppColors.backgroundTertiary(context),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        foregroundColor: AppColors.white(context),
                        backgroundColor: AppColors.white(context),
                      ),
                    ),
                    48.verticalSpace,
                    NavToAnotherScreenRow(
                      onTap: () {
                        context.navigateTo(Routes.signUpScreen);
                      },
                            text1: 'غير مسجل',
                            text2: 'إنشاء حساب جديد',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RememberUserWidget extends StatefulWidget {
  const RememberUserWidget({
    super.key,
  });

  @override
  State<RememberUserWidget> createState() => _RememberUserWidgetState();
}

class _RememberUserWidgetState extends State<RememberUserWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Row(
        children: [
          Checkbox.adaptive(
            checkColor: AppColors.white(context),
            activeColor: AppColors.primary(context),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
          Text(
            'تذكرني',
            style: AppStyles.styleBold16(context)
                .copyWith(color: AppColors.typographyBody(context)),
          ),
        ],
      ),
    );
  }
}

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return ElevatedButton(
      onPressed: () {
        cubit.login();
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.loginRequestState != current.loginRequestState,
        listener: (context, state) {
          if (state.loginRequestState == RequestState.loaded) {
            context.navigateToWithArguments(Routes.oTPScreen, {
              'nextRoute': Routes.layoutScreen,
              'totalSteps': 2,
              'currentStep': 2,
              'width': 123.0,
            });
            mySnackBar(
              state.loginMsg ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: false,
            );
          } else if (state.loginRequestState == RequestState.error) {
            FloatingSnackBar.show(
              context,
              state.loginError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.loginRequestState == RequestState.loading) {
            return Lottie.asset(
              AppAnimationAssets.loading,
            );
          } else {
            return Text(
              'تسجيل الدخول',
              style: AppStyles.styleBold18(context)
                  .copyWith(color: AppColors.white(context)),
            );
          }
        },
      ),
    );
  }
}
