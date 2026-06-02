import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SizedBox(
          width: 600.w,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: PinCodeTextField(
                appContext: context,
                hintCharacter: '-',
                hintStyle: AppStyles.styleSemiBold24(context).copyWith(
                  color: AppColors.iconsPrimary(context).withOpacity(0.5),
                ),
                // validator: (value) {

                // },
                // controller: cubit.verifyController,

                length: 6,
                obscureText: false,
                autoFocus: true,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                textStyle: AppStyles.styleSemiBold24(context)
                    .copyWith(color: AppColors.primary(context)),
                animationType: AnimationType.scale,
                pinTheme: PinTheme(
                  fieldHeight: 56.h,
                  fieldWidth: size.width > 600 ? 56.w : 50.w,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12.r),
                  activeFillColor: AppColors.white(context),
                  activeColor: AppColors.primary(context),
                  inactiveColor: AppColors.inputBorder(context),
                  inactiveFillColor: Colors.white,
                  selectedColor: AppColors.inputBorder(context),
                  selectedFillColor: Colors.white,
                  borderWidth: 1.w,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (code) {
                  cubit.verifyOtp();
                },
                onChanged: (code) {
                  otpCode = code;
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
