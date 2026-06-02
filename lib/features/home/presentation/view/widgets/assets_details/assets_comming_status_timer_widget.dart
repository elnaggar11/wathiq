import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/timer_home_widget.dart';

class AssetsCommingStatusTimerWidget extends StatelessWidget {
  const AssetsCommingStatusTimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 92,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: ShapeDecoration(
            color: const Color(0x0C22A06B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ينتهي بعد',
                      style: AppStyles.styleBold16(context).copyWith(
                        color: AppColors.typographyHeading(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 16,
                ),
                TimerHomeWidget(
                  auctionData: context.read<HomeCubit>().auctionData!,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }
}

class RowAssetsDateWidget extends StatelessWidget {
  const RowAssetsDateWidget({
    super.key,
    required this.lable,
    required this.description,
    required this.icon,
    this.iconColor,
    this.textColor,
  });
  final String lable, description, icon;
  final Color? iconColor, textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          color: iconColor,
        ),
        SizedBox(width: 8),
        Text(
          lable,
          style: AppStyles.styleMedium14(context).copyWith(
            color: textColor ?? AppColors.typographyBody(context),
          ),
        ),
        SizedBox(width: 4),
        Text(
          description,
          style: AppStyles.styleBold16(context).copyWith(
            color: AppColors.typographyHeading(context),
          ),
        ),
      ],
    );
  }
}

class AssetsDescriptionWidget extends StatefulWidget {
  const AssetsDescriptionWidget({Key? key}) : super(key: key);

  @override
  State<AssetsDescriptionWidget> createState() =>
      _AssetsDescriptionWidgetState();
}

class _AssetsDescriptionWidgetState extends State<AssetsDescriptionWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return SizedBox(
      width: 0.90.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            homeCubit.auctionOrigin?.description ?? 'وصف الاصل ',
            maxLines: _isExpanded ? null : 5,
            overflow:
                _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: AppStyles.styleMedium18(context).copyWith(
              color: AppColors.typographyHeading(context),
              height: 2,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? "عرض أقل" : "عرض المزيد",
              style: AppStyles.styleMedium16(context).copyWith(
                color: AppColors.primary(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
