import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/app/app.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/core/widgets/guest_widget.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:wathiq/features/home/presentation/view/screens/home_screen.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/auctions_favorite_button.dart';
import 'package:wathiq/features/home/presentation/view/widgets/my_mazadat/my_mazadat_tab_bar_widget.dart';

class MyMazadatScreen extends StatefulWidget {
  const MyMazadatScreen({super.key});

  @override
  State<MyMazadatScreen> createState() => _MyMazadatScreenState();
}

class _MyMazadatScreenState extends State<MyMazadatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    HomeCubit homeCubit = context.read<HomeCubit>();
    homeCubit.winner = false;
    homeCubit.loss = false;
    homeCubit.getUserAuctions();

    _tabController = TabController(vsync: this, length: 3);
    _pageController = PageController();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_pageController.page?.round() != _tabController.index) {
          _pageController.jumpToPage(_tabController.index);
        }

        if (_tabController.index == 0) {
          homeCubit.winner = false;
          homeCubit.loss = false;
        } else if (_tabController.index == 1) {
          homeCubit.winner = true;
          homeCubit.loss = false;
        } else {
          homeCubit.winner = false;
          homeCubit.loss = true;
        }

        homeCubit.getUserAuctions();
      }
    });

    // Set system UI styles
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  String? selectedValue;

  // Dropdown menu items
  @override
  Widget build(BuildContext context) {
    KisFromFav = false;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white(context),
          centerTitle: true,
          title: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 34.h, maxWidth: 122.w),
            child: SvgPicture.asset(
              AppAssets.app_imagesParadse,
              height: 60,
            ),
          ),
          toolbarHeight: 64.h,
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child: InkWell(
              onTap: () {
                if (homeScaffoldKey.currentState?.isDrawerOpen ?? false) {
                  homeScaffoldKey.currentState?.closeDrawer();
                } else {
                  homeScaffoldKey.currentState?.openDrawer();
                }
              },
              child: FittedBox(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFE1E1E2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: SvgPicture.asset(
                    AppAssets.app_imagesMenu,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          leadingWidth: 60,
          actions: KisGuest
              ? [
                  const SizedBox(width: 16),
                ]
              : [
                  InkWell(
                    onTap: () {
                      context.navigateTo(Routes.notificationScreen);
                    },
                    child: BlocBuilder<PagesCubit, PagesState>(
                      builder: (context, state) {
                        final count =
                            context.watch<PagesCubit>().state.notificationCount;
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFAFAFA),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0xFFE1E1E2),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: FittedBox(
                                child: SvgPicture.asset(
                                  Assets.imagesBell,
                                  fit: BoxFit.contain,
                                  color: AppColors.typographyHeading(context),
                                ),
                              ),
                            ),
                            if (count != 0 &&
                                count != null &&
                                KisGuest == false)
                              PositionedDirectional(
                                top: 0,
                                start: 0,
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: -20.0, end: 0.0),
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.bounceOut,
                                  builder: (context, value, child) {
                                    return Transform.translate(
                                      offset: Offset(0, value),
                                      child: child,
                                    );
                                  },
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.error(context),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: Center(
                                        child: Text(
                                          '$count',
                                          style: AppStyles.stylBold12(context)
                                              .copyWith(
                                            color: AppColors.white(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
        ),
        body: KisGuest == true
            ? const GuestWidget()
            : Column(
                children: [
                  MyMazadatTabBarWidget(
                    tabController: _tabController,
                    tapsName: const [
                      'إشتراكاتي',
                      'مزاداتي الرابحة',
                      'مزاداتي الخاسرة',
                    ],
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    // Ensure TabBarView has space to expand
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          if (_tabController.index != index) {
                            _tabController.animateTo(index);
                          }
                        },
                        children: const [
                          MazadatyTabBarViewBodyWidget(),
                          MazadatyTabBarViewBodyWidget(),
                          MazadatyTabBarViewBodyWidget(),
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
