import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/functions/get_auction_status_and_type.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/images.dart';

import 'package:wathiq/app/app.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/auctions_favorite_button.dart';

class MazadDetailsIntoImage extends StatelessWidget {
  const MazadDetailsIntoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            height: 226,
            width: 1.sw,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(homeCubit
                        .auctionData?.cover ??
                    'https://www.urtrips.com/wp-content/uploads/2022/12/tv-tower.jpg'),
              ),
            ),
          ),
          Container(
            height: 226,
            width: 1.sw,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.05),
                  Colors.black.withOpacity(0.05),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // MazadLocationWidget(),
                        // Spacer(),
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: AppColors.color2(context),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text(
                            getAuctionTypeText(
                              homeCubit.auctionData?.type?.toLowerCase(),
                            ),
                            style: AppStyles.styleBold16(context).copyWith(
                              color: AppColors.typographyHeadingWhite(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AuctionDetaislIconWidget extends StatelessWidget {
  const AuctionDetaislIconWidget({
    super.key,
    required this.image,
    this.color,
  });
  final String image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(9),
      decoration: ShapeDecoration(
        color: const Color(0xFFF5F6F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: FittedBox(
        child: SvgPicture.asset(
          image,
          color: color ?? AppColors.iconsGrey(context),
        ),
      ),
    );
  }
}

class AuctionTitleAndLocationWidget extends StatelessWidget {
  const AuctionTitleAndLocationWidget({
    super.key,
    required this.homeCubit,
  });

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 210,
                  child: Text(
                    homeCubit.auctionData?.title ?? 'المزاد',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: AppStyles.styleBold20(context).copyWith(
                      color: AppColors.typographyHeading(context),
                      height: 1.24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppAssets.app_imagesLocationDot,
                  color: AppColors.typographyHeading(context),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 210,
                  child: Text(
                    homeCubit.auctionData?.location.title ?? 'السعودية',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: AppStyles.styleMedium14(context).copyWith(
                      color: AppColors.typographyBodyWhite(context),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
        const Spacer(),
        const AuctionDetaislIconWidget(
          image: AppAssets.app_imagesShareAndroidW,
        ),
        const SizedBox(width: 12),
        KisGuest
            ? const SizedBox.shrink()
            : AuctionsFavoriteButton(
                auctionData: homeCubit.auctionData!,
                homeCubit: homeCubit,
                isFromDetails: true,
              ),
      ],
    );
  }
}

class MazadLocationWidget extends StatelessWidget {
  const MazadLocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x26111311),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.app_imagesMapPoinWave,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'خريطة المزادات',
            style: AppStyles.styleMedium14(context).copyWith(
              color: AppColors.typographyHeading(context),
            ),
          ),
        ],
      ),
    );
  }
}
