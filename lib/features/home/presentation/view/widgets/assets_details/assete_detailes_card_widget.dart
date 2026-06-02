import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/assets_comming_status_timer_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/current_and_comming_action_for_assets_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/asset_card_widget.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/functions/time_zon_fun.dart';
import '../../../../../../core/utils/images.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/mazad_card_time_widgets.dart';
import '../home/mazad_status_timer_widget.dart';

class AsseteDetailesCardWidget extends StatelessWidget {
  const AsseteDetailesCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F8),
            borderRadius: BorderRadius.only(
              topLeft: getKTapIndex(context) != 1
                  ? Radius.circular(12)
                  : Radius.zero,
              topRight: getKTapIndex(context) != 1
                  ? Radius.circular(12)
                  : Radius.zero,
            ),
          ),
          child: Row(
            children: [
              AssetsDetailsCardColumWidget(
                maxWidth: 100,
                dateLabel: 'السعر الافتتاحي',
                date: formatNumber(homeCubit.auctionOrigin!.openingPrice),
                showCurrancyLogo: true,
                icon: AppAssets.app_imagesBanknote,
              ),
              SizedBox(width: 16),
              AssetsDetailsCardColumWidget(
                maxWidth: 100,
                dateLabel: 'عربون الدخول',
                date: formatNumber(homeCubit.auctionOrigin!.entryDeposit)
                    .toString(),
                showCurrancyLogo: true,
                icon: AppAssets.app_imagesBillCheck,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
          ),
          child: Row(
            children: [
              AssetsDetailsCardColumWidget(
                maxWidth: 100,
                dateLabel: 'وقت بداية المزاد',
                date: formatTimeFunction(
                    homeCubit.auctionData!.startDate.toString()),
                showCurrancyLogo: false,
                icon: AppAssets.app_imagesAlarm,
              ),
              SizedBox(width: 16),
              AssetsDetailsCardColumWidget(
                maxWidth: 100,
                dateLabel: 'تاريخ بداية المزاد',
                date: formatDateFunction(
                    homeCubit.auctionData!.startDate.toString()),
                showCurrancyLogo: false,
                icon: AppAssets.app_imagesCalendar,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F8),
          ),
          child: RowAssetsDateWidget(
            lable: 'مدة المزاد:',
            textColor: AppColors.typographyBodyWhite(context),
            description:
                homeCubit.auctionData!.numberOfDays.toString() + ' يوم',
            icon: AppAssets.app_imagesClockAuction,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F0EE),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: RowAssetsDateWidget(
            lable: ' تاريخ ويوم نهاية المزاد ',
            description:
                '${getDayNameArabic(homeCubit.auctionData!.startDate.toString())}' +
                    ' ' +
                    formatDateFunction(
                        homeCubit.auctionData!.endDate.toString()),
            icon: AppAssets.app_imagesHourglassLine,
            iconColor: AppColors.error(context),
          ),
        ),
        SizedBox(height: 16),
        getKTapIndex(context) == 3
            ? CompletedAuctionStutesWidget()
            : CurrentAndCommingActionForAssetsWidget(),
      ],
    );
  }
}
