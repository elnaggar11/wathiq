import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';

import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';

class GoToLocationButtonWidget extends StatelessWidget {
  const GoToLocationButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      label: Text(
        'الذهاب للموقع',
        style: AppStyles.styleBold16(context)
            .copyWith(color: AppColors.primary(context)),
      ),
      icon: SvgPicture.asset(
        Assets.imagesPointOnMap,
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        side: BorderSide(
          width: 1,
          color: AppColors.primary(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        foregroundColor: AppColors.primary(context),
      ),
    );
  }
}
