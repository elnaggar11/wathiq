import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/enrollment_buttom_sheet.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mozayda_sheet/mozayda_sheet.dart';

import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

Future<void> registerAuctionSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return const RegisterAuctionSheetBodyWidget();
    },
  );
}

class RegisterAuctionSheetBodyWidget extends StatefulWidget {
  const RegisterAuctionSheetBodyWidget({
    super.key,
  });

  @override
  State<RegisterAuctionSheetBodyWidget> createState() =>
      _RegisterAuctionSheetBodyWidgetState();
}

class _RegisterAuctionSheetBodyWidgetState
    extends State<RegisterAuctionSheetBodyWidget>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getAgencies();
    _pageController = PageController();
    _tabController = TabController(vsync: this, length: 2);
    // _pageController.addListener(() {});

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 300),
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
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'التسجيل في المزاد',
                    textAlign: TextAlign.start,
                    style: AppStyles.styleMedium22(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: SvgPicture.asset(AppAssets.app_imagesCloseSquare),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<HomeCubit>().addNewBidValue();
                        context.read<HomeCubit>().type =
                            AppStrings.enrolltypeOnline;
                        context.pop();

                        if (getKTapIndex(context) == 2) {
                          enrollmentSheetBottomSheet(context);
                        } else {
                          mozaydaSheetBottomSheet(context);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 90,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF9F9F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFF22A06B) /* Color-2 */,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.app_imagesSmartphone),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'إلكتروني',
                              textAlign: TextAlign.start,
                              style: AppStyles.styleBold18(context).copyWith(
                                color: AppColors.typographyHeading(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.read<HomeCubit>().addNewBidValue();
                        context.read<HomeCubit>().type =
                            AppStrings.enrolltypeOffline;
                        context.pop();
                        if (getKTapIndex(context) == 2) {
                          enrollmentSheetBottomSheet(context);
                        } else {
                          mozaydaSheetBottomSheet(context);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 90,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF9F9F8),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFF22A06B) /* Color-2 */,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.app_imagesUserHandUp),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'حضوري',
                              textAlign: TextAlign.start,
                              style: AppStyles.styleBold18(context).copyWith(
                                color: AppColors.typographyHeading(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }
}
