import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/empty_widget.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../view_model/home/home_cubit.dart';
import '../widgets/mazad_details/asset_card_widget.dart';
import '../widgets/mazad_details/asset_search_widget_and_num.dart';
import '../widgets/mazad_details/auction_assets_num_and_day.dart';
import '../widgets/mazad_details/comming_mazad_timer_widget.dart';
import '../widgets/mazad_details/licenses_widget.dart';
import '../widgets/mazad_details/location_and_intro_image._widgets.dart';

class MazadDetailsScreen extends StatefulWidget {
  const MazadDetailsScreen({super.key});

  @override
  State<MazadDetailsScreen> createState() => _MazadDetailsScreenState();
}

class _MazadDetailsScreenState extends State<MazadDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white(context),
        appBar: CoustomAppBarWidget(
          title: homeCubit.auctionData?.title ?? 'تفاصيل المزاد',
          actions: [
            homeCubit.auctionData?.status == AppStrings.auctionsOnGoing
                ? AuctionDetailsOnGoingStutesWidget()
                : homeCubit.auctionData?.status == AppStrings.auctionsInProgress
                    ? AuctionDetailsInprogressStutesWidget()
                    : AuctionDetailsCompletedStutesWidget(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 8)),
              MazadDetailsIntoImage(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AuctionTitleAndLocationWidget(homeCubit: homeCubit),
                ),
              ),
              SliverToBoxAdapter(
                child: AuctionAssetsNumAndDay(
                  NumOfAssets:
                      homeCubit.auctionData!.auctionOrigins.length.toString(),
                  numOfDayes: homeCubit.auctionData!.numberOfDays.toString(),
                ),
              ),
              SliverToBoxAdapter(
                child: CurrentMazadTimerWidget(),
                //  getKTapIndex(context) == 1
                //     ? CurrentMazadTimerWidget()
                //     : getKTapIndex(context) == 2
                //         ? CommingMazadTimerWidget()
                //         : EndedMazadTimerWidget(),
              ),
              SliverToBoxAdapter(
                child: AuctionBrochureWidget(),
              ),
              // SliverToBoxAdapter(child: MazadInfoAndTitle()),

              // SliverToBoxAdapter(child: LicensesWidget()),
              SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(child: AssetSearchWidgetAndNum()),
              SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.inputBorder(context),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 24)),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return homeCubit.originList.isEmpty
                      ? SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child:
                                EmptyWidget(title: 'لا يوجد اصول بهذا الاسم'),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return AssetCardWidget(index: index);
                            },
                            childCount: homeCubit.originList.length,
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuctionDetailsInprogressStutesWidget extends StatelessWidget {
  const AuctionDetailsInprogressStutesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      alignment: Alignment.center,
      margin: EdgeInsetsDirectional.only(end: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0x19F2994A),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFF9E5C21),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'مستقبلي',
        style: AppStyles.styleMedium16(context).copyWith(
          color: const Color(0xFF9E5B20),
        ),
      ),
    );
  }
}

class AuctionDetailsCompletedStutesWidget extends StatelessWidget {
  const AuctionDetailsCompletedStutesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      alignment: Alignment.center,
      margin: EdgeInsetsDirectional.only(end: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFFFCE8E8),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFFF7B8B8),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Center(
        child: Text(
          'منتهي',
          style: AppStyles.styleMedium16(context).copyWith(
            color: const Color(0xFFE51B1B),
          ),
        ),
      ),
    );
  }
}

class AuctionDetailsOnGoingStutesWidget extends StatelessWidget {
  const AuctionDetailsOnGoingStutesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      alignment: Alignment.center,
      margin: EdgeInsetsDirectional.only(end: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: ShapeDecoration(
        color: const Color(0x0C22A06B),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFF22A06B),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.app_imagesOnGoing),
          SizedBox(
            width: 8,
          ),
          Text(
            'قائم',
            style: AppStyles.styleMedium16(context).copyWith(
              color: AppColors.color2(context),
            ),
          ),
        ],
      ),
    );
  }
}

class AuctionBrochureWidget extends StatelessWidget {
  const AuctionBrochureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          context.read<HomeCubit>().auctionBrochure(context);
        },
        child: AuctionBrochureChiledWidget(),
      ),
    );
  }
}
