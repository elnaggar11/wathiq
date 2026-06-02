import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/empty_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/shimmer_top_bidders_list.dart';
import 'package:wathiq/features/home/presentation/view/widgets/assets_details/top_bidders_card_widget.dart';

import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';

class TopBiddersWidget extends StatelessWidget {
  const TopBiddersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return Container(
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.white(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'اعلي المزايدين',
                style: AppStyles.styleMedium20(context).copyWith(
                  color: AppColors.typographyHeading(context),
                ),
              ),
              const Spacer(),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Text(
                    homeCubit.boardAuctionData.isEmpty
                        ? '0 مزايد'
                        : '${homeCubit.boardAuctionData.length} مزايد',
                    style: AppStyles.styleMedium20(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  );
                },
              ),
            ],
          ),
          getKTapIndex(context) == 2
              ? const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: EmptyWidget(
                    title: 'المزاد لم يبدأ بعد',
                    subTitle: null,
                    textButton: null,
                    onPressed: null,
                  ),
                )
              : BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    switch (state.getAuctionBoardRequestState) {
                      case RequestState.ideal:
                      case RequestState.loading:
                        return const ShimmerTopBiddersList();
                      case RequestState.error:
                        return ErrorAppWidget(
                          text: 'حدث شئ ما خطأ',
                          onTap: () {
                            homeCubit.getAuctionBoard();
                          },
                        );
                      case RequestState.loaded:
                        return homeCubit.boardAuctionData.isEmpty
                            ? const Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  EmptyWidget(
                                    title: 'لا يوجد مزايدين بعد',
                                    subTitle: null,
                                    textButton: null,
                                    onPressed: null,
                                  ),
                                ],
                              )
                            : ListView.builder(
                                itemCount: homeCubit.boardAuctionData.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return TopBiddersCardWidget(
                                    index: index,
                                    boardAuctionData:
                                        homeCubit.boardAuctionData,
                                  );
                                },
                              );
                    }
                  },
                )
        ],
      ),
    );
  }
}
