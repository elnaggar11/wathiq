import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/adaptive_layout_widget.dart';
import 'package:wathiq/core/widgets/empty_widget.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/features/home/presentation/view/widgets/home/mazad_card_widget.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../data/models/auctions_model/auctions_model.dart';
import '../mazad_card_shimmer.dart';

class TabBarViewBodyWidget extends StatelessWidget {
  const TabBarViewBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 16,
        end: 16,
      ),
      child: AdaptiveLayout(
          mobileLayout: (context) => HomeMobileLayoute(),
          tabletLayout: (context) => HomeMobileLayoute()),
    );
  }
}

class HomeTapletLayoute extends StatelessWidget {
  const HomeTapletLayoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.auctionsRequestState) {
          case RequestState.ideal:
          case RequestState.loading:
            return MazadCardShimmer();
          case RequestState.error:
            return ErrorAppWidget(
              onTap: () {
                context.read<HomeCubit>().getAuctions();
              },
              text: state.auctionsError!.message,
            );
          case RequestState.loaded:
            return LoadedTapletActionHomeWidget(
              auctionsModel: state.auctionsModel!,
            );
        }
      },
    );
  }
}

class LoadedTapletActionHomeWidget extends StatelessWidget {
  const LoadedTapletActionHomeWidget({
    super.key,
    required this.auctionsModel,
  });
  final AuctionsModel auctionsModel;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 16, // Horizontal spacing between items
          mainAxisSpacing: 16,
          mainAxisExtent: 610.h
          // Vertical spacing between items
          ),
      itemBuilder: (context, index) {
        return MazadCardWidget(
          index: index,
          auctionsModel: auctionsModel,
        );
      },
      itemCount: auctionsModel.data.length,
    );
  }
}

class HomeMobileLayoute extends StatelessWidget {
  const HomeMobileLayoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.auctionsRequestState) {
          case RequestState.ideal:
          case RequestState.loading:
            return MazadCardShimmer();
          case RequestState.error:
            return ErrorAppWidget(
              onTap: () {
                context.read<HomeCubit>().getAuctions();
              },
              text: state.auctionsError!.message,
            );
          case RequestState.loaded:
            return LoadedMobileActionHomeWidget(
              auctionsModel: state.auctionsModel!,
            );
        }
      },
    );
  }
}

class LoadedMobileActionHomeWidget extends StatelessWidget {
  const LoadedMobileActionHomeWidget({
    super.key,
    required this.auctionsModel,
    this.isFromFav = false,
  });
  final AuctionsModel auctionsModel;
  final bool isFromFav;

  @override
  Widget build(BuildContext context) {
    return auctionsModel.data.isEmpty
        ? Center(child: EmptyWidget(title: 'لا توجد مزادات '))
        : ListView.builder(
            itemBuilder: (context, index) {
              return MazadCardWidget(
                index: index,
                auctionsModel: auctionsModel,
                isFromFav: isFromFav,
              );
            },
            itemCount: auctionsModel.data.length,
          );
  }
}
