import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';

class AuctionAssetsNumAndDay extends StatelessWidget {
  const AuctionAssetsNumAndDay(
      {super.key,
      required this.numOfDayes,
      required this.NumOfAssets,
      this.padding});
  final String numOfDayes, NumOfAssets;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: padding ?? 16),
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F8),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.app_imagesBuildin),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الاصول:',
                      style: AppStyles.styleMedium14(context).copyWith(
                        color: AppColors.typographyBodyWhite(context),
                      ),
                    ),
                    Text(
                      NumOfAssets,
                      style: AppStyles.styleBold24(context).copyWith(
                        color: AppColors.typographyHeading(context),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.app_imagesClockAuction),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مدة المزاد:',
                      style: AppStyles.styleMedium14(context).copyWith(
                        color: AppColors.typographyBodyWhite(context),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          numOfDayes,
                          style: AppStyles.styleBold24(context).copyWith(
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                        Text(
                          '  يوم',
                          style: AppStyles.styleMedium14(context).copyWith(
                            color: AppColors.typographyBodyWhite(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
