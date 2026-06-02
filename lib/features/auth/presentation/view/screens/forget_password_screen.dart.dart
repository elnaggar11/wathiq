import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';

import 'package:wathiq/core/widgets/adaptive_layout_widget.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/stepper_widget.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/reset_and_forget_password/forget_password_button_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(),
        body: AdaptiveLayout(
          mobileLayout: (context) => const ForgetPasswordMobileLayoutWidget(),
          tabletLayout: (context) => Center(
            child: SizedBox(
              height: 1.sw,
              width: 600,
              child: const ForgetPasswordMobileLayoutWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordMobileLayoutWidget extends StatelessWidget {
  const ForgetPasswordMobileLayoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return Form(
      key: cubit.forgetPasswordFormKey,
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
                        isActive: false,
                      ),
                      BuildStep(
                        title: '',
                        isActive: false,
                        isCompleted: false,
                        stepNum: '2',
                      ),
                      SteperLineWidegt(
                        isActive: false,
                      ),
                      BuildStep(
                        title: '',
                        isActive: false,
                        isCompleted: false,
                        stepNum: '3',
                      ),
                    ],
                  ),
                ),
                40.verticalSpace,
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
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'أدخل الهوية الوطنة / الاقامة الخاصة بك',
                      textAlign: TextAlign.start,
                      style: AppStyles.styleSemiBold14(context).copyWith(
                        color: AppColors.typographyBody(context),
                      ),
                    ),
                  ],
                ),
                32.verticalSpace,
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
                      horizontal: 16.w,
                    ),
                    child: SvgPicture.asset(AppAssets.app_imagesNationalId),
                  ),
                ),
                32.verticalSpace,
                const ForgetPasswordButtonWidget(),
                31.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
