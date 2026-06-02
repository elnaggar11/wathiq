import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/app/app.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/calculator_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/enrollment_buttom_sheet.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mozayda_sheet/auction_price_and_add_widegts.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mozayda_sheet/enrollment_first_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/mozayda_sheet/mozayda_sheet.dart';

import 'package:wathiq/core/functions/format_number.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

class MozaydaBoardWidget extends StatelessWidget {
  const MozaydaBoardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TopMozaydaWidget(),
            const SizedBox(height: 16),
            const AuctionPriceWidegt(),
            const SizedBox(height: 16),
            !homeCubit.auctionOrigin!.isEnrolled!
                ? const CalculatorWidget()
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.all(0),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: KisGuest == true
                  ? const enrollmentFirstWidget()
                  : homeCubit.auctionOrigin!.isEnrolled == false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'عربون الدخول',
                              textAlign: TextAlign.start,
                              style: AppStyles.styleBold14(context).copyWith(
                                color: AppColors.typographyBody(context),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              formatNumber(
                                  homeCubit.auctionOrigin!.entryDeposit),
                              textAlign: TextAlign.start,
                              style: AppStyles.styleBold28(context).copyWith(
                                color: AppColors.typographyHeading(context),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: () {
                                context.read<HomeCubit>().type =
                                    AppStrings.enrolltypeOnline;
                                enrollmentSheetBottomSheet(context);
                              },
                              child: Text(
                                'حجز عربون الدخول',
                                textAlign: TextAlign.start,
                                style: AppStyles.styleBold18(context).copyWith(
                                  color: AppColors.white(context),
                                ),
                              ),
                            )
                          ],
                        )
                      : const AddMozaydaWidget(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
