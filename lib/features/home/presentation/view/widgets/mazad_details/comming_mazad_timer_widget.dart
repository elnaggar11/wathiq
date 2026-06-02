import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/functions/get_auction_status_and_type.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/asset_card_widget.dart';

import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_status_timer_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/timer_home_widget.dart';

class EndedMazadTimerWidget extends StatelessWidget {
  const EndedMazadTimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: SvgPicture.asset(
        Assets.imagesEndMazadDetailsicon,
        fit: BoxFit.fill,
      ),
    );
  }
}

class CommingMazadTimerWidget extends StatelessWidget {
  const CommingMazadTimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return Container(
      width: 350,
      height: 83,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: ShapeDecoration(
        color: AppColors.white(context),
        shape: const RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFEBEEF3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DateTimeColumWidget(
            dateLabel: 'تاريخ بدأ المزاد',
            date:
                formatDateFunction(homeCubit.auctionData!.startDate.toString()),
            showCurrancyLogo: false,
          ),
          Container(
            height: 54,
            width: 1.2,
            color: AppColors.separatingBorder(context),
          ),
          DateTimeColumWidget(
            dateLabel: 'وقت بدأ المزاد',
            date:
                formatTimeFunction(homeCubit.auctionData!.startDate.toString()),
            showCurrancyLogo: false,
          ),
        ],
      ),
    );
  }
}

class CurrentMazadTimerWidget extends StatelessWidget {
  const CurrentMazadTimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: homeCubit.auctionData!.status == AppStrings.auctionsOnGoing
                  ? const Color(0xFFEEF5F1)
                  : homeCubit.auctionData!.status ==
                          AppStrings.auctionsInProgress
                      ? const Color(0xFFF2F2F2)
                      : const Color(0xFFF8F0EE),
            ),
            child: getKTapIndex(context, homeCubit.auctionData!.status) == 3
                ? const CompletedAuctionStutesWidget()
                : FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getAuctionTimerText(
                                homeCubit.auctionData!.status,
                              ),
                              style: AppStyles.styleBold16(context).copyWith(
                                color: AppColors.typographyHeading(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        TimerHomeWidget(auctionData: homeCubit.auctionData!)
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
