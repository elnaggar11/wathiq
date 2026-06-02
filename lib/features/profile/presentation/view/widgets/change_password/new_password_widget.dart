import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';

class NewPasswordWidget extends StatefulWidget {
  const NewPasswordWidget({
    super.key,
  });

  @override
  State<NewPasswordWidget> createState() => _NewPasswordWidgetState();
}

class _NewPasswordWidgetState extends State<NewPasswordWidget> {
  bool obscureText = true;

  void _changePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return TextFormFieldWithTitleWidget(
      controller: profileCubit.newPasswordController,
      obscureText: obscureText,
      label: 'كلمة المرور الجديدة',
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

class ConfirmNewPasswordWidget extends StatefulWidget {
  const ConfirmNewPasswordWidget({
    super.key,
  });

  @override
  State<ConfirmNewPasswordWidget> createState() =>
      _ConfirmNewPasswordWidgetState();
}

class _ConfirmNewPasswordWidgetState extends State<ConfirmNewPasswordWidget> {
  bool obscureText = true;

  void _changePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return TextFormFieldWithTitleWidget(
      controller: profileCubit.ConfirmNewPasswordController,
      obscureText: obscureText,
      label: 'تأكيد كلمة المرور الجديدة',
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'يرجى ادخال تأكيد كلمة المرور الجديدة';
        }
        if (profileCubit.newPasswordController.text !=
            profileCubit.ConfirmNewPasswordController.text) {
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
