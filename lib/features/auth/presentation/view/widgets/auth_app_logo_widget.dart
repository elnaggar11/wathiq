import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';

import 'package:wathiq/core/utils/images.dart';

class AuthAppLogoWidget extends StatelessWidget {
  const AuthAppLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 34,
      ),
      child: SvgPicture.asset(
        AppAssets.app_imagesHorizintalLogo,
        fit: BoxFit.contain,
      ),
    );
  }
}

class CurrancyLogoWidget extends StatelessWidget {
  const CurrancyLogoWidget({
    super.key,
    this.color,
    this.maxHeight,
    this.maxWidth,
  });
  final Color? color;
  final double? maxHeight, maxWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? 24,
        maxWidth: maxWidth ?? 24,
      ),
      child: SvgPicture.asset(
        Assets.imagesCurrencyIcon,
        fit: BoxFit.contain,
        color: color ?? AppColors.typographyHeading(context),
      ),
    );
  }
}
