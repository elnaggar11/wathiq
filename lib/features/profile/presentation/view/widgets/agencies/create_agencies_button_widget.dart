import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/core/widgets/show_success_bottom_sheet.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';

class CreateAgenciesButtonWidget extends StatelessWidget {
  const CreateAgenciesButtonWidget({
    super.key,
    required this.profileCubit,
  });

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (profileCubit.isAcceptAgencyPolicy == false) {
          FloatingSnackBar.show(
            context,
            'فضلا اقبل الشروط اولا',
            isError: true,
          );
          return;
        }
        profileCubit.createAgency();
      },
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) =>
            previous.createAgencyRequestState !=
            current.createAgencyRequestState,
        listener: (context, state) {
          if (state.createAgencyRequestState == RequestState.loaded) {
            context.pop();
            showSuccessBottomSheet(
              context: context,
              title: 'تم ارسال الوكالة بنجاح',
            );
            context.read<ProfileCubit>().getAgencies();
          } else if (state.createAgencyRequestState == RequestState.error) {
            FloatingSnackBar.show(
              context,
              state.createAgencyError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
              isError: true,
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.createAgencyRequestState !=
            current.createAgencyRequestState,
        builder: (context, state) {
          if (state.createAgencyRequestState == RequestState.loading) {
            print('RequestState.loading');
            return Lottie.asset(
              AppAnimationAssets.loading,
            );
          } else {
            return Text(
              'ارسال طلب الاضافة',
              style: AppStyles.styleSemiBold16(context).copyWith(
                color: AppColors.white(context),
              ),
            );
          }
        },
      ),
    );
  }
}
