import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/Mazadenroll_and_show_more_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/asset_card_widget.dart';

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';

class CompletedAssetsCardBodyWidget extends StatelessWidget {
  const CompletedAssetsCardBodyWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: ShapeDecoration(
        color: const Color(0x33D7D8DB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          const AssetsDetailsCardColumWidget(
            dateLabel: 'أعلى مزايدة',
            date: '55,505',
            showCurrancyLogo: true,
            icon: AppAssets.app_imagesSquareDoublAltArrowUp,
          ),
          Row(
            children: [
              AssetsDetailsCardColumWidget(
                maxWidth: 100,
                dateLabel: 'تاريخ بداية المزاد',
                date: formatDateFunction(
                    homeCubit.auctionData!.startDate.toString()),
                showCurrancyLogo: false,
                icon: AppAssets.app_imagesCalendar,
              ),
              const SizedBox(width: 8),
              AssetsDetailsCardColumWidget(
                maxWidth: 100,
                dateLabel: 'وقت بداية المزاد',
                date: formatTimeFunction(
                    homeCubit.auctionData!.startDate.toString()),
                showCurrancyLogo: false,
                icon: AppAssets.app_imagesAlarm,
              ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      homeCubit.auctionOrigin = homeCubit.originList[index];
                      KoriginId = homeCubit.originList[index].id;

                      context.navigateTo(Routes.assetsDetailsScreen);
                    },
                    label: Text(
                      'مزاد منتهي',
                      style: AppStyles.styleMedium16(context)
                          .copyWith(color: AppColors.danger(context)),
                    ),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 1,
                          color: AppColors.danger(
                              context), // <-- Border color here
                        ),
                        padding: const EdgeInsets.all(0),
                        minimumSize: const Size(double.infinity, double.infinity),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(
                            width: 2,
                            color: AppColors.danger(context),
                          ),
                        ),
                        foregroundColor: AppColors.danger(context),
                        backgroundColor: const Color(0xFFFCE8E8)),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  flex: 6,
                  child: MazadEnrollAndShowMoreWidget(
                    index: index,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
