import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';

import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

class AssetSearchWidgetAndNum extends StatelessWidget {
  const AssetSearchWidgetAndNum({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'الاصول  ( ${homeCubit.auctionData!.auctionOrigins.length} )',
            style: AppStyles.styleBold24(context).copyWith(
              color: AppColors.typographyHeading(context),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            child: TextFormFieldWithTitleWidget(
              label: 'إبحث عن أصل',
              controller: homeCubit.originSearch,
              onChanged: (value) {
                homeCubit.searchAuctionOrigins(value);
              },
              suffix: Container(
                height: 40,
                margin: const EdgeInsetsDirectional.all(8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFF18365F) /* Surface-secondary-action */,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x0C161513),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: InkWell(
                    child: SvgPicture.asset(
                      Assets.imagesMagnifer,
                      fit: BoxFit.contain,
                      color: AppColors.white(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
