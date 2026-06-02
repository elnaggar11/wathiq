import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import '../utils/images.dart';

class GuestWidget extends StatelessWidget {
  const GuestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.app_imagesHorizintalLogo,
              height: 60,
            ),
            SizedBox(height: 60),
            Text(
              'يرجى تسجيل الدخول للإستمرار',
              style: AppStyles.styleMedium20(context).copyWith(
                color: AppColors.typographyHeading(context),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.navigateTo(Routes.login);
              },
              child: Text(
                'تسجيل الدخول',
                style: AppStyles.styleMedium18(context).copyWith(
                  color: AppColors.white(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
