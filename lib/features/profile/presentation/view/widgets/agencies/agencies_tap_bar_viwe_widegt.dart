import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/app_styles.dart';

class AgenciesTabBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  AgenciesTabBarWidget({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  State<AgenciesTabBarWidget> createState() => _AgenciesTabBarWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(40.h);
}

class _AgenciesTabBarWidgetState extends State<AgenciesTabBarWidget> {
  final List<String> tapsName = [
    'النشطة',
    'تحت الإجراء',
    'مرفوضة',
    'منتهية',
  ];

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profileCubit = context.read<ProfileCubit>();
        return SizedBox(
          // height: 150,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 500,
                  color: AppColors.backgroundPrimary(context),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                    margin: EdgeInsetsDirectional.only(top: 20, bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.white(context),
                      border: Border.all(
                          color: AppColors.separatingBorder1(context)),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: TabBar(
                      controller: widget.tabController,
                      indicatorColor: Colors.transparent,
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) => Colors.transparent,
                      ),
                      onTap: (value) {
                        // Update status based on tab selection

                        if (value == 0) {
                          profileCubit.status = AppStrings.approved;
                        } else if (value == 1) {
                          profileCubit.status = AppStrings.pending;
                        } else if (value == 2) {
                          profileCubit.status = AppStrings.rejected;
                        } else {
                          profileCubit.status = AppStrings.terminated;
                        }
                        profileCubit.getAgencies();
                      },
                      unselectedLabelColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      labelPadding: EdgeInsets.zero,
                      tabs: List<Widget>.generate(
                        tapsName.length,
                        (index) {
                          final isSelected =
                              index == widget.tabController.index;
                          return SizedBox(
                            height: 40,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: isSelected
                                    ? AppColors.buttonsPrimary(context)
                                    : AppColors.white(context),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tapsName[index],
                                    textAlign: TextAlign.center,
                                    style:
                                        AppStyles.styleBold16(context).copyWith(
                                      color: isSelected
                                          ? AppColors.white(context)
                                          : AppColors.typographyHeading(
                                              context),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: widget.tabController.index == index
                                          ? AppColors.mainColor(context)
                                          : AppColors.backgroundPrimary(
                                              context),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                    child: Text(
                                      isSelected
                                          ? profileCubit.agenciesLength
                                              .toString()
                                          : '0',
                                      style: AppStyles.styleBold16(context)
                                          .copyWith(
                                        color:
                                            widget.tabController.index == index
                                                ? AppColors.secondColor(context)
                                                : AppColors.typographySubTitle(
                                                    context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}
