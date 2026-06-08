import 'package:animate_do/animate_do.dart';
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
    this.imagePath,
  });
  final String title;
  final String? textButton, subTitle, imagePath;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: SvgPicture.asset(
            imagePath ?? 'assets/app_images/empty_wallet.svg',
            //  ?? Assets.imagesEmpty
          ),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 200),
          child: Text(
            title,
            style: AppStyles.styleBold18(context).copyWith(
              color: AppColors.typographyHeading(context),
            ),
          ),
        ),
        SizedBox(height: subTitle != null ? 8 : 0),
        subTitle != null
            ? FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 400),
                child: Text(
                  subTitle!,
                  style: AppStyles.styleMedium14(context).copyWith(
                    color: AppColors.typographySubTitle(context),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        SizedBox(height: textButton != null ? 40 : 0),
        textButton != null
            ? FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 600),
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    textButton!,
                    style: AppStyles.styleBold16(context).copyWith(
                      color: AppColors.white(context),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
