import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/app_animations.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../paegs/presentation/view/widgets/sales_agent/stepper_widget.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  @override
  void initState() {
    if (Kphone != null) {
      context.read<ProfileCubit>().editablePhoneController.text = Kphone!;
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
          mobileLayout: (context) => ChangePhoneNumberMobileLayoutWidget(),
          tabletLayout: (context) => Center(
            child: SizedBox(
              height: 1.sw,
              width: 600,
              child: ChangePhoneNumberMobileLayoutWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class ChangePhoneNumberMobileLayoutWidget extends StatelessWidget {
  const ChangePhoneNumberMobileLayoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = context.read<ProfileCubit>();
    return Form(
      key: cubit.editphoneKey,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                48.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      'ادخل رقم الجوال',
                      style: AppStyles.styleBold24(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                  ],
                ),
                40.verticalSpace,
                TextFormFieldWithTitleWidget(
                  controller: cubit.editablePhoneController,
                  label: 'رقم الجوال',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال رقم الجوال';
                    }
                    if (!RegExp(r'^5\d{8}$').hasMatch(value)) {
                      return 'يجب أن يبدأ رقم الجوال ب 5 ويتكون من 9 أرقام';
                    }
                    return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(9),
                  ],
                  keyboardType: TextInputType.number,
                  suffixIconSize: 70,
                  suffix: Row(
                    children: [
                      Container(
                        height: 50.h,
                        width: 1.w,
                        color: AppColors.separatingBorder(context),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 0.w,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          height: 24.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            '966+',
                            style: AppStyles.styleBold16(context).copyWith(
                              color: AppColors.typographyHeading(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  prefix: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 24,
                        maxHeight: 24,
                      ),
                      child: SvgPicture.asset(
                        AppAssets.app_imagesPhone,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                31.verticalSpace,
                ChangePhoneNumberButtonWidget(),
                31.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChangePhoneNumberButtonWidget extends StatelessWidget {
  const ChangePhoneNumberButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = context.read<ProfileCubit>();

    return ElevatedButton(
      onPressed: () {
        cubit.addPhone();
      },
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) =>
            previous.addPhoneRequestState != current.addPhoneRequestState,
        listener: (context, state) {
          if (state.addPhoneRequestState == RequestState.loaded) {
            context.navigateToWithArguments(Routes.oTPScreen, {
              'nextRoute': Routes.userInfoScreen,
              'totalSteps': 3,
              'currentStep': 3,
              'width': 95.0,
              'title': 'فضلا ادخل الرمز  المرسل الي بريدك الاليكتروني'
            });
            mySnackBar(
              state.addPhoneModelMsg ?? 'تم',
              context,
              isError: false,
            );
          } else if (state.addPhoneRequestState == RequestState.error) {
            mySnackBar(
              state.addPhoneError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.addPhoneRequestState == RequestState.loading) {
            return Lottie.asset(
              AppAnimationAssets.loading,
            );
          } else {
            return Text(
              'التالي',
              style: AppStyles.styleBold18(context)
                  .copyWith(color: AppColors.white(context)),
            );
          }
        },
      ),
    );
  }
}
