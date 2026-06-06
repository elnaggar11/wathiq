import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/custom_progress_bar.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/timer_widget.dart';

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/adaptive_layout_widget.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/otp/pin_code_widget.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    required this.nextRoute,
    required this.currentStep,
    required this.totalSteps,
    required this.width,
    this.title,
  });

  final String nextRoute;
  final String? title;
  final int currentStep;
  final int totalSteps;
  final double width;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(),
        body: AdaptiveLayout(
          mobileLayout: (context) => OTPScreenMobileLayoutWidget(
            nextRoute: widget.nextRoute,
            currentStep: widget.currentStep,
            totalSteps: widget.totalSteps,
            width: widget.width,
          ),
          tabletLayout: (context) => Center(
            child: SizedBox(
              height: 1.sw,
              width: 600,
              child: OTPScreenMobileLayoutWidget(
                nextRoute: widget.nextRoute,
                currentStep: widget.currentStep,
                totalSteps: widget.totalSteps,
                width: widget.width,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OTPScreenMobileLayoutWidget extends StatelessWidget {
  const OTPScreenMobileLayoutWidget({
    super.key,
    required this.nextRoute,
    required this.currentStep,
    required this.totalSteps,
    required this.width,
    this.title,
  });

  final String nextRoute;
  final int currentStep;
  final int totalSteps;
  final double width;
  final String? title;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                48.verticalSpace,
                OTPStepperWidget(
                  currentStep: currentStep,
                  totalSteps: totalSteps,
                ),
                40.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'أدخل رمز التحقق',
                      textAlign: TextAlign.start,
                      style: AppStyles.styleBold24(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title ??
                          'فضلا ادخل الرمز المكون من 6 ارقام المرسل لك عبر رساله\n نصية',
                      textAlign: TextAlign.start,
                      style: AppStyles.styleSemiBold14(context).copyWith(
                        color: AppColors.typographyBody(context),
                      ),
                    ),
                  ],
                ),
                32.verticalSpace,
                const PinCodeWidget(),
                24.verticalSpace,
                const TimerWidget(),
                24.verticalSpace,
                VerifyButtonWidget(
                  nextRoute: nextRoute,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPStepperWidget extends StatelessWidget {
  const OTPStepperWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomProgressBar(
        totalSteps: totalSteps,
        currentStep: currentStep,
      ),
    );
  }
}

class VerifyButtonWidget extends StatelessWidget {
  const VerifyButtonWidget({
    super.key,
    required this.nextRoute,
  });
  final String nextRoute;

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return ElevatedButton(
      onPressed: () {
        cubit.verifyOtp();
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.verifyRequestState != current.verifyRequestState,
        listener: (context, state) {
          if (state.verifyRequestState == RequestState.loaded) {
            if (nextRoute == Routes.userInfoScreen) {
              context.navigateToWithReplacementNamed(nextRoute);
            } else if (nextRoute == Routes.layoutScreen) {
              FloatingSnackBar.show(
                context,
                'مرحبا بكم بمنصة وثيق',
                isError: false,
              );
              context.navigateToWithReplacementAndClearStack(nextRoute);
            } else if (nextRoute == Routes.resetPasswordScreen ||
                nextRoute == Routes.changeEmailScreen ||
                nextRoute == Routes.changePhoneNumberScreen) {
              context.navigateToWithReplacementNamed(nextRoute);
            } else {
              context.navigateToWithReplacementAndClearStack(nextRoute);
            }
          } else if (state.verifyRequestState == RequestState.error) {
            mySnackBar(
              state.verifyError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.verifyRequestState == RequestState.loading) {
            return Lottie.asset(
              AppAnimationAssets.loading,
            );
          } else {
            return Text(
              'التحقق',
              style: AppStyles.styleBold18(context)
                  .copyWith(color: AppColors.white(context)),
            );
          }
        },
      ),
    );
  }
}
