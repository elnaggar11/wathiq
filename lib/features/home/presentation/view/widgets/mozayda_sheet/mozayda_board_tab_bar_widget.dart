import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';

class MozaydaBoardTabBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const MozaydaBoardTabBarWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  State<MozaydaBoardTabBarWidget> createState() =>
      _MozaydaBoardTabBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}

class _MozaydaBoardTabBarWidgetState extends State<MozaydaBoardTabBarWidget> {
  final List<String> tapsName = [
    'لوحة المزايدة',
    'المزايدين',
  ];

  @override
  void initState() {
    super.initState();
    widget._tabController.addListener(() {
      setState(() {});
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
            bottom: BorderSide(
              color: AppColors.strockSheen(context), // Change color as you like
              width: 1.0, // Thickness of the border
            ),
          ),
        ),
        child: TabBar(
          controller: widget._tabController,
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              return Colors.transparent;
            },
          ),
          unselectedLabelColor: Colors.transparent,
          dividerColor: Colors.transparent,
          labelPadding: EdgeInsets.all(0),
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
                        tapsName[index],
                        style: AppStyles.styleMedium16(context).copyWith(
                          color: widget._tabController.index == index
                              ? AppColors.primary(context)
                              : AppColors.typographyBody(context),
                        ),
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
