import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';
import '../../../view_model/home/home_cubit.dart';

class SumDifferenceWidget extends StatelessWidget {
  const SumDifferenceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Colors.white.withOpacity(0.20000000298023224),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'فرق السوم',
            style: AppStyles.styleBold14(context).copyWith(
              color: AppColors.typographyBody(context),
            ),
          ),
          SizedBox(width: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatNumber(homeCubit.auctionOrigin!.garlicDifference),
                style: AppStyles.styleBold16(context).copyWith(
                  color: AppColors.appBarBackground(context),
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 2),
              CurrancyLogoWidget(
                color: AppColors.appBarBackground(context),
                maxHeight: 20,
                maxWidth: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
