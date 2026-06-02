import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/features/home/presentation/view/screens/assets_details_screen.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../../core/widgets/error_app_widget.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/tabBar_view_body_widget.dart';
import '../mazad_card_shimmer.dart';

class MyMazadatTabBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const MyMazadatTabBarWidget({
    super.key,
    required TabController tabController,
    required this.tapsName,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<String> tapsName;

  @override
  State<MyMazadatTabBarWidget> createState() => _MyMazadatTabBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}

class _MyMazadatTabBarWidgetState extends State<MyMazadatTabBarWidget> {
  @override
  void initState() {
    super.initState();
    widget._tabController.addListener(() {
      if (!widget._tabController.indexIsChanging) return;

      setState(() {});
      if (widget._tabController.index == 0) {
        KtapIndex = 1;
        context.read<HomeCubit>().auctionsStatus = AppStrings.auctionsOnGoing;
      } else if (widget._tabController.index == 1) {
        KtapIndex = 2;
        context.read<HomeCubit>().auctionsStatus =
            AppStrings.auctionsInProgress;
      } else {
        KtapIndex = 3;
        context.read<HomeCubit>().auctionsStatus = AppStrings.auctionsCompleted;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            // top: BorderSide(
            //   color: AppColors.strockSheen(context),
            //   width: 1.0,
            // ),
            bottom: BorderSide(
              color: AppColors.strockSheen(context),
              width: 1.0,
            ),
          ),
        ),
        child: TabBar(
          controller: widget._tabController,
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) => Colors.transparent,
          ),
          onTap: (value) {
            // Logic unchanged, setState not needed here
          },
          unselectedLabelColor: Colors.transparent,
          dividerColor: Colors.transparent,
          labelPadding: EdgeInsets.all(0),
          tabs: List<Widget>.generate(
            widget.tapsName.length,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  widget._tabController.animateTo(index);
                });
              },
              child: SizedBox(
                height: 44,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
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
                        widget.tapsName[index],
                        textAlign: TextAlign.center,
                        style: AppStyles.styleMedium14(context).copyWith(
                          color: widget._tabController.index == index
                              ? AppColors.primary(context)
                              : AppColors.typographyHeading(context),
                        ),
                      ),
                      SizedBox(width: 4),
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

class MazadatyTabBarViewBodyWidget extends StatelessWidget {
  const MazadatyTabBarViewBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 16,
        end: 16,
      ),
      child: AdaptiveLayout(
          mobileLayout: (context) => MazadatyMobileLayoute(),
          tabletLayout: (context) => MazadatyMobileLayoute()),
    );
  }
}

class MazadatyMobileLayoute extends StatelessWidget {
  const MazadatyMobileLayoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.getUserAuctionsRequestState) {
          case RequestState.ideal:
          case RequestState.loading:
            return MazadCardShimmer();
          case RequestState.error:
            return ErrorAppWidget(
              onTap: () {
                context.read<HomeCubit>().getUserAuctions();
              },
              text: state.getUserAuctionsError!.message,
            );
          case RequestState.loaded:
            return LoadedMobileActionHomeWidget(
              auctionsModel: state.getUserAuctionsModel!,
            );
        }
      },
    );
  }
}
