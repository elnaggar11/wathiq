import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';

class ProfileCartWidget extends StatelessWidget {
  const ProfileCartWidget({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
  });
  final String text, image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: AppStyles.styleMedium16(context).copyWith(
                height: 2,
                color: AppColors.typographyHeading(context),
              ),
            ),
            Spacer(),
            SvgPicture.asset(
              AppAssets.app_imagesProfileArrow,
            ),
          ],
        ),
      ),
    );
  }
}
