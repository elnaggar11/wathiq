import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/top_bidders_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mozayda_sheet/mozayda_board_tab_bar_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mozayda_sheet/mozayda_board_widget.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';
import '../../../../../profile/presentation/view_model/profile/profile_cubit.dart';
import '../../../view_model/home/home_cubit.dart';

Future<void> mozaydaSheetBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    isDismissible: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.0,
        maxChildSize: 1.0,
        expand: true,
        builder: (context, scrollController) {
          return mozaydaSheetBottomSheetBodyWidget(scrollController);
        },
      );
    },
  );
}

class mozaydaSheetBottomSheetBodyWidget extends StatefulWidget {
  final ScrollController scrollController;

  const mozaydaSheetBottomSheetBodyWidget(this.scrollController, {super.key});

  @override
  State<mozaydaSheetBottomSheetBodyWidget> createState() =>
      _mozaydaSheetBottomSheetBodyWidgetState();
}

class _mozaydaSheetBottomSheetBodyWidgetState
    extends State<mozaydaSheetBottomSheetBodyWidget>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getAgencies();
    context.read<HomeCubit>().getWallet();

    _pageController = PageController();
    _tabController = TabController(vsync: this, length: 2);
    // _pageController.addListener(() {});

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );

        // Update the ProfileCubit based on the selected tab
        // if (_tabController.index == 0) {
        //   context.read<ProfileCubit>().status = AppStrings.approved;
        // } else if (_tabController.index == 1) {
        //   context.read<ProfileCubit>().status = AppStrings.pending;
        // } else {
        //   context.read<ProfileCubit>().status = AppStrings.rejected;
        // }

        // context.read<ProfileCubit>().getAgencies();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                controller:
                    widget.scrollController, // Enable swipe up to full screen

                child: Column(
                  children: [
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'لوحة المزايدة',
                          textAlign: TextAlign.start,
                          style: AppStyles.styleMedium22(context).copyWith(
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: SvgPicture.asset(
                                  AppAssets.app_imagesCloseSquare)),
                        ),
                      ],
                    ),
                    MozaydaBoardTabBarWidget(
                      tabController: _tabController,
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 700,
                      width: double.infinity,
                      child: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          _tabController.animateTo(index);
                        },
                        children: [
                          MozaydaBoardWidget(),
                          SingleChildScrollView(
                            child: Column(
                              children: [TopBiddersWidget()],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TopMozaydaWidget extends StatelessWidget {
  const TopMozaydaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: ShapeDecoration(
        color: const Color(0x1922A06B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.app_imagesSquareDoublAltArrowUp),
          SizedBox(width: 8),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Row(
                children: [
                  Text(
                    'اعلي مزايدة' + ' ',
                    textAlign: TextAlign.start,
                    style: AppStyles.styleMedium16(context).copyWith(
                      color: AppColors.typographyBody(context),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        homeCubit.boardAuctionData.isEmpty
                            ? 'لا يوجد مزايدين بعد'
                            : formatNumber(
                                homeCubit.boardAuctionData.first.bidAmount),
                        textAlign: TextAlign.start,
                        style: AppStyles.styleBold20(context).copyWith(
                          color: AppColors.typographyHeading(context),
                        ),
                      ),
                      SizedBox(
                          width: homeCubit.boardAuctionData.isEmpty ? 0 : 2),
                      homeCubit.boardAuctionData.isEmpty
                          ? SizedBox.shrink()
                          : CurrancyLogoWidget(
                              color: AppColors.typographyHeading(context),
                            ),
                    ],
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
