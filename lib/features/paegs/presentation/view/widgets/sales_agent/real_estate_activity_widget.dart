import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class RealEstateActivityWidget extends StatefulWidget {
  const RealEstateActivityWidget({
    super.key,
  });

  @override
  State<RealEstateActivityWidget> createState() =>
      _RealEstateActivityWidgetState();
}

class _RealEstateActivityWidgetState extends State<RealEstateActivityWidget> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: true,
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
        Text(
          'مزادات عقارية',
          style: AppStyles.styleRegular16(context)
              .copyWith(color: AppColors.typographySubTitle(context)),
        ),
      ],
    );
  }
}
