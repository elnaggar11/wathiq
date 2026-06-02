import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_title_and_location_widget.dart';

import 'package:wathiq/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

class ShowMoreWidget extends StatelessWidget {
  const ShowMoreWidget({
    super.key,
    required this.auctionOriginsNum,
    required this.auctionData,
  });
  final int auctionOriginsNum;
  final AuctionData auctionData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        auctionData.logos.length > 0
            ? ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 56,
                  maxHeight: 56,
                ),
                child: CachedNetworkImageWidegt(
                  imageUrl: auctionData.logos[0].logo ?? '',
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          width: 12,
        ),
        auctionData.logos.length > 1
            ? ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 56,
                  maxHeight: 56,
                ),
                child: CachedNetworkImageWidegt(
                  imageUrl: auctionData.logos[1].logo ?? '',
                ),
              )
            : const SizedBox.shrink(),
        const Spacer(),
        GestureDetector(
          onTap: () {
            context.read<HomeCubit>().auctionData = auctionData;
            context.read<HomeCubit>().originList = auctionData.auctionOrigins;
            getKTapIndex(context);

            context.navigateTo(Routes.mazadDetailsScreen);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: ShapeDecoration(
              color: AppColors.primary(context),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'التفاصيل',
              style: AppStyles.styleMedium16(context).copyWith(
                color: AppColors.white(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
