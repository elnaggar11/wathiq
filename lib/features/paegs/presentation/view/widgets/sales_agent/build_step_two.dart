import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/sales_agent/bank_names_dropdown_button_form_field_widget.dart';

import '../../../../../../core/utils/images.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../view_model/pages_cubit.dart';
import '../../widgets/sales_agent/stepper_widget.dart';

class BuildStepTwoWidget extends StatefulWidget {
  const BuildStepTwoWidget({super.key});

  @override
  State<BuildStepTwoWidget> createState() => _BuildStepTwoWidgetState();
}

class _BuildStepTwoWidgetState extends State<BuildStepTwoWidget> {
  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: pagesCubit.bankDateFormKey,
          child: Column(
            children: [
              const SizedBox(height: 24),
              StepperWidget(
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
                  children: [
                    BankNamesDropdownButtonFormFieldWidget(),
                    const SizedBox(height: 16),
                    TextFormFieldWithTitleWidget(
                      controller: pagesCubit.bankAccountNumberController,
                      filled: true,
                      fillColor: AppColors.primarySurface(context),
                      label: 'رقم الأيبان',
                      validator: (value) {
                        if (value == null) {
                          return 'يرجى إدخال رقم الآيبان';
                        }
                        if (value.isEmpty) {
                          return 'يرجى إدخال رقم الآيبان';
                        }
                        if (value.length != 24) {
                          return ' رقم الايبان يجب ان يتكون من 22 رقم';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(24),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          if (!value.startsWith("SA")) {
                            pagesCubit.bankAccountNumberController.text = "SA";
                            pagesCubit.bankAccountNumberController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: pagesCubit
                                      .bankAccountNumberController.text.length),
                            );
                          }
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        pagesCubit.pickbankCertificate().then((val) {
                          setState(() {});
                        });
                      },
                      child: TextFormFieldWithTitleWidget(
                        label: pagesCubit.bankCertificate == null
                            ? 'إرفاق الشهادة المصرفية'
                            : pagesCubit.bankCertificate!.path.split('/').last,
                        validator: (value) {
                          if (pagesCubit.bankCertificate == null) {
                            return 'يرجى إرفاق الشهادة المصرفية';
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
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
