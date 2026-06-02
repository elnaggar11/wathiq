import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/adaptive_layout_widget.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../app/app.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../core/widgets/guest_widget.dart';
import '../widgets/home/auctions_favorite_button.dart';
import '../widgets/home/tabBar_view_body_widget.dart';
import '../widgets/mazad_card_shimmer.dart';

class SavedMazadeScreen extends StatefulWidget {
  const SavedMazadeScreen({super.key});

  @override
  State<SavedMazadeScreen> createState() => _SavedMazadeScreenState();
}

class _SavedMazadeScreenState extends State<SavedMazadeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getFavorite();
  }

  @override

  // Initial selected value
  String? selectedValue;

  // Dropdown menu items
  final List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  @override
  Widget build(BuildContext context) {
    KisFromFav = true;
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(
          title: 'المزادات المحفوظة',
        ),
        body: KisGuest == true ? GuestWidget() : SavedMazadBodyWidget(),
      ),
    );
  }
}

class SavedMazadBodyWidget extends StatelessWidget {
  const SavedMazadBodyWidget({
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
          mobileLayout: (context) => SavedMazadHomeMobileLayoute(),
          tabletLayout: (context) => SavedMazadHomeMobileLayoute()),
    );
  }
}

class SavedMazadHomeMobileLayoute extends StatelessWidget {
  const SavedMazadHomeMobileLayoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.getFavoriteRequestState) {
          case RequestState.ideal:
          case RequestState.loading:
            return MazadCardShimmer();
          case RequestState.error:
            return ErrorAppWidget(
              onTap: () {
                context.read<HomeCubit>().getFavorite();
              },
              text: state.getFavoriteError!.message,
            );
          case RequestState.loaded:
            return LoadedMobileActionHomeWidget(
              auctionsModel: state.getFavoriteModel!,
              isFromFav: true,
            );
        }
      },
    );
  }
}
