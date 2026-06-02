import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import 'package:wathiq/app/app.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/core/widgets/guest_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/agencies/loaded_agencies_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/agencies/shimmer_agency_list.dart';

class AgenciesDetailsScreen extends StatefulWidget {
  const AgenciesDetailsScreen({super.key});

  @override
  State<AgenciesDetailsScreen> createState() => _AgenciesDetailsScreenState();
}

class _AgenciesDetailsScreenState extends State<AgenciesDetailsScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getAgencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimary(context),
        appBar: CoustomAppBarWidget(
          title: 'الوكالات',
        ),
        body: KisGuest == true ? const GuestWidget() : const AgenciesTapBarViweWidegt(),
      ),
    );
  }
}

class AgenciesTapBarViweWidegt extends StatelessWidget {
  const AgenciesTapBarViweWidegt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        switch (state.getAgenciesRequestState) {
          case RequestState.ideal:
          case RequestState.loading:
            return const ShimmerAgencyList();
          case RequestState.error:
            return ErrorAppWidget(
              text: state.getAgenciesError!.message ?? 'حدث خطا',
              onTap: () {
                context.read<ProfileCubit>().getAgencies();
              },
            );
          case RequestState.loaded:
            return LoadedAgenciesWidget(
              agencies: context.read<ProfileCubit>().agencies,
            );
        }
      },
    );
  }
}
