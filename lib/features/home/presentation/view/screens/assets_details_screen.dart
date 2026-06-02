import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/features/home/presentation/view/screens/mazad_details_screen.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/location_and_intro_image._widgets.dart';

import 'package:wathiq/app/app.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/asset_info_card.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/assete_detailes_card_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/assets_comming_status_timer_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/assets_image_slider.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/map_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/top_bidders_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/auctions_favorite_button.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/licenses_widget.dart';

class AssetsDetailsScreen extends StatefulWidget {
  const AssetsDetailsScreen({super.key});

  @override
  State<AssetsDetailsScreen> createState() => _AssetsDetailsScreenState();
}

int KtapIndex = 1;

class _AssetsDetailsScreenState extends State<AssetsDetailsScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    HomeCubit homeCubit = context.read<HomeCubit>();
    homeCubit.auctionId = homeCubit.auctionData!.id;
    homeCubit.originId = homeCubit.auctionOrigin!.id;
    homeCubit.amount = null;

    homeCubit.getAuctionBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    HomeCubit homeCubit = context.read<HomeCubit>();
    debugPrint(homeCubit.auctionOrigin!.id.toString());
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.white(context),
        appBar: CoustomAppBarWidget(
          title: homeCubit.auctionOrigin?.title ?? 'تفاصيل الاصل',
          actions: [
            homeCubit.auctionData?.status == AppStrings.auctionsOnGoing
                ? const AuctionDetailsOnGoingStutesWidget()
                : homeCubit.auctionData?.status == AppStrings.auctionsInProgress
                    ? const AuctionDetailsInprogressStutesWidget()
                    : const AuctionDetailsCompletedStutesWidget(),
            // MazadIconWidget(
            //   image: Assets.imagesShareAndroid,
            // ),
            // KisGuest ? SizedBox.shrink() : SizedBox(width: 16),
            // KisGuest
            //     ? SizedBox.shrink()
            //     : AssetsFavoriteButton(
            //         homeCubit: homeCubit,
            //       ),
            // SizedBox(width: 12),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: AssetsImageSlider()),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    AssetsTitleWidget(homeCubit: homeCubit),
                    const SizedBox(height: 12),
                    const AssetsDescriptionWidget(),
                    const SizedBox(height: 16),
                    getKTapIndex(context) == 2
                        ? const SizedBox.shrink()
                        : const TopBiddersWidget(),
                    getKTapIndex(context) == 1
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEBF1EE),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: const AssetsDetailsCardColumWidget(
                              dateLabel: 'أعلى مزايدة',
                              date: '55,505',
                              showCurrancyLogo: true,
                              icon: AppAssets.app_imagesSquareDoublAltArrowUp,
                            ),
                          )
                        : const SizedBox.shrink(),
                    const AsseteDetailesCardWidget(),
                    const SizedBox(height: 24),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          'التفاصيل',
                          style: AppStyles.styleBold24(context).copyWith(
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeCubit.auctionOrigin!.details.length,
                      itemBuilder: (context, index) {
                        return AssetsDetailsWidget(
                          index: index,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const MapLocationWidget(),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFD7DBD7),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const RealEstateOrganizationWidget(),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssetsTitleWidget extends StatelessWidget {
  const AssetsTitleWidget({
    super.key,
    required this.homeCubit,
  });

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
        Row(
          children: [
            const AuctionDetaislIconWidget(
              image: AppAssets.app_imagesShareAndroidW,
            ),
            const SizedBox(width: 12),
            KisGuest
                ? const SizedBox.shrink()
                : AssetsFavoriteButton(
                    homeCubit: homeCubit,
                  ),
          ],
        ),
      ],
    );
  }
}
