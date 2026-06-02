import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/tabBar_view_body_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
    required TabController tabController,
    required PageController pageController,
  })  : _tabController = tabController,
        _pageController = pageController;

  final TabController _tabController;
  final PageController _pageController;

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
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        if (_tabController.index != index) {
          _tabController.animateTo(index);
        }
      },
      children: const [
        TabBarViewBodyWidget(),
        TabBarViewBodyWidget(),
        TabBarViewBodyWidget(),
      ],
    );
  }
}
