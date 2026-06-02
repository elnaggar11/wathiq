import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';

import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../view_model/auth/auth_cubit.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({
    super.key,
  });

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  bool obscureText = true;

  void _changePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return TextFormFieldWithTitleWidget(
      controller: cubit.resetPasswordNewController,
      obscureText: obscureText,
      label: 'كلمة المرور',
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'يرجى ادخال كلمة المرور';
        }

        if (value.length < 8) {
          return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل.';
        }

        if (!containsUppercase(value)) {
          return 'كلمة المرور يجب أن تحتوي على حرف كبير واحد على الأقل.';
        }

        if (!containsLowercase(value)) {
          return 'كلمة المرور يجب أن تحتوي على حرف صغير واحد على الأقل.';
        }

        if (!containsNumber(value)) {
          return 'كلمة المرور يجب أن تحتوي على رقم واحد على الأقل.';
        }

        if (!containsSpecialCharacter(value)) {
          return 'كلمة المرور يجب أن تحتوي على رمز خاص واحد على الأقل.';
        }

        return null;
      },
      suffix: Padding(
        padding: EdgeInsetsDirectional.only(end: 23, start: 1.w),
        child: SizedBox(
          width: 20,
          height: 20,
          child: InkWell(
            onTap: _changePasswordVisibility,
            child: SvgPicture.asset(
              Assets.imagesIcon,
              fit: BoxFit.contain,
              color: !obscureText
                  ? AppColors.primary(context)
                  : AppColors.iconsPrimary(context),
            ),
          ),
        ),
      ),
    );
  }
}

class ResetConfirmPasswordWidget extends StatefulWidget {
  const ResetConfirmPasswordWidget({
    super.key,
  });

  @override
  State<ResetConfirmPasswordWidget> createState() =>
      _ResetConfirmPasswordWidgetState();
}

class _ResetConfirmPasswordWidgetState
    extends State<ResetConfirmPasswordWidget> {
  bool obscureText = true;

  void _changePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return TextFormFieldWithTitleWidget(
      controller: cubit.resetPasswordConfirmController,
      obscureText: obscureText,
      label: 'تاكيد كلمة المرور',
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'يرجى تاكيد كلمة المرور';
        }
        if (cubit.resetPasswordNewController.text !=
            cubit.resetPasswordConfirmController.text) {
          return 'تأكيد كلمة المرور غير متطابقة';
        }
        return null;
      },
      suffix: Padding(
        padding: EdgeInsetsDirectional.only(end: 23, start: 1.w),
        child: SizedBox(
          width: 20,
          height: 20,
          child: InkWell(
            onTap: _changePasswordVisibility,
            child: SvgPicture.asset(
              Assets.imagesIcon,
              fit: BoxFit.contain,
              color: !obscureText
                  ? AppColors.primary(context)
                  : AppColors.iconsPrimary(context),
            ),
          ),
        ),
      ),
    );
  }
}
