import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/app_animations.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../view_model/auth/auth_cubit.dart';

class ForgetPasswordButtonWidget extends StatelessWidget {
  const ForgetPasswordButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return ElevatedButton(
      onPressed: () {
        cubit.forgetPassword();
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.forgetPassWordRequestState !=
            current.forgetPassWordRequestState,
        listener: (context, state) {
          if (state.forgetPassWordRequestState == RequestState.loaded) {
            context.navigateToWithArguments(Routes.oTPScreen, {
              'nextRoute': Routes.resetPasswordScreen,
              'totalSteps': 3,
              'currentStep': 2,
              'width': 95.0,
            });
            mySnackBar(
              state.forgetPassWordMsg ?? 'تم ارسال الرمز',
              context,
              isError: false,
            );
          } else if (state.forgetPassWordRequestState == RequestState.error) {
            mySnackBar(
              state.forgetPassWordError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
              context,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          if (state.forgetPassWordRequestState == RequestState.loading) {
            return Lottie.asset(
              AppAnimationAssets.loading,
            );
          } else {
            return Text(
              'التحقق',
              style: AppStyles.styleBold18(context)
                  .copyWith(color: AppColors.white(context)),
            );
          }
        },
      ),
    );
  }
}
