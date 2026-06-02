import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_images.dart';

import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/widgets/text_form_field_with_title_widget.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';

class SignUpPasswordWidget extends StatefulWidget {
  const SignUpPasswordWidget({
    super.key,
  });

  @override
  State<SignUpPasswordWidget> createState() => _SignUpPasswordWidgetState();
}

class _SignUpPasswordWidgetState extends State<SignUpPasswordWidget> {
  bool obscureText = true;
  bool obscureTextConfirm = true;

  void _changePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void _changeConfirmPasswordVisibility() {
    setState(() {
      obscureTextConfirm = !obscureTextConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Column(
      children: [
        TextFormFieldWithTitleWidget(
          controller: cubit.completeSignUpPasswordController,
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

            return null; // كلمة المرور صالحة
          },
          prefix: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 14,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 24,
                maxHeight: 24,
              ),
              child: SvgPicture.asset(
                AppAssets.app_imagesIcon,
                fit: BoxFit.fill,
              ),
            ),
          ),
          suffix: Padding(
            padding: EdgeInsetsDirectional.only(end: 18, start: 6.w),
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
        ),
        20.verticalSpace,
        TextFormFieldWithTitleWidget(
          controller: cubit.completeSignUpConfirmPasswordController,
          obscureText: obscureTextConfirm,
          label: 'تاكيد كلمة المرور',
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
            if (cubit.completeSignUpConfirmPasswordController.text !=
                cubit.completeSignUpPasswordController.text) {
              return 'تأكيد كلمة المرور غير متطابقة';
            }

            return null; // كلمة المرور صالحة
          },
          prefix: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 14,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 20,
                maxHeight: 20,
              ),
              child: SvgPicture.asset(
                AppAssets.app_imagesIcon,
                fit: BoxFit.fill,
              ),
            ),
          ),
          suffix: Padding(
            padding: EdgeInsetsDirectional.only(end: 18, start: 6.w),
            child: SizedBox(
              width: 20,
              height: 20,
              child: InkWell(
                onTap: _changeConfirmPasswordVisibility,
                child: SvgPicture.asset(
                  Assets.imagesIcon,
                  fit: BoxFit.contain,
                  color: !obscureTextConfirm
                      ? AppColors.primary(context)
                      : AppColors.iconsPrimary(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
