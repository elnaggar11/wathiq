import 'package:flutter/material.dart';

class AppColors {
  // static HexColor background = HexColor('#1C1C23');

  static Color amr(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.blue
        : Colors.yellow;
  }

  // Primary Colors
  static Color primary(BuildContext context) => const Color(0xFF1C4F92);
  static Color primaryHover(BuildContext context) => const Color(0xFF1B5F5A);
  static Color notificationCard(BuildContext context) =>
      const Color(0x0D39360D);
  static Color primaryOP5(BuildContext context) => const Color(0x0D135C58);
  static Color secondColor(BuildContext context) => const Color(0xff2D9C95);
  static Color secondActionColor(BuildContext context) =>
      const Color(0xff0C3F82);
  static Color warrningColor(BuildContext context) => const Color(0xffBD7611);
  static Color thirdColor(BuildContext context) => const Color(0xFFBC2A46);
  static Color mainColor(BuildContext context) => const Color(0xFF22A06B);
  static Color color2(BuildContext context) => const Color(0xFF22A06B);

  // Typography
  static Color typographyHeading(BuildContext context) =>
      const Color(0xFF1A1A1A);
  static Color typographyHeadingWhite(BuildContext context) =>
      const Color(0xFFFAFAFA);
  static Color typographySubTitle(BuildContext context) =>
      const Color(0xFF6F6F6F);
  static Color typographyBody(BuildContext context) => const Color(0xFF2E353F);
  static Color typographyBodyWhite(BuildContext context) =>
      const Color(0xFF7A7B7A);
  static Color typographyWhite(BuildContext context) => const Color(0xFFB8B8B8);

  // Icons
  static Color iconsThAndTCaptions(BuildContext context) =>
      const Color(0xFF6B778C);
  static Color decremntButton(BuildContext context) => const Color(0xFFCCCCCC);
  static Color iconsPrimary(BuildContext context) => const Color(0xFF292927);
  static Color iconsSecondary(BuildContext context) => const Color(0xFF18365F);
  static Color iconsGrey(BuildContext context) => const Color(0xFF2E353F);
  static Color grey500(BuildContext context) => const Color(0xFF727A90);
  static Color iconsTertiary(BuildContext context) => const Color(0xFF6B778C);

  // Inputs
  static Color inputLabel(BuildContext context) => const Color(0xFF24262D);
  static Color borderPrimary(BuildContext context) => const Color(0xFFECECED);
  static Color inputBorder(BuildContext context) => const Color(0xFFE9E9E9);
  static Color strockSheen(BuildContext context) => const Color(0xFFF7F7F7);
  static Color separatingBorder1(BuildContext context) =>
      const Color(0xFFD6D9E1);
  static Color inputsPlaceholder(BuildContext context) =>
      const Color(0xFFBBBBBB);
  static Color separatingBorder(BuildContext context) =>
      const Color(0xFFE9EBEC);
  static Color desert100(BuildContext context) => const Color(0xFFF4EBE1);

  // Background
  static Color backgroundPrimary(BuildContext context) =>
      const Color(0xFFFAFAFA);
  static Color backgroundTertiary(BuildContext context) =>
      const Color(0xFFE1E1E2);
  static Color backgroundGrey(BuildContext context) => const Color(0xFFF5F5F5);
  static Color appBarBackground(BuildContext context) =>
      const Color(0xFF023936);
  static Color lightGreen(BuildContext context) => const Color(0xFFE8F7F5);
  static Color primarySurface(BuildContext context) => const Color(0xFFFAFAFA);

  // Buttons
  static Color disabled(BuildContext context) => const Color(0xFFE1E1E2);
  static Color buttonsPrimary(BuildContext context) => const Color(0xFF135C58);

  // Dialog
  static Color success(BuildContext context) => const Color(0xFF22A06B);
  static Color success05(BuildContext context) => const Color(0x0D1D6E4F);
  static Color error(BuildContext context) => const Color(0xFFEB5757);
  static Color danger(BuildContext context) => const Color(0xFFC21818);

  // Basic Colors
  static Color white(BuildContext context) => const Color(0xFFffffff);
  static Color shadow(BuildContext context) => const Color(0xFF00000A);
  static Color black(BuildContext context) => const Color(0xFF000000);
  static Color darkBlue(BuildContext context) => const Color(0xFF102E56);
}
