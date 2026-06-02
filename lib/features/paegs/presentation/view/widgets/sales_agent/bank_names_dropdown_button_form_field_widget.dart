import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';

import 'package:wathiq/features/wallet/presentation/view_model/wallet/wallet_cubit.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';

class BankNamesDropdownButtonFormFieldWidget extends StatefulWidget {
  const BankNamesDropdownButtonFormFieldWidget({
    super.key,
    this.filled,
  });
  final bool? filled;

  @override
  State<BankNamesDropdownButtonFormFieldWidget> createState() =>
      _BankNamesDropdownButtonFormFieldWidgetState();
}

class _BankNamesDropdownButtonFormFieldWidgetState
    extends State<BankNamesDropdownButtonFormFieldWidget> {
  String? selectedValue;
  final List<String> options = [
    'البنك الأهلي السعودي',
    'مصرف الراجحي',
    'بنك الرياض',
    'البنك السعودي الفرنسي',
    'البنك العربي الوطني',
    'بنك البلاد',
    'بنك الجزيرة',
    'البنك السعودي للاستثمار',
    'البنك السعودي الأول (ساب)',
    'مصرف الإنماء',
    'بنك الخليج الدولي - السعودية',
    'بنك إس تي سي (STC Bank)',
    'البنك السعودي الرقمي',
    'بنك دال ثلاث مئة وستون (D360 Bank)'
  ];

  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    WalletCubit walletCubit = context.read<WalletCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          isExpanded: true,
          initialValue: selectedValue,
          menuMaxHeight: 600,
          dropdownColor: AppColors.white(context),
          style: AppStyles.styleBold16(context).copyWith(),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          items: options
              .map((option) => DropdownMenuItem<String>(
                    value: option,
                    onTap: () {
                      pagesCubit.bankNameController.text = option;
                      walletCubit.bankNameController.text = option;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Flexible(
                        // or Expanded
                        child: Text(
                          option,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.styleBold16(context).copyWith(
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
          validator: (value) {
            if (pagesCubit.bankNameController.text.isEmpty) {
              return 'يرجي اختيار اسم البنك';
            }
            return null;
          },
          decoration: InputDecoration(
            label: const Text(
              'إسم البنك',
            ),
            labelStyle: AppStyles.styleRegular16(context).copyWith(
              color: AppColors.typographyBody(context),
            ),
            floatingLabelStyle: AppStyles.styleRegular14(context).copyWith(
              color: AppColors.primary(context),
            ),

            filled: widget.filled ?? true,
            fillColor: AppColors.primarySurface(
                context), // Background color of the dropdown

            hintStyle: AppStyles.styleRegular16(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16), // Custom shape
              borderSide: BorderSide(
                color: AppColors.inputBorder(context), // Default border color
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color:
                    AppColors.inputBorder(context), // Border color when enabled
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color:
                    AppColors.inputBorder(context), // Border color when focused
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red, // Border color when there's an error
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red, // Border color when focused with an error
                width: 1.5,
              ),
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
                    pagesCubit.category = null;

                    pagesCubit.bankNameController.clear();
                    walletCubit.bankNameController.clear();
                  },
                  child: SizedBox(
                    child: SvgPicture.asset(
                      Assets.imagesCloseIcon,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
