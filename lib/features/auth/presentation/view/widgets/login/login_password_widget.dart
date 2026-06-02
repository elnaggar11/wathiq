import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/core/utils/images.dart';

import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';

class LoginPasswordWidget extends StatefulWidget {
  const LoginPasswordWidget({
    super.key,
  });

  @override
  State<LoginPasswordWidget> createState() => _LoginPasswordWidgetState();
}

class _LoginPasswordWidgetState extends State<LoginPasswordWidget> {
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
      controller: cubit.loginPasswordController,
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
              color: obscureText
                  ? AppColors.iconsPrimary(context)
                  : AppColors.primary(context),
            ),
          ),
        ),
      ),
      prefix: Padding(
        padding: EdgeInsetsDirectional.only(end: 14, start: 12.w),
        child: SizedBox(
          width: 20,
          height: 20,
          child: InkWell(
            onTap: _changePasswordVisibility,
            child: SvgPicture.asset(AppAssets.app_imagesLock,
                fit: BoxFit.contain, color: AppColors.iconsGrey(context)),
          ),
        ),
      ),
    );
  }
}
