import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';

import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/sign_up/date_picker_widegt.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/stepper_widget.dart';

class BuildStepThreeWidget extends StatefulWidget {
  const BuildStepThreeWidget({super.key});

  @override
  State<BuildStepThreeWidget> createState() => _BuildStepThreeWidgetState();
}

class _BuildStepThreeWidgetState extends State<BuildStepThreeWidget> {
  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: pagesCubit.UserDataFormKey,
          child: Column(
            children: [
              const SizedBox(height: 24),
              const StepperWidget(
                stepperList: [
                  BuildStep(
                    title: 'بيانات الشركة',
                    isActive: true,
                    isCompleted: true,
                    stepNum: '1',
                  ),
                  SteperLineWidegt(
                    isActive: true,
                  ),
                  BuildStep(
                    title: 'البيانات المالية',
                    isActive: true,
                    isCompleted: true,
                    stepNum: '2',
                  ),
                  SteperLineWidegt(
                    isActive: true,
                  ),
                  BuildStep(
                    title: 'بيانات المفوض',
                    isActive: true,
                    isCompleted: false,
                    stepNum: '3',
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white /* Surface-page */,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    TextFormFieldWithTitleWidget(
                      filled: true,
                      fillColor: AppColors.primarySurface(context),
                      controller: pagesCubit.userNameController,
                      label: 'الاسم',
                      validator: (value) {
                        if (value == null) {
                          return ' الاسم مطلوب';
                        }
                        if (value.isEmpty) {
                          return ' الاسم مطلوب';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      prefix: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 16.w,
                        ),
                        child: SvgPicture.asset(AppAssets.app_imagesPerson),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormFieldWithTitleWidget(
                      filled: true,
                      fillColor: AppColors.primarySurface(context),
                      controller: pagesCubit.userIdentityNumberController,
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
                    const SizedBox(height: 24),
                    DatePickerWidegt(
                        text: 'تاريخ الميلاد',
                        controller: pagesCubit.userBirthDayController),
                    const SizedBox(height: 24),
                    TextFormFieldWithTitleWidget(
                      filled: true,
                      fillColor: AppColors.primarySurface(context),
                      controller: pagesCubit.userEmailController,
                      label: 'البريد الالكتروني',
                      validator: (value) {
                        if (value == null) {
                          return ' البريد الالكتروني مطلوب';
                        }
                        if (value.isEmpty) {
                          return ' البريد الالكتروني مطلوب';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      prefix: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 16.w,
                        ),
                        child: SvgPicture.asset(
                            AppAssets.app_imagesSealesEgentEmailIcn),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormFieldWithTitleWidget(
                      filled: true,
                      fillColor: AppColors.primarySurface(context),
                      controller: pagesCubit.userPhoneNumberController,
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
                      prefix: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 16.w,
                        ),
                        child: SvgPicture.asset(
                          AppAssets.app_imagesPhone,
                        ),
                      ),
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
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        pagesCubit.pickNationalIDAttachment().then((val) {
                          setState(() {});
                        });
                      },
                      child: TextFormFieldWithTitleWidget(
                        label: pagesCubit.NationalIDAttachment == null
                            ? 'إرفاق هوية المفوض'
                            : pagesCubit.NationalIDAttachment!.path
                                .split('/')
                                .last,
                        validator: (value) {
                          if (pagesCubit.NationalIDAttachment == null) {
                            return ' إرفاق الهوية مطلوب';
                          }

                          return null;
                        },
                        hintStyle: AppStyles.styleBold16(context),
                        filled: true,
                        fillColor: AppColors.backgroundPrimary(context),
                        enabled: false,
                        keyboardType: TextInputType.number,
                        prefix: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 16.w,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.app_imagesUploadeFilesIcon,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        pagesCubit.pickDelegationAttachment().then((val) {
                          setState(() {});
                        });
                      },
                      child: TextFormFieldWithTitleWidget(
                        label: pagesCubit.DelegationAttachment == null
                            ? 'إرفاق خطاب التفويض'
                            : pagesCubit.DelegationAttachment!.path
                                .split('/')
                                .last,
                        validator: (value) {
                          if (pagesCubit.DelegationAttachment == null) {
                            return ' إرفاق الخطاب مطلوب';
                          }

                          return null;
                        },
                        hintStyle: AppStyles.styleBold16(context),
                        filled: true,
                        fillColor: AppColors.backgroundPrimary(context),
                        enabled: false,
                        keyboardType: TextInputType.number,
                        prefix: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 16.w,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.app_imagesUploadeFilesIcon,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
