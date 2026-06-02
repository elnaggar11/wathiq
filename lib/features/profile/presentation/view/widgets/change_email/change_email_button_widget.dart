import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_animations.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';

class ChangeEmailButtonWidget extends StatelessWidget {
  const ChangeEmailButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = context.read<ProfileCubit>();

    return ElevatedButton(
      onPressed: () {
        cubit.addEmail();
      },
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) =>
            previous.addEmailRequestState != current.addEmailRequestState,
        listener: (context, state) {
          if (state.addEmailRequestState == RequestState.loaded) {
            context.navigateToWithArguments(Routes.oTPScreen, {
              'nextRoute': Routes.userInfoScreen,
              'totalSteps': 3,
              'currentStep': 3,
              'width': 95.0,
              'title': 'فضلا ادخل الرمز  المرسل الي بريدك الاليكتروني'
            });
            mySnackBar(
              state.addEmailModelMsg ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: false,
            );
          } else if (state.addEmailRequestState == RequestState.error) {
            mySnackBar(
              state.addEmailError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.addEmailRequestState == RequestState.loading) {
            return Lottie.asset(
              AppAnimationAssets.loading,
            );
          } else {
            return Text(
              'التالي',
              style: AppStyles.styleBold18(context)
                  .copyWith(color: AppColors.white(context)),
            );
          }
        },
      ),
    );
  }
}
