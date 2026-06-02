import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/adaptive_layout_widget.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/stepper_widget.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/reset_and_forget_password/reset_password_widget.dart';

class ResetePasswordScreen extends StatelessWidget {
  const ResetePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(),
        body: AdaptiveLayout(
          mobileLayout: (context) =>
              const ResetePasswordScreenMobileLayoutWidget(),
          tabletLayout: (context) => Center(
            child: SizedBox(
              height: 1.sw,
              width: 600,
              child: const ResetePasswordScreenMobileLayoutWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class ResetePasswordScreenMobileLayoutWidget extends StatelessWidget {
  const ResetePasswordScreenMobileLayoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return Form(
      key: cubit.resetPasswordFormKey,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                48.verticalSpace,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: StepperWidget(
                    stepperList: [
                      BuildStep(
                        title: '',
                        isActive: true,
                        isCompleted: true,
                        stepNum: '1',
                      ),
                      SteperLineWidegt(
                        isActive: true,
                      ),
                      BuildStep(
                        title: '',
                        isActive: true,
                        isCompleted: true,
                        stepNum: '2',
                      ),
                      SteperLineWidegt(
                        isActive: true,
                      ),
                      BuildStep(
                        title: '',
                        isActive: true,
                        isCompleted: false,
                        stepNum: '3',
                      ),
                    ],
                  ),
                ),
                32.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'إعادة تعين كلمة المرور',
                      textAlign: TextAlign.start,
                      style: AppStyles.styleBold24(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                  ],
                ),
                32.verticalSpace,
                const ResetPasswordWidget(),
                20.verticalSpace,
                const ResetConfirmPasswordWidget(),
                32.verticalSpace,
                const ResetPasswordButtonWidget(),
                32.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordButtonWidget extends StatelessWidget {
  const ResetPasswordButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return ElevatedButton(
      onPressed: () {
        cubit.resetPassword();
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.resetPasswordRequestState !=
            current.resetPasswordRequestState,
        listener: (context, state) {
          if (state.resetPasswordRequestState == RequestState.loaded) {
            context.navigateToWithReplacementAndClearStack(
              Routes.layoutScreen,
            );
            mySnackBar(
              'تم إعادة تعين كلمة المرور بنجاح',
              context,
              isError: false,
            );
          } else if (state.resetPasswordRequestState == RequestState.error) {
            mySnackBar(
              state.resetPasswordError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.resetPasswordRequestState == RequestState.loading) {
            return Lottie.asset(
              AppAnimationAssets.loading,
            );
          } else {
            return Text(
              'تأكيد',
              style: AppStyles.styleBold18(context)
                  .copyWith(color: AppColors.white(context)),
            );
          }
        },
      ),
    );
  }
}
