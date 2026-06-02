import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import 'package:wathiq/core/widgets/adaptive_layout_widget.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/stepper_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/change_email/change_email_button_widget.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  @override
  void initState() {
    if (Kemail != null) {
      context.read<ProfileCubit>().emailController.text = Kemail!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProfileCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(
          title: '',
        ),
        body: AdaptiveLayout(
          mobileLayout: (context) => const ChangeEmailScreenMobileLayoutWidget(),
          tabletLayout: (context) => Center(
            child: SizedBox(
              height: 1.sw,
              width: 600,
              child: const ChangeEmailScreenMobileLayoutWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class ChangeEmailScreenMobileLayoutWidget extends StatelessWidget {
  const ChangeEmailScreenMobileLayoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = context.read<ProfileCubit>();
    return Form(
      key: cubit.editEmaileKey,
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
                  children: [
                    Text(
                      'ادخل البريد الالكتروني',
                      style: AppStyles.styleBold24(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                  ],
                ),
                40.verticalSpace,
                TextFormFieldWithTitleWidget(
                  controller: cubit.emailController,
                  label: 'البريد الاليكتروني ',
                  validator: (value) {
                    if (value == null) {
                      return 'يرجى ادخال البريد الاليكتروني  ';
                    }
                    if (value.isEmpty) {
                      return 'يرجى ادخال البريد الاليكتروني  ';
                    }
                    if (!value.contains('@')) {
                      return 'يرجى ادخال  بريد الكتروني صحيح ';
                    }

                    return null;
                  },
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
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
                        Assets.imagesLetter,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                31.verticalSpace,
                const ChangeEmailButtonWidget(),
                31.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
