import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/confirm_add_bid_sheet.dart';

import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/mazad_card_time_widgets.dart';

class CallToActionAddMozaydaWidget extends StatelessWidget {
  const CallToActionAddMozaydaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                confirmAddBidSheetBottomSheet(context);
                if (homeCubit.state.topBid ==
                    homeCubit.boardAuctionData.first.bidAmount) {
                  FloatingSnackBar.show(
                    context,
                    'يجب ان تقوم بزيادة السعر اولا',
                  );
                  return;
                } else if (getKTapIndex(context) == 2) {
                  FloatingSnackBar.show(
                    context,
                    'المزاد لم يبدأ بعد',
                  );
                  return;
                } else {
                  confirmAddBidSheetBottomSheet(context);
                }
              },
              child: Text(
                'أضف مزايدتك',
                style: AppStyles.styleMedium18(context).copyWith(
                  color: AppColors.white(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
