import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/assets_comming_status_timer_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/logout_auction_sheet.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/register_auction_sheet.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mozayda_sheet/mozayda_sheet.dart';

import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';

class CurrentAndCommingActionForAssetsWidget extends StatelessWidget {
  const CurrentAndCommingActionForAssetsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            getKTapIndex(context) == 1
                ? const AssetsCommingStatusTimerWidget()
                : const SizedBox.shrink(),
            SizedBox(height: getKTapIndex(context) == 2 ? 16 : 0),
            (homeCubit.auctionOrigin!.isEnrolled! && getKTapIndex(context) != 2)
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (homeCubit.auctionOrigin!.isEnrolled!) {
                            return;
                          } else {
                            registerAuctionSheet(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: homeCubit.auctionOrigin!.isEnrolled!
                              ? AppColors.color2(context)
                              : AppColors.iconsSecondary(context),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            homeCubit.auctionOrigin!.isEnrolled!
                                ? SvgPicture.asset(
                                    AppAssets.app_imagesEnrolledMazadtrue)
                                : const SizedBox.shrink(),
                            SizedBox(
                                width: homeCubit.auctionOrigin!.isEnrolled!
                                    ? 12
                                    : 0),
                            Text(
                              homeCubit.auctionOrigin!.isEnrolled!
                                  ? 'أنت مسجل في المزاد'
                                  : 'سجل في المزاد',
                              style: AppStyles.styleMedium18(context).copyWith(
                                color: homeCubit.auctionOrigin!.isEnrolled!
                                    ? AppColors.white(context)
                                    : AppColors.white(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      homeCubit.auctionOrigin!.isEnrolled!
                          ? const SizedBox(height: 16)
                          : const SizedBox.shrink(),
                      homeCubit.auctionOrigin!.isEnrolled!
                          ? ElevatedButton(
                              onPressed: () {
                                LogOutFromAuctionSheetBottomSheet(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.danger(context),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      AppAssets.app_imagesLogoutFromAuction),
                                  const SizedBox(width: 12),
                                  Text(
                                    'الخروج من المزاد',
                                    style: AppStyles.styleMedium18(context)
                                        .copyWith(
                                      color: AppColors.white(context),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
            SizedBox(height: getKTapIndex(context) == 1 ? 16 : 0),
            getKTapIndex(context) == 1
                ? OutlinedButton.icon(
                    onPressed: () {
                      context.read<HomeCubit>().addNewBidValue();

                      mozaydaSheetBottomSheet(context);
                    },
                    label: Text(
                      'لوحة المزايدة',
                      style: AppStyles.styleBold16(context)
                          .copyWith(color: AppColors.white(context)),
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.app_imagesDocument,
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                      side: const BorderSide(width: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      backgroundColor: AppColors.color2(context),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
