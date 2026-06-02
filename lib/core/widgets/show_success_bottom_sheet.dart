import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';

Future<void> showSuccessBottomSheet({
  required BuildContext context,
  required String title,
  String? subTitle,
  bool? showHomeButton,
}) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white(context),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.imagesSuccessIcon),
                const SizedBox(height: 32),
                Text(title, // Format DateTime
                    textAlign: TextAlign.center,
                    style: AppStyles.stylBold24(context)),
                SizedBox(height: subTitle != null ? 16 : 0),
                subTitle != null
                    ? Text(subTitle, // Format DateTime
                        style: AppStyles.styleSemiBold16(context).copyWith(
                          color: AppColors.typographySubTitle(context),
                        ))
                    : const SizedBox.shrink(),
                const SizedBox(height: 48),
                showHomeButton == true
                    ? SizedBox(
                        height: 48,
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .navigateToWithReplacementAndClearStack(
                                    Routes.layoutScreen,
                                  );
                                },
                                child: Text(
                                  'الرئيسية', // Format DateTime
                                  style:
                                      AppStyles.styleBold16(context).copyWith(
                                    color: AppColors.white(context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    },
  );
}
