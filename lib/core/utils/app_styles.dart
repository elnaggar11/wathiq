import 'package:flutter/material.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/size_config.dart';

abstract class AppStyles {
  static TextStyle styleBold18(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.inputLabel(context),
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold12(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.typographyHeading(context),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle stylBold10(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: const Color(0xFF064060),
      fontSize: getResponsiveFontSize(context, fontSize: 10),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle stylBold12(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.secondColor(context),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle stylBold24(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.typographyHeading(context),
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold20(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.error(context),
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold22(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.error(context),
      fontSize: getResponsiveFontSize(context, fontSize: 22),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold16(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.typographyHeading(context),
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold14(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.typographyHeading(context),
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold24(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.typographyHeading(context),
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold28(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.primary(context),
      fontSize: getResponsiveFontSize(context, fontSize: 28),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBold32(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.typographyHeading(context),
      fontSize: getResponsiveFontSize(context, fontSize: 32),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleMedium16(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.typographyBody(context),
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleMedium14(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.typographyBody(context),
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleMedium12(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.typographyHeading(context),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleMedium18(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: const Color(0xFFFFFFFF),
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleMedium20(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: const Color(0xFFFFFFFF),
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleMedium22(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: const Color(0xFFFFFFFF),
      fontSize: getResponsiveFontSize(context, fontSize: 22),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleSemiBold16(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.iconsPrimary(context),
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleSemiBold12(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.typographyBody(context),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleSemiBold18(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.inputLabel(context),
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleSemiBold20(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.primary(context),
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleSemiBold14(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.typographyHeading(context),
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleRegular14(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.inputsPlaceholder(context),
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleRegular16(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.inputsPlaceholder(context),
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleRegular12(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.inputsPlaceholder(context),
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleSemiBold24(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: AppColors.inputLabel(context),
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle styleRegular24(BuildContext context) {
    return TextStyle(
      height: 1.33,
      color: const Color(0xFFAAAAAA),
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontFamily: 'Lama Sans',
      fontWeight: FontWeight.w400,
    );
  }
}

// sacleFactor
// responsive font size
// (min , max) fontsize
double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  // var dispatcher = PlatformDispatcher.instance;
  // var physicalWidth = dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  // double width = physicalWidth / devicePixelRatio;

  double width = MediaQuery.sizeOf(context).width;
  print('width $width');
  if (width < SizeConfig.tablet) {
    return width / 440;
  } else if (width < SizeConfig.desktop) {
    return width / 1000;
  } else {
    return width / 1920;
  }
}
