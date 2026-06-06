import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';

import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';

class SelectTaxStatusRadioButton extends StatefulWidget {
  const SelectTaxStatusRadioButton({super.key});

  @override
  State<SelectTaxStatusRadioButton> createState() =>
      _SelectTaxStatusRadioButtonState();
}

class _SelectTaxStatusRadioButtonState
    extends State<SelectTaxStatusRadioButton> {
  String? _selectedValue = 'خاضع للضريبة';

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
      context.read<PagesCubit>().taxType = _selectedValue!;
      print(_selectedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () => _handleRadioValueChange('خاضع للضريبة'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                      value: 'خاضع للضريبة',
                      groupValue: _selectedValue,
                      onChanged: _handleRadioValueChange,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(horizontal: -3, vertical: 0),
                      activeColor: AppColors.darkBlue(context),
                    ),
                    Text(
                      'خاضع للضريبة',
                      style: AppStyles.styleBold16(context).copyWith(
                        color: AppColors.typographySubTitle(context),
                      ),
                    ),
                  ],
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () => _handleRadioValueChange('غير خاضع للضريبة'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                      value: 'غير خاضع للضريبة',
                      groupValue: _selectedValue,
                      onChanged: _handleRadioValueChange,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(horizontal: -3, vertical: 0),
                      activeColor: AppColors.darkBlue(context),
                    ),
                    Text(
                      'غير خاضع للضريبة',
                      style: AppStyles.styleBold16(context).copyWith(
                        color: AppColors.typographySubTitle(context),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
        _selectedValue == 'خاضع للضريبة'
            ? Column(
                children: [
                  const SizedBox(height: 16),
                  TextFormFieldWithTitleWidget(
                    controller: pagesCubit.taxNumberController,
                    fillColor: AppColors.primarySurface(context),
                    filled: true,
                    label: 'الرقم الضريبي',
                    validator: (value) {
                      if (value == null && _selectedValue == 'خاضع للضريبة') {
                        return 'يرجى إدخال الرقم الضريبي';
                      }
                      if (value!.isEmpty && _selectedValue == 'خاضع للضريبة') {
                        return 'يرجى إدخال الرقم الضريبي';
                      }
                      if (_selectedValue == 'خاضع للضريبة') {
                        if (!value.startsWith('3') || value.length != 15) {
                          return 'الرقم الضريبي يجب أن يبدأ بـ ٣ ويتكون من ١٥ رقمًا';
                        }
                      }

                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      pagesCubit.pickTaxRegisterAttachment().then((val) {
                        setState(() {});
                      });
                    },
                    child: TextFormFieldWithTitleWidget(
                      label: pagesCubit.TaxRegisterAttachment == null
                          ? 'شهادة التسجيل الضريبي'
                          : pagesCubit.TaxRegisterAttachment!.path
                              .split('/')
                              .last,
                      validator: (value) {
                        if (pagesCubit.TaxRegisterAttachment == null &&
                            _selectedValue == 'خاضع للضريبة') {
                          return 'يرجى إرفاق شهادة التسجيل الضريبي';
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
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

class SelectNafathApprovedRadioButton extends StatefulWidget {
  const SelectNafathApprovedRadioButton({super.key});

  @override
  State<SelectNafathApprovedRadioButton> createState() =>
      _SelectNafathApprovedRadioButtonState();
}

class _SelectNafathApprovedRadioButtonState
    extends State<SelectNafathApprovedRadioButton> {
  String? _selectedValue = 'نعم';
  String? _selectedAccreditationRequestValue = 'نعم';

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
      if (value == 'نعم') {
        context.read<PagesCubit>().approvedByNafath = true;
      } else {
        context.read<PagesCubit>().approvedByNafath = false;
      }
      print(_selectedValue);
    });
  }

  void _handleAccreditationRequestRadioValueChange(String? value) {
    setState(() {
      _selectedAccreditationRequestValue = value;
      if (value == 'نعم') {
        context.read<PagesCubit>().accreditationRequest = true;
      } else {
        context.read<PagesCubit>().accreditationRequest = false;
      }

      print(_selectedAccreditationRequestValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () => _handleRadioValueChange('نعم'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                      value: 'نعم',
                      groupValue: _selectedValue,
                      onChanged: _handleRadioValueChange,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(horizontal: -3, vertical: 0),
                      activeColor: AppColors.darkBlue(context),
                    ),
                    Text(
                      'نعم',
                      style: AppStyles.styleBold16(context).copyWith(
                        color: AppColors.typographySubTitle(context),
                      ),
                    ),
                  ],
                ),
              )),
              Expanded(
                child: GestureDetector(
                  onTap: () => _handleRadioValueChange('لا'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                        value: 'لا',
                        groupValue: _selectedValue,
                        onChanged: _handleRadioValueChange,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity:
                            const VisualDensity(horizontal: -3, vertical: 0),
                        activeColor: AppColors.darkBlue(context),
                      ),
                      Text(
                        'لا',
                        style: AppStyles.styleBold16(context).copyWith(
                          color: AppColors.typographySubTitle(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SelectAccreditationRequestRadioButton extends StatefulWidget {
  const SelectAccreditationRequestRadioButton({super.key});

  @override
  State<SelectAccreditationRequestRadioButton> createState() =>
      _SelectAccreditationRequestRadioButtonState();
}

class _SelectAccreditationRequestRadioButtonState
    extends State<SelectAccreditationRequestRadioButton> {
  String? _selectedAccreditationRequestValue = 'لا';

  void _handleAccreditationRequestRadioValueChange(String? value) {
    setState(() {
      _selectedAccreditationRequestValue = value;
      if (value == 'نعم') {
        context.read<PagesCubit>().accreditationRequest = true;
      } else {
        context.read<PagesCubit>().accreditationRequest = false;
      }

      print(_selectedAccreditationRequestValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' هل ترغب بتقديم طلب الاعتماد',
          style: AppStyles.styleBold16(context),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      _handleAccreditationRequestRadioValueChange('نعم'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                        value: 'نعم',
                        groupValue: _selectedAccreditationRequestValue,
                        onChanged: _handleAccreditationRequestRadioValueChange,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity:
                            const VisualDensity(horizontal: -3, vertical: 0),
                        activeColor: AppColors.darkBlue(context),
                      ),
                      Text(
                        'نعم',
                        style: AppStyles.styleBold16(context).copyWith(
                          color: AppColors.typographySubTitle(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      _handleAccreditationRequestRadioValueChange('لا'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                        value: 'لا',
                        groupValue: _selectedAccreditationRequestValue,
                        onChanged: _handleAccreditationRequestRadioValueChange,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity:
                            const VisualDensity(horizontal: -3, vertical: 0),
                        activeColor: AppColors.darkBlue(context),
                      ),
                      Text(
                        'لا',
                        style: AppStyles.styleBold16(context).copyWith(
                          color: AppColors.typographySubTitle(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
