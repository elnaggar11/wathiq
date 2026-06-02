import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';

Future<void> showResonBottomSheet(
  BuildContext context,
  String reson,
) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white(context),
            borderRadius: BorderRadius.only(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('السبب', // Format DateTime
                        style: AppStyles.stylBold24(context)),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: SvgPicture.asset(AppAssets.app_imagesCloseSquare),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: 0.9.sw,
                  child: Text(reson, // Format DateTime
                      style: AppStyles.styleMedium16(context).copyWith(
                        color: AppColors.typographyBody(context),
                      )),
                ),
                SizedBox(height: 24),
                // SizedBox(
                //   height: 48,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: OutlinedButton.icon(
                //           onPressed: () {
                //             context.pop();
                //           },
                //           label: Text(
                //             'رجوع',
                //             style: AppStyles.styleBold16(context).copyWith(
                //                 color: AppColors.typographySubTitle(context)),
                //           ),
                //           style: OutlinedButton.styleFrom(
                //               minimumSize: Size(double.infinity, 50),
                //               side: BorderSide(
                //                 color: AppColors.typographySubTitle(context),
                //               ),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(12),
                //               ),
                //               foregroundColor:
                //                   AppColors.typographySubTitle(context),
                //               backgroundColor: AppColors.white(context)),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      );
    },
  );
}
