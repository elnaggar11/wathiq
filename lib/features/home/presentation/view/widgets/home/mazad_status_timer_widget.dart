import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/timer_home_widget.dart';

import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/features/home/data/models/auctions_model/auctions_model.dart';

class MazadStatusTimerWidget extends StatelessWidget {
  const MazadStatusTimerWidget({
    super.key,
    required this.auctionData,
  });
  final AuctionData auctionData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: getKTapIndex(context, auctionData.status) == 1
            ? const Color(0xFFFFFFFF)
            : getKTapIndex(context, auctionData.status) == 2
                ? const Color(0xFFF4FAF8)
                : const Color(0xFFFEF6F5),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFE0E0E0),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Column(
        children: [
          getKTapIndex(context, auctionData.status) == 3
              ? const CompletedAuctionStutesWidget()
              : TimerContainerWidget(auctionData: auctionData),
          const SizedBox(height: 16),
          const Divider(
            color: Color(0xFFE0E0E0),
            height: 0,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 36),
              RowAssetsNumberCardWidget(
                text: 'الاصول ${auctionData.auctionOrigins.length}',
                image: AppAssets.app_imagesBriefcase,
              ),
              const Spacer(),
              RowAssetsNumberCardWidget(
                text: auctionData.numberOfDays.toString() + ' يوم',
                image: AppAssets.app_imagesClock,
              ),
              const SizedBox(width: 36),
            ],
          ),
        ],
      ),
    );
  }
}

class CompletedAuctionStutesWidget extends StatelessWidget {
  const CompletedAuctionStutesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFFFCE8E8),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: AppColors.error(context),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        'مزاد منتهي',
        style: AppStyles.styleBold16(context).copyWith(
          color: AppColors.error(context),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class RowAssetsNumberCardWidget extends StatelessWidget {
  const RowAssetsNumberCardWidget({
    super.key,
    required this.text,
    required this.image,
  });
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(image),
        const SizedBox(width: 14),
        Text(
          text,
          style: AppStyles.styleBold16(context).copyWith(
            color: AppColors.typographyHeading(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class TimerContainerWidget extends StatelessWidget {
  const TimerContainerWidget({
    super.key,
    required this.auctionData,
    this.textStyle,
  });

  final AuctionData auctionData;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getKTapIndex(context, auctionData.status) == 1
                      ? 'ينتهي بعد'
                      : 'قادم بعد',
                  style: textStyle ??
                      AppStyles.styleBold16(context).copyWith(
                        color: AppColors.primaryHover(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            TimerHomeWidget(
              auctionData: auctionData,
            ),
          ],
        ),
      ),
    );
  }
}

class MazadDateAndTimeWidget extends StatelessWidget {
  const MazadDateAndTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.white(context).withOpacity(0.7),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.imagesClockCircle,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'يبدأالأحد 09:00 صباحاً',
                style: AppStyles.styleBold14(context),
              ),
              const Spacer(),
              Text(
                '2024/12/08',
                style: AppStyles.styleBold14(context).copyWith(
                  color: AppColors.typographyHeading(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MazadIconWidget extends StatelessWidget {
  const MazadIconWidget({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      padding: const EdgeInsets.all(9),
      decoration: ShapeDecoration(
        color: const Color(0x5E0C0C0C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: FittedBox(
        child: SvgPicture.asset(
          image,
        ),
      ),
    );
  }
}
