import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/core/utils/app_styles.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/my_snackbar.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int seconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (!mounted) return;
      setState(() {
        if (seconds == 1) {
          t.cancel();
        }
        seconds--;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.resendCodeRequestState != current.resendCodeRequestState,
      listener: (context, state) {
        if (state.resendCodeRequestState == RequestState.loaded) {
          mySnackBar(
            state.resendCodeMsg ?? 'تم ارسال الرمز قم بالتاكيد',
            context,
            isError: false,
          );
        } else if (state.resendCodeRequestState == RequestState.error) {
          mySnackBar(
            state.resendCodeError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: true,
          );
        }
      },
      child: HaveAnAccountWidget(
        screenNameText: seconds == 0 ? null : '$seconds ثانيه',
        text: seconds == 0 ? 'اعادة ارسال الرمز ' : 'إعادة إرسال الرمز بعد',
        onTap: () {
          if (seconds == 0) {
            context.read<AuthCubit>().resendCode();
            setState(() {
              seconds = 60;
            });
            startTimer(); // Restart the timer
          }
        },
      ),
    );
  }
}

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({
    super.key,
    required this.text,
    this.screenNameText,
    this.color1,
    this.color2,
    this.fontSize,
    required this.onTap,
  });

  final String text;
  final String? screenNameText;
  final Color? color1, color2;
  final double? fontSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: Text(
            text,
            style: AppStyles.styleMedium16(context)
                .copyWith(color: AppColors.primary(context)),
          ),
        ),
        4.horizontalSpace,
        screenNameText != null
            ? Text(
                screenNameText!,
                style: AppStyles.styleMedium16(context).copyWith(
                  color: AppColors.secondColor(context),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
