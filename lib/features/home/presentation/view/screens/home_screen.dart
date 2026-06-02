import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/features/home/presentation/view/screens/assets_details_screen.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/home_appbar_widget.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/auctions_favorite_button.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/home_body_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void toggleDrawer() {
  if (homeScaffoldKey.currentState?.isDrawerOpen ?? false) {
    homeScaffoldKey.currentState?.closeDrawer();
  } else {
    homeScaffoldKey.currentState?.openDrawer();
  }
}

final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    KtapIndex = 1;
    context.read<HomeCubit>().auctionsStatus = AppStrings.auctionsOnGoing;
    context.read<PagesCubit>().getUnReadCount().then((val) {
      context.read<HomeCubit>().getAuctions();
    });

    // Initialize controllers
    _tabController = TabController(vsync: this, length: 3);
    _pageController = PageController();

    // Synchronize PageController with TabController
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_pageController.page?.round() != _tabController.index) {
          _pageController.jumpToPage(_tabController.index);
        }
        setState(() {});
        // Update the ProfileCubit based on the selected tab
        if (_tabController.index == 0) {
          context.read<HomeCubit>().auctionsStatus = AppStrings.auctionsOnGoing;
          context.read<HomeCubit>().LastHomeAuctionsStatus =
              AppStrings.auctionsOnGoing;
        } else if (_tabController.index == 1) {
          context.read<HomeCubit>().auctionsStatus =
              AppStrings.auctionsInProgress;
          context.read<HomeCubit>().LastHomeAuctionsStatus =
              AppStrings.auctionsInProgress;
        } else {
          context.read<HomeCubit>().auctionsStatus =
              AppStrings.auctionsCompleted;
          context.read<HomeCubit>().LastHomeAuctionsStatus =
              AppStrings.auctionsCompleted;
        }

        context.read<HomeCubit>().getAuctions();
        // context.read<PagesCubit>().getUnReadCount();
      }
    });

    // Set system UI styles
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
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
    KisFromFav = false;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primarySurface(context),
        appBar: HomeAppBarWidget(
          tabController: _tabController,
          toggleDrawer: toggleDrawer,
        ),
        body: HomeBodyWidget(
          tabController: _tabController,
          pageController: _pageController,
        ),
      ),
    );
  }
}
