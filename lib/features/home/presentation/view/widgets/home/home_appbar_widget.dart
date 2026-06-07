import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';
import 'package:wathiq/app/app.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/home/presentation/view/screens/assets_details_screen.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

class HomeAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBarWidget({
    super.key,
    required this.tabController,
    required this.toggleDrawer,
  });
  final TabController tabController;

  final Function() toggleDrawer;

  @override
  State<HomeAppBarWidget> createState() => _HomeAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(115);
}

class _HomeAppBarWidgetState extends State<HomeAppBarWidget> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      setState(() {});

      // Update the ProfileCubit based on the selected tab
      if (widget.tabController.index == 0) {
        KtapIndex = 1;
        context.read<HomeCubit>().auctionsStatus = AppStrings.auctionsOnGoing;
        context.read<HomeCubit>().LastHomeAuctionsStatus =
            AppStrings.auctionsOnGoing;
      } else if (widget.tabController.index == 1) {
        KtapIndex = 2;
        context.read<HomeCubit>().auctionsStatus =
            AppStrings.auctionsInProgress;
        context.read<HomeCubit>().LastHomeAuctionsStatus =
            AppStrings.auctionsInProgress;
      } else {
        KtapIndex = 3;
        context.read<HomeCubit>().auctionsStatus = AppStrings.auctionsCompleted;
        context.read<HomeCubit>().LastHomeAuctionsStatus =
            AppStrings.auctionsCompleted;
      }

      // context.read<HomeCubit>().getAuctions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: HomeTabBarWidget(
        tabController: widget.tabController,
      ),
      elevation: 0,
      backgroundColor: AppColors.white(context),
      centerTitle: true,
      title: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 34.h, maxWidth: 122.w),
        child: SvgPicture.asset(
          AppAssets.app_imagesHorizintalLogo,
          height: 60,
        ),
      ),
      toolbarHeight: 64.h,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16),
        child: InkWell(
          onTap: widget.toggleDrawer,
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
              Builder(
                builder: (buttonContext) => GestureDetector(
                  onTap: () {
                    final RenderBox button =
                        buttonContext.findRenderObject() as RenderBox;
                    final RenderBox overlay = Navigator.of(context)
                        .overlay!
                        .context
                        .findRenderObject() as RenderBox;
                    final Offset buttonOffset =
                        button.localToGlobal(Offset.zero, ancestor: overlay);

                    final RelativeRect position = RelativeRect.fromLTRB(
                      20.w,
                      buttonOffset.dy + button.size.height + 8.h,
                      20.w + 252.w,
                      buttonOffset.dy + button.size.height + 8.h + 200.h,
                    );

                    showMenu(
                      context: context,
                      position: position,
                      elevation: 0,
                      color: const Color(0xFF18365F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      items: [
                        const CustomPopupContent(),
                      ],
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF18365F),
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
                        Assets.imagesUser,
                        fit: BoxFit.contain,
                        color: AppColors.white(context),
                      ),
                    ),
                  ),
                ),
              ),
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
                        if (count != 0 && count != null && KisGuest == false)
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
    );
  }

  Size get preferredSize => const Size.fromHeight(115);
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MenuItemCard(
            iconAsset: AppAssets.app_imagesUserCheckRounded,
            title: 'أفراد',
            onTap: () {
              context.navigateTo(Routes.login);
              // Your action here
            },
          ),
          const SizedBox(
            height: 12,
          ),
          MenuItemCard(
            iconAsset: AppAssets.app_imagesUserPlusRounded,
            title: 'إنشاء حساب (أفراد)',
            onTap: () {
              context.navigateTo(Routes.signUpScreen);
              // Your action here
            },
          ),
          const SizedBox(
            height: 12,
          ),
          MenuItemCard(
            iconAsset: AppAssets.app_imagesAddSales,
            title: 'إنشاء حساب (وكلاء البيع)',
            onTap: () {
              context.navigateTo(Routes.SalesAgentIntroScreen);
              // Your action conthere
            },
          ),
        ],
      ),
    );
  }
}

class CustomPopupContent extends PopupMenuEntry<void> {
  const CustomPopupContent({super.key});

  @override
  double get height => 200.h;

  @override
  bool represents(void value) => false;

  @override
  State<CustomPopupContent> createState() => _CustomPopupContentState();
}

class _CustomPopupContentState extends State<CustomPopupContent> {
  @override
  Widget build(BuildContext context) {
    return const ListItems();
  }
}

class MenuItemCard extends StatelessWidget {
  final String iconAsset;
  final String title;
  final VoidCallback onTap;

  const MenuItemCard({
    Key? key,
    required this.iconAsset,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: ShapeDecoration(
          color: AppColors.white(context).withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconAsset),
            const SizedBox(width: 8),
            Text(
              title,
              textAlign: TextAlign.right,
              style: AppStyles.styleMedium14(context).copyWith(
                color: AppColors.white(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTabBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const HomeTabBarWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  State<HomeTabBarWidget> createState() => _HomeTabBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}

class _HomeTabBarWidgetState extends State<HomeTabBarWidget> {
  final List<String> tapsName = [
    'قائمة',
    'مستقبلية',
    'منتهية',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPrimary(context),
      child: Container(
        padding: EdgeInsets.only(
          top: 8.h,
          right: 16.w,
          left: 16.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.white(context),
          border: Border(
            top: BorderSide(
              color: AppColors.strockSheen(context), // Change color as you like
              width: 1.0, // Thickness of the border
            ),
            bottom: BorderSide(
              color: AppColors.strockSheen(context), // Change color as you like
              width: 1.0, // Thickness of the border
            ),
          ),
        ),
        child: TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          controller: widget._tabController,
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              return Colors.transparent;
            },
          ),
          unselectedLabelColor: Colors.transparent,
          dividerColor: Colors.transparent,
          labelPadding: const EdgeInsets.symmetric(horizontal: 10),
          tabs: List<Widget>.generate(
            tapsName.length,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  widget._tabController;
                  widget._tabController.animateTo(index);
                });
              },
              child: SizedBox(
                height: 44,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: widget._tabController.index == index
                            ? AppColors.primary(context)
                            : AppColors.white(context),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tapsName[index],
                        style: AppStyles.styleMedium16(context).copyWith(
                          color: widget._tabController.index == index
                              ? AppColors.primary(context)
                              : AppColors.typographyBody(context),
                        ),
                      ),
                      if (widget._tabController.index == index)
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            if (state.auctionsRequestState ==
                                RequestState.loaded) {
                              return Row(
                                children: [
                                  const SizedBox(width: 10),
                                  TweenAnimationBuilder<double>(
                                    tween:
                                        Tween<double>(begin: -20.0, end: 0.0),
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.bounceOut,
                                    builder: (context, value, child) {
                                      return Transform.translate(
                                        offset: Offset(0, value),
                                        child: child,
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color:
                                            widget._tabController.index == index
                                                ? AppColors.primary(context)
                                                : AppColors.backgroundPrimary(
                                                    context),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      child: Text(
                                        index == 0
                                            ? state.auctionsModel!.counts!
                                                .onGoingCount
                                                .toString()
                                            : index == 1
                                                ? state.auctionsModel!.counts!
                                                    .inProgressCount
                                                    .toString()
                                                : state.auctionsModel!.counts!
                                                    .completedCount
                                                    .toString(),
                                        style: AppStyles.styleMedium14(context)
                                            .copyWith(
                                          color: widget._tabController.index ==
                                                  index
                                              ? AppColors.white(context)
                                              : AppColors.typographyBody(
                                                  context),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
