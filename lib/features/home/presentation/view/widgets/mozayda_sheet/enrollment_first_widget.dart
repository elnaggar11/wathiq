import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

class enrollmentFirstWidget extends StatelessWidget {
  const enrollmentFirstWidget({
    super.key,
    this.padding,
  });
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding ?? 0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Colors.white.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: ShapeDecoration(
              color: const Color(0x0C0C3F82),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: const Color(0x190C3F82),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  ),
                  child: SvgPicture.asset(
                    AppAssets.app_imagesPerson,
                    color: AppColors.primary(context),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'أنت غير مسجل بالمنصة.. يرجى تسجيل الدخول أولا',
                  textAlign: TextAlign.start,
                  style: AppStyles.styleMedium14(context).copyWith(
                    color: AppColors.typographyBodyWhite(context),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.navigateTo(Routes.login);
            },
            child: Text(
              'تسجيل الدخول',
              textAlign: TextAlign.start,
              style: AppStyles.styleMedium18(context).copyWith(
                color: AppColors.white(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
