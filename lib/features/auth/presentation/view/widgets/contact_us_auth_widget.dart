import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';

class ContactUsAuthWidget extends StatelessWidget {
  const ContactUsAuthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateTo(Routes.contactUsScreen);
      },
      child: Container(
        color: AppColors.white(context),
        height: 30,
        width: 1.sw,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'هل تحتاج إلى المساعدة ؟',
              style: AppStyles.styleMedium16(context).copyWith(
                color: AppColors.typographyBody(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
