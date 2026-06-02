import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../view_model/home/home_cubit.dart';

class MazadEnrollAndShowMoreWidget extends StatelessWidget {
  const MazadEnrollAndShowMoreWidget({
    super.key,
    this.textButton1,
    this.onPressedButton1,
    this.icon,
    required this.index,
    this.buttonColor,
    this.flexButton,
    this.flexDetailsButton,
  });
  final String? textButton1;
  final Function()? onPressedButton1;
  final Widget? icon;
  final Color? buttonColor;
  final int index;
  final int? flexButton, flexDetailsButton;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Expanded(
            flex: flexDetailsButton ?? 2,
            child: OutlinedButton.icon(
              onPressed: () {
                homeCubit.auctionOrigin = homeCubit.originList[index];
                KoriginId = homeCubit.originList[index].id;

                context.navigateTo(Routes.assetsDetailsScreen);
              },
              label: Text(
                'التفاصيل',
                style: AppStyles.styleMedium16(context)
                    .copyWith(color: AppColors.iconsSecondary(context)),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 1,
                  color: AppColors.iconsSecondary(
                      context), // <-- Border color here
                ),
                padding: EdgeInsets.all(0),
                minimumSize: Size(double.infinity, double.infinity),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                    width: 2,
                    color: AppColors.iconsSecondary(context),
                  ),
                ),
                foregroundColor: AppColors.iconsSecondary(context),
              ),
            ),
          ),
          textButton1 != null ? SizedBox(width: 12) : SizedBox.shrink(),
          textButton1 != null
              ? Expanded(
                  flex: flexButton ?? 5,
                  child: OutlinedButton.icon(
                    onPressed: onPressedButton1,
                    label: Text(
                      textButton1 ?? '',
                      style: AppStyles.styleMedium16(context).copyWith(
                        color: AppColors.white(context),
                      ),
                    ),
                    icon: icon,
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, double.infinity),
                      side: BorderSide(
                        width: 1,
                        color: (homeCubit.auctionData!.auctionOrigins[index]
                                    .isEnrolled! &&
                                getKTapIndex(context) == 2)
                            ? AppColors.error(context)
                            : buttonColor ?? AppColors.color2(context),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      backgroundColor: (homeCubit.auctionData!
                                  .auctionOrigins[index].isEnrolled! &&
                              getKTapIndex(context) == 2)
                          ? AppColors.error(context)
                          : buttonColor ?? AppColors.color2(context),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
