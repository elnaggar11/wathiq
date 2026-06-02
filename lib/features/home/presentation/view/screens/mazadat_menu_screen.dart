import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/features/home/presentation/view/screens/assets_details_screen.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../view_model/home/home_cubit.dart';
import '../widgets/home/auctions_favorite_button.dart';
import '../widgets/home/tabBar_view_body_widget.dart';
import '../widgets/mazad_menue/filter_buttom_sheet.dart';
import '../widgets/mazad_menue/mazad_menu_tab_bar_widget.dart';

class MazadatMenuScreen extends StatefulWidget {
  const MazadatMenuScreen({super.key});

  @override
  State<MazadatMenuScreen> createState() => _MazadatMenuScreenState();
}

class _MazadatMenuScreenState extends State<MazadatMenuScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    HomeCubit homeCubit = context.read<HomeCubit>();
    KtapIndex = 1;
    homeCubit.auctionsStatus = AppStrings.auctionsOnGoing;
    homeCubit.getAuctions();

    _tabController = TabController(vsync: this, length: 3);
    _pageController = PageController();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_pageController.page?.round() != _tabController.index) {
          _pageController.jumpToPage(_tabController.index);
        }

        if (_tabController.index == 0) {
          homeCubit.auctionsStatus = AppStrings.auctionsOnGoing;
        } else if (_tabController.index == 1) {
          homeCubit.auctionsStatus = AppStrings.auctionsInProgress;
        } else {
          homeCubit.auctionsStatus = AppStrings.auctionsCompleted;
        }
        homeCubit.getAuctions();
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
        appBar: CoustomAppBarWidget(
          title: 'قائمة المزادات',
          actions: [
            GestureDetector(
              onTap: () {
                filterSheetBottomSheet(context);
              },
              child: SvgPicture.asset(
                Assets.imagesSearchMenuIcon,
              ),
            ),
            SizedBox(width: 12)
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            MazadMenuTabBarWidget(
              tabController: _tabController,
              tapsName: [
                'قائمة',
                'مستقبلية',
                'منتهية',
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
                    _tabController.animateTo(index);
                  },
                  children: [
                    TabBarViewBodyWidget(),
                    TabBarViewBodyWidget(),
                    TabBarViewBodyWidget(),
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
