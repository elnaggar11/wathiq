import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/app_styles.dart';

class MazadtypeDropdownButtonFormFieldWidget extends StatefulWidget {
  const MazadtypeDropdownButtonFormFieldWidget({
    super.key,
  });

  @override
  State<MazadtypeDropdownButtonFormFieldWidget> createState() =>
      _MazadtypeDropdownButtonFormFieldWidgetState();
}

class _MazadtypeDropdownButtonFormFieldWidgetState
    extends State<MazadtypeDropdownButtonFormFieldWidget> {
  String? selectedValue;
  final List<String> options = [
    'الكترونى',
    'هجين',
    'حضوري',
  ];

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    selectedValue = homeCubit.filterAuctiontypeAr;
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
      items: options
          .map((type) => DropdownMenuItem<String>(
                value: type,
                onTap: () {
                  if (type == 'الكترونى') {
                    homeCubit.filterAuctiontype = AppStrings.online;
                    homeCubit.filterAuctiontypeAr = 'الكترونى';
                  }
                  if (type == 'هجين') {
                    homeCubit.filterAuctiontype = AppStrings.hybrid;
                    homeCubit.filterAuctiontypeAr = 'هجين';
                  }
                  if (type == 'حضوري') {
                    homeCubit.filterAuctiontype = AppStrings.offline;
                    homeCubit.filterAuctiontypeAr = 'حضوري';
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    type,
                    style: AppStyles.styleBold16(context)
                        .copyWith(color: AppColors.typographyHeading(context)),
                  ),
                ),
              ))
          .toList(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        filled: true,
        fillColor: AppColors.white(context), // Background color of the dropdown
        labelText: 'نوع المزاد',
        labelStyle: AppStyles.styleRegular16(context).copyWith(
          color: AppColors.typographyBody(context),
        ),
        hintStyle: AppStyles.styleBold16(context).copyWith(),
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
            color: AppColors.inputBorder(context), // Border color when enabled
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.inputBorder(context), // Border color when focused
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
          ? Icon(
              Icons.arrow_drop_down,
              color: AppColors.grey500(context),
            )
          : InkWell(
              onTap: () {
                setState(() {
                  selectedValue = null;
                  homeCubit.filterAuctiontypeAr = null;
                  homeCubit.filterAuctiontype = null;
                });
              },
              child: SizedBox(
                child: SvgPicture.asset(
                  Assets.imagesCloseIcon,
                ),
              ),
            ),
    );
  }
}
