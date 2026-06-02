import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../app/app.dart';
import '../../../../../core/widgets/guest_widget.dart';
import '../../view_model/home/home_cubit.dart';
import '../widgets/home/auctions_favorite_button.dart';
import '../widgets/my_mazadat/my_mazadat_tab_bar_widget.dart';

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
        // appBar: CoustomAppBarWidget(
        //   title: 'مزاداتي',
        //   leading: SizedBox.shrink(),
        // ),
        body: KisGuest == true
            ? GuestWidget()
            : Column(
                children: [
                  MyMazadatTabBarWidget(
                    tabController: _tabController,
                    tapsName: [
                      'إشتراكاتي',
                      'مزاداتي الرابحة',
                      'مزاداتي الخاسرة',
                    ],
                  ),
                  SizedBox(height: 4),
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
                        children: [
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
