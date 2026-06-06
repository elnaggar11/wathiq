import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/select_tax_status_radio_button.dart';

import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/sign_up/date_picker_widegt.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/stepper_widget.dart';

class BuildStepOneWidget extends StatefulWidget {
  const BuildStepOneWidget({super.key});

  @override
  State<BuildStepOneWidget> createState() => _BuildStepOneWidgetState();
}

class _BuildStepOneWidgetState extends State<BuildStepOneWidget> {
  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: pagesCubit.companyDataFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    isActive: false,
                  ),
                  BuildStep(
                    title: 'البيانات المالية',
                    isActive: false,
                    isCompleted: false,
                    stepNum: '2',
                  ),
                  SteperLineWidegt(
                    isActive: false,
                  ),
                  BuildStep(
                    title: 'بيانات المفوض',
                    isActive: false,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إنشاء حساب وكلاء البيع',
                      style: AppStyles.styleBold24(context),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormFieldWithTitleWidget(
                      filled: true,
                      fillColor: AppColors.primarySurface(context),
                      controller: pagesCubit.companyNameController,
                      label: 'اسم الشركة',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى إدخال اسم الشركة';
                        }
                        if (value.isEmpty) {
                          return 'يرجى إدخال اسم الشركة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'معتمد من انفاذ',
                      style: AppStyles.styleSemiBold18(context),
                    ),
                    const SizedBox(height: 8),
                    const SelectNafathApprovedRadioButton(),
                    const SizedBox(height: 16),
                    const SelectAccreditationRequestRadioButton(),
                    const SizedBox(height: 24),
                    TextFormFieldWithTitleWidget(
                      filled: true,
                      fillColor: AppColors.primarySurface(context),
                      controller: pagesCubit.commercialRegNumberController,
                      label: 'رقم السجل التجاري',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى إدخال رقم السجل التجاري';
                        }
                        if (value.isEmpty) {
                          return 'يرجى إدخال رقم السجل التجاري';
                        }
                        if (value.length != 10) {
                          return 'رقم السجل التجاري لابد ان يتكون من 10 ارقام';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DatePickerWidegt(
                            text: 'تاريخ الاصدار',
                            controller:
                                pagesCubit.commercialRegStartDateController,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: DatePickerWidegt(
                            text: 'تاريخ الانتهاء',
                            controller:
                                pagesCubit.commercialRegEndDateController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        pagesCubit
                            .pickCommercialRegisterAttachment()
                            .then((val) {
                          setState(() {});
                        });
                      },
                      child: TextFormFieldWithTitleWidget(
                        filled: true,
                        fillColor: AppColors.primarySurface(context),
                        label: pagesCubit.commercialRegisterAttachment == null
                            ? 'إرفاق السجل التجاري'
                            : pagesCubit.commercialRegisterAttachment!.path
                                .split('/')
                                .last,
                        validator: (value) {
                          if (pagesCubit.commercialRegisterAttachment == null) {
                            return 'يرجى إرفاق السجل التجاري';
                          }
                          return null;
                        },
                        hintStyle: AppStyles.styleBold16(context),
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
                    TextFormFieldWithTitleWidget(
                      filled: true,
                      fillColor: AppColors.primarySurface(context),
                      controller: pagesCubit.valAuctionsLicenseNumberController,
                      label: 'رقم رخصة فال للمزادات',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى إدخال رقم رخصة فال للمزادات';
                        }
                        if (value.isEmpty) {
                          return 'يرجى إدخال رقم رخصة فال للمزادات';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        pagesCubit.pickvalAttachment().then((val) {
                          setState(() {});
                        });
                      },
                      child: TextFormFieldWithTitleWidget(
                        filled: true,
                        fillColor: AppColors.primarySurface(context),
                        label: pagesCubit.valAttachment == null
                            ? 'إرفاق رخصة فال'
                            : pagesCubit.valAttachment!.path.split('/').last,
                        validator: (value) {
                          if (pagesCubit.valAttachment == null) {
                            return 'يرجى إرفاق رخصة فال للمزادات';
                          }
                          return null;
                        },
                        hintStyle: AppStyles.styleBold16(context),
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
                    Text(
                      'الضريبة',
                      style: AppStyles.styleBold16(context),
                    ),
                    const SizedBox(height: 8),
                    const SelectTaxStatusRadioButton(),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        pagesCubit.pickAssociationAttachment().then((val) {
                          setState(() {});
                        });
                      },
                      child: TextFormFieldWithTitleWidget(
                        filled: true,
                        fillColor: AppColors.primarySurface(context),
                        label: pagesCubit.AssociationAttachment == null
                            ? 'إرفاق عقد التأسيس (غير الزامي)'
                            : pagesCubit.AssociationAttachment!.path
                                .split('/')
                                .last,
                        validator: (value) {
                          return null;
                        },
                        hintStyle: AppStyles.styleBold16(context),
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
                    TextFormFieldWithTitleWidget(
                      filled: true,
                      fillColor: AppColors.primarySurface(context),
                      controller: pagesCubit.companyEmailController,
                      label: 'البريد الإلكتروني',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى إدخال البريد الإلكتروني';
                        }
                        if (value.isEmpty) {
                          return 'يرجى إدخال البريد الإلكتروني';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormFieldWithTitleWidget(
                      filled: true,
                      fillColor: AppColors.primarySurface(context),
                      controller: pagesCubit.companyPhoneNumberController,
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
                    ),

                    // const SizedBox(height: 24),
                    // Text(
                    //   'النشاط العقاري',
                    //   style: AppStyles.styleSemiBold18(context),
                    // ),
                    // const SizedBox(height: 4),
                    // RealEstateActivityWidget(),
                    // const SizedBox(height: 24),
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
