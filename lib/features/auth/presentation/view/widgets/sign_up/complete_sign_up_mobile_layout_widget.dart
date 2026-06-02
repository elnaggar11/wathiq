import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/sign_up/sign_up_password_widget.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/stepper_widget.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';

class CompleteSignUpMobileLayoutWidget extends StatefulWidget {
  const CompleteSignUpMobileLayoutWidget({
    super.key,
  });

  @override
  State<CompleteSignUpMobileLayoutWidget> createState() =>
      _CompleteSignUpMobileLayoutWidgetState();
}

class _CompleteSignUpMobileLayoutWidgetState
    extends State<CompleteSignUpMobileLayoutWidget> {
  @override
  void initState() {
    context.read<AuthCubit>().getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return Form(
      key: cubit.completeSignUpFormKey,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                24.verticalSpace,
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
                48.verticalSpace,
                Row(
                  children: [
                    Text(
                      'إنشاء حساب جديد',
                      style: AppStyles.styleBold24(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                  ],
                ),
                24.verticalSpace,
                const SignUpPasswordWidget(),
                20.verticalSpace,
                const CitiesDropdownButtonFormFieldWidget(), 20.verticalSpace,
                TextFormFieldWithTitleWidget(
                  controller: cubit.completeSignUpPhoneController,
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
                        AppAssets.app_imagesPhone,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                32.verticalSpace,
                Divider(
                  color: AppColors.disabled(context),
                  thickness: 2,
                  height: 0,
                ),
                32.verticalSpace,
                TextFormFieldWithTitleWidget(
                  // controller: cubit.completeSignUpNameController,
                  label: 'الاسم الكامل',
                  controller: cubit.completeSignUpNameController,

                  fillColor: AppColors.success05(context),
                  enabled: false,
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
                        AppAssets.app_imagesPerson,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
                TextFormFieldWithTitleWidget(
                  // controller: cubit.loginUserIDController,
                  label: 'رقم الهوية الوطنة / الاقامة',
                  controller: cubit.completeSignUpNationalIDController,

                  fillColor: AppColors.success05(context),
                  enabled: false,
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

                20.verticalSpace,

                // TextFormFieldWithTitleWidget(
                //   // controller: cubit.loginUserIDController,
                //  label: 'البريد الاليكتروني',
                //   hint: 'ادخل البريد الاليكتروني',

                //   validator: (value) {
                //     if (value == null) {
                //       return 'يرجى ادخال الرقم ';
                //     }
                //     if (value.isEmpty) {
                //       return 'يرجى ادخال الرقم ';
                //     }
                //     return null;
                //   },

                //   keyboardType: TextInputType.emailAddress,
                //   prefix: Padding(
                //     padding: EdgeInsets.symmetric(
                //       vertical: 12,
                //       horizontal: 16,
                //     ),
                //     child: ConstrainedBox(
                //       constraints: BoxConstraints(
                //         maxWidth: 24,
                //         maxHeight: 24,
                //       ),
                //       child: SvgPicture.asset(
                //         Assets.imagesLetter,
                //         fit: BoxFit.fill,
                //       ),
                //     ),
                //   ),
                // ),
                // 20.verticalSpace,
                // DatePickerWidegt(
                //     text: 'تاريخ الميلاد',
                //     controller: context
                //         .read<AuthCubit>()
                //         .completeSignUpBirthDateController),
                43.verticalSpace,
                const CompleteSignUpButtonWidget(),
                24.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompleteSignUpButtonWidget extends StatelessWidget {
  const CompleteSignUpButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return ElevatedButton(
      onPressed: () {
        cubit.completeSignUp();
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.completeSignUpRequestState !=
            current.completeSignUpRequestState,
        listener: (context, state) {
          if (state.completeSignUpRequestState == RequestState.loaded) {
            context.navigateToWithArguments(Routes.oTPScreen, {
              'nextRoute': Routes.layoutScreen,
              'totalSteps': 3,
              'currentStep': 3,
              'width': 95.0,
            });
            mySnackBar(
              state.completeSignUpMsg ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: false,
            );
          } else if (state.completeSignUpRequestState == RequestState.error) {
            mySnackBar(
              state.completeSignUpError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.completeSignUpRequestState == RequestState.loading) {
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

class CitiesDropdownButtonFormFieldWidget extends StatefulWidget {
  const CitiesDropdownButtonFormFieldWidget({super.key, this.selectedValue});
  final String? selectedValue;

  @override
  State<CitiesDropdownButtonFormFieldWidget> createState() =>
      _DropdownButtonFormFieldWidgetState();
}

class _DropdownButtonFormFieldWidgetState
    extends State<CitiesDropdownButtonFormFieldWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = context.read<AuthCubit>();
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.getCountriesRequestState == RequestState.error) {
          return ErrorAppWidget(
              text: 'جدث شئ ما خطأ',
              onTap: () {
                context.read<AuthCubit>().getCountries();
              });
        } else {
          final countries = state.getCountriesModel?.data ?? [];

          // تحديث القيمة المحددة إذا كانت موجودة في القائمة
          if (selectedValue != null && countries.isNotEmpty) {
            final country = countries.firstWhere(
              (country) => country.name == selectedValue,
              orElse: () => countries.first,
            );
            authCubit.completeSignUpCountryID = country.id;
            profileCubit.editUserInfoCountryID = country.id;
          }

          // إنشاء قائمة فريدة من العناصر
          final uniqueItems = countries
              .map((country) => DropdownMenuItem<String>(
                    value: country.name,
                    onTap: () {
                      authCubit.completeSignUpCountryID = country.id;
                      profileCubit.editUserInfoCountryID = country.id;
                      profileCubit.EditCountryIDFunction();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        country.name,
                        style: AppStyles.styleRegular16(context)
                            .copyWith(color: AppColors.typographyBody(context)),
                      ),
                    ),
                  ))
              .toList();

          // التحقق من وجود القيمة المحددة في القائمة
          if (selectedValue != null &&
              !uniqueItems.any((item) => item.value == selectedValue)) {
            selectedValue = null;
          }

          // إذا كانت القائمة فارغة، نعرض رسالة
          if (countries.isEmpty) {
            return Center(
              child: Text(
                'جاري تحميل المدن...',
                style: AppStyles.styleRegular16(context),
              ),
            );
          }

          return DropdownButtonFormField<String>(
            initialValue: selectedValue,
            menuMaxHeight: 600,
            dropdownColor: AppColors.white(context),
            style: AppStyles.styleBold16(context).copyWith(),
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
            validator: (value) {
              if (authCubit.completeSignUpCountryID == null) {
                return 'يرجى اختيار المدينة';
              }
              return null;
            },
            items: uniqueItems,
            decoration: InputDecoration(
              labelText: selectedValue ?? 'المدينة',
              labelStyle: AppStyles.styleRegular16(context).copyWith(
                color: AppColors.typographyBody(context),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 14,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 24,
                    maxHeight: 24,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.app_imagesMapPoint,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              filled: true,
              fillColor: AppColors.white(context),
              hintStyle: AppStyles.styleBold16(context).copyWith(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                    color: AppColors.backgroundTertiary(context), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                    color: AppColors.backgroundTertiary(context), width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                    color: AppColors.backgroundTertiary(context), width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(color: AppColors.error(context), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(color: AppColors.primary(context), width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(color: AppColors.primary(context), width: 1),
              ),
            ),
            icon: selectedValue == null
                ? SvgPicture.asset(
                    Assets.imagesArrowDown,
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        selectedValue = null;
                      });
                      authCubit.completeSignUpCountryID = null;
                      profileCubit.deleteCountryIDFunction();
                      authCubit.getCountries();
                    },
                    child: SizedBox(
                      child: SvgPicture.asset(
                        Assets.imagesCloseIcon,
                      ),
                    ),
                  ),
          );
        }
      },
    );
  }
}
