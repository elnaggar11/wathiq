import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';

class NavToAnotherScreenRow extends StatelessWidget {
  const NavToAnotherScreenRow({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });
  final String text1, text2;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: AppStyles.styleMedium16(context)
              .copyWith(color: AppColors.typographyBody(context)),
        ),
        8.verticalSpace,
        InkWell(
          onTap: onTap,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              side: BorderSide(
                color: AppColors.primary(context),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              foregroundColor: AppColors.white(context),
              backgroundColor: AppColors.white(context),
            ),
            onPressed: onTap,
            child: Text(
              text2,
              style: AppStyles.styleBold16(context)
                  .copyWith(color: AppColors.primary(context)),
            ),
          ),
        ),
      ],
    );
  }
}
