import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mazad_details/Mazadenroll_and_show_more_widget.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/images.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/mazad_card_time_widgets.dart';
import '../home/mazad_status_timer_widget.dart';
import '../mozayda_sheet/mozayda_sheet.dart';

class OnGoingAssetsCardBodyWidget extends StatelessWidget {
  const OnGoingAssetsCardBodyWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: ShapeDecoration(
        color: const Color(0x0C22A06B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AssetsDetailsCardColumWidget(
                dateLabel: 'السعر الافتتاحي',
                date: formatNumber(homeCubit.originList[index].openingPrice),
                showCurrancyLogo: true,
                icon: AppAssets.app_imagesBanknote,
              ),
              SizedBox(width: 16),
              AssetsDetailsCardColumWidget(
                dateLabel: 'عربون الدخول',
                date: formatNumber(homeCubit.originList[index].entryDeposit)
                    .toString(),
                showCurrancyLogo: true,
                icon: AppAssets.app_imagesBillCheck,
              ),
            ],
          ),
          SizedBox(height: 16),
          TimerContainerWidget(
            auctionData: context.read<HomeCubit>().auctionData!,
            textStyle: AppStyles.styleBold16(context)
                .copyWith(color: AppColors.typographyHeading(context)),
          ),
          SizedBox(height: 16),
          MazadEnrollAndShowMoreWidget(
            textButton1: 'لوحة المزايدة',
            index: index,
            onPressedButton1: () async {
              homeCubit.auctionOrigin = homeCubit.originList[index];
              KoriginId = homeCubit.originList[index].id;
              homeCubit.auctionId = homeCubit.auctionData!.id;
              homeCubit.originId = homeCubit.auctionOrigin!.id;
              homeCubit.amount = null;
              await homeCubit.getAuctionBoard();
              context.read<HomeCubit>().addNewBidValue();
              mozaydaSheetBottomSheet(context);
            },
            icon: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.getAuctionBoardRequestState == RequestState.loading) {
                  return SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: AppColors.white(context),
                    ),
                  );
                } else {
                  return SvgPicture.asset(
                    AppAssets.app_imagesDocument,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
