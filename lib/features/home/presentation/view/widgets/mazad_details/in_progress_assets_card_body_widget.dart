import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/Mazadenroll_and_show_more_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/asset_card_widget.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/utils/images.dart';
import '../../../view_model/home/home_cubit.dart';
import '../assets_details/logout_auction_sheet.dart';
import '../assets_details/register_auction_sheet.dart';
import '../home/mazad_card_time_widgets.dart';

class InProgressAssetsCardBodyWidget extends StatelessWidget {
  const InProgressAssetsCardBodyWidget({super.key, required this.index});
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
          Row(
            children: [
              AssetsDetailsCardColumWidget(
                dateLabel: 'تاريخ بداية المزاد',
                maxWidth: 100,
                date: formatDateFunction(
                    homeCubit.auctionData!.startDate.toString()),
                showCurrancyLogo: false,
                icon: AppAssets.app_imagesCalendar,
              ),
              SizedBox(width: 8),
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
          SizedBox(height: 4),
          Row(
            children: [
              AssetsDetailsCardColumWidget(
                maxWidth: 100,
                dateLabel: 'السعر الافتتاحي',
                date: formatNumber(homeCubit.originList[index].openingPrice),
                showCurrancyLogo: true,
                icon: AppAssets.app_imagesBanknote,
              ),
              SizedBox(width: 8),
              AssetsDetailsCardColumWidget(
                maxWidth: 100,
                dateLabel: 'عربون الدخول',
                date: formatNumber(homeCubit.originList[index].entryDeposit)
                    .toString(),
                showCurrancyLogo: true,
                icon: AppAssets.app_imagesBillCheck,
              ),
            ],
          ),
          SizedBox(height: 12),
          BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            return MazadEnrollAndShowMoreWidget(
              buttonColor: AppColors.iconsSecondary(context),
              flexButton: 1,
              flexDetailsButton: 1,
              index: index,
              textButton1:
                  homeCubit.auctionData!.auctionOrigins[index].isEnrolled!
                      ? 'مغادرة المزاد'
                      : 'سجل في المزاد',
              onPressedButton1: () {
                homeCubit.auctionOrigin = homeCubit.originList[index];
                KoriginId = homeCubit.originList[index].id;
                if (homeCubit.originList[index].isEnrolled!) {
                  LogOutFromAuctionSheetBottomSheet(context);
                } else {
                  registerAuctionSheet(context);
                }
              },
            );
          })
        ],
      ),
    );
  }
}
