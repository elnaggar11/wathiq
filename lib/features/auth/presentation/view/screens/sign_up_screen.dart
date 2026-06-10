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

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/adaptive_layout_widget.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/custom_progress_bar.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/contact_us_auth_widget.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/nav_to_another_screen_row.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/sign_up/terms_and_conditions_widget.dart';
import 'package:animate_do/animate_do.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>();
    return SafeArea(
      child: Scaffold(
        bottomSheet: FadeInDown(
          delay: const Duration(milliseconds: 300),
          child: const ContactUsAuthWidget(),
        ),
        backgroundColor: AppColors.white(context),
        appBar: CoustomAppBarWidget(),
        body: AdaptiveLayout(
          mobileLayout: (context) => const SignUpScreenMobileLayoutWidget(),
          tabletLayout: (context) => Center(
            child: SizedBox(
              height: 1.sw,
              width: 600,
              child: const SignUpScreenMobileLayoutWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpScreenMobileLayoutWidget extends StatelessWidget {
  const SignUpScreenMobileLayoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();
    return Form(
      key: cubit.signUpFormKey,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                48.verticalSpace,
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 200),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: CustomProgressBar(
                      totalSteps: 3,
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
                            'إنشاء حساب',
                            style: AppStyles.styleBold24(context).copyWith(
                              color: AppColors.typographyHeading(context),
                            ),
                          ),
                        ],
                      ),
                      24.verticalSpace,
                      TextFormFieldWithTitleWidget(
                        controller: cubit.signUpNationalIDController,
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
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 24,
                              maxHeight: 24,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.app_imagesNationalId,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      12.verticalSpace,
                      const TermsAndConditionsWidget(),
                      31.verticalSpace,
                      const SignUpButtonWidget(),
                      31.verticalSpace,
                      NavToAnotherScreenRow(
                        onTap: () {
                          context.navigateTo(Routes.login);
                        },
                        text1: 'لديك حساب ؟',
                        text2: 'تسجيل الدخول',
                      ),
                      100.verticalSpace,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return ElevatedButton(
      onPressed: () {
        if (!isAgreeTerms) {
          FloatingSnackBar.show(context, 'يرجي قبول الشروط والاحكام');
          return;
        }
        cubit.signUp();
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.signUpRequestState != current.signUpRequestState,
        listener: (context, state) {
          if (state.signUpRequestState == RequestState.loaded) {
            context.navigateTo(
              Routes.completeSignUpScreen,
            );
          } else if (state.signUpRequestState == RequestState.error) {
            mySnackBar(
              state.signUpError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.signUpRequestState == RequestState.loading) {
            return Lottie.asset(
              AppAnimationAssets.loading,
            );
          } else {
            return Text(
              'إنشاء حساب جديد',
              style: AppStyles.styleBold18(context)
                  .copyWith(color: AppColors.white(context)),
            );
          }
        },
      ),
    );
  }
}
