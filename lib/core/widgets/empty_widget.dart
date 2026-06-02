import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.title,
    this.subTitle,
    this.textButton,
    this.onPressed,
  });
  final String title;
  final String? textButton, subTitle;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.imagesEmpty),
        SizedBox(height: 24),
        Text(
          title,
          style: AppStyles.styleBold18(context).copyWith(
            color: AppColors.typographyHeading(context),
          ),
        ),
        SizedBox(height: subTitle != null ? 8 : 0),
        subTitle != null
            ? Text(
                subTitle!,
                style: AppStyles.styleMedium14(context).copyWith(
                  color: AppColors.typographySubTitle(context),
                ),
              )
            : SizedBox.shrink(),
        SizedBox(height: textButton != null ? 40 : 0),
        textButton != null
            ? ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  textButton!,
                  style: AppStyles.styleBold16(context).copyWith(
                    color: AppColors.white(context),
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
