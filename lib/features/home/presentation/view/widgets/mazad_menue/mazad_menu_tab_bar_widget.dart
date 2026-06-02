import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/features/home/presentation/view/screens/assets_details_screen.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../view_model/home/home_cubit.dart';

class MazadMenuTabBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const MazadMenuTabBarWidget({
    super.key,
    required TabController tabController,
    required this.tapsName,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<String> tapsName;

  @override
  State<MazadMenuTabBarWidget> createState() => _MazadMenuTabBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}

class _MazadMenuTabBarWidgetState extends State<MazadMenuTabBarWidget> {
  @override
  void initState() {
    super.initState();
    widget._tabController.addListener(() {
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
            top: BorderSide(
              color: AppColors.strockSheen(context),
              width: 1.0,
            ),
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
            setState(() {});
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
                        style: AppStyles.styleBold16(context).copyWith(
                          color: widget._tabController.index == index
                              ? AppColors.primary(context)
                              : AppColors.typographyHeading(context),
                        ),
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state.auctionsRequestState ==
                              RequestState.loaded) {
                            return Row(
                              children: [
                                SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: ShapeDecoration(
                                    color: widget._tabController.index == index
                                        ? AppColors.primary(context)
                                        : AppColors.backgroundPrimary(context),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: Text(
                                    index == 0
                                        ? state
                                            .auctionsModel!.counts!.onGoingCount
                                            .toString()
                                        : index == 1
                                            ? state.auctionsModel!.counts!
                                                .inProgressCount
                                                .toString()
                                            : state.auctionsModel!.counts!
                                                .completedCount
                                                .toString(),
                                    style:
                                        AppStyles.styleBold16(context).copyWith(
                                      color:
                                          widget._tabController.index == index
                                              ? AppColors.white(context)
                                              : AppColors.typographySubTitle(
                                                  context),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return SizedBox.shrink();
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
