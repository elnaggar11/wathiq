// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';

// ignore: must_be_immutable
class TextFormFieldWithTitleWidget extends StatelessWidget {
  TextFormFieldWithTitleWidget({
    super.key,
    this.showBorder = true,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.textCapitalization,
    this.autofocus,
    this.obscureText,
    this.suffix,
    this.prefix,
    this.enabled,
    this.label,
    thisint,
    this.validator,
    this.filled,
    this.fillColor,
    this.textColor,
    this.onFieldSubmitted,
    this.errorWidget,
    this.inputFormatters,
    this.prefixIconSize,
    this.suffixIconSize,
    this.maxLines = 1,
    this.enabledBorderColore,
    this.onTap,
    this.onChanged,
    this.hint,
    this.title,
    this.hintStyle,
  });
  final TextEditingController? controller;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final bool? obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final bool? enabled;
  final String? hint;
  final String? label;
  final String? Function(String?)? validator;
  Function(String?)? onChanged;
  final bool? filled;
  final Color? fillColor;
  final Color? textColor;
  final Color? enabledBorderColore;
  final void Function(String)? onFieldSubmitted;
  final Widget? errorWidget;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final bool showBorder;
  final VoidCallback? onTap;
  final String? title;
  final TextStyle? hintStyle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(
                title ?? '',
                style: AppStyles.styleSemiBold18(context),
              )
            : const SizedBox.shrink(),
        title != null
            ? const SizedBox(
                height: 4,
              )
            : const SizedBox.shrink(),
        SizedBox(
          child: TextFormField(
            onTap: onTap,
            onChanged: onChanged,
            maxLines: maxLines,
            controller: controller,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            obscureText: obscureText ?? false,
            autofocus: autofocus ?? false,
            enabled: enabled ?? true,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: onFieldSubmitted,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            focusNode: focusNode,
            validator: validator,
            inputFormatters: inputFormatters,
            style: AppStyles.styleSemiBold16(context),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              prefixIconConstraints: prefixIconSize == null
                  ? null
                  : BoxConstraints(
                      maxHeight: prefixIconSize!,
                      maxWidth: prefixIconSize!,
                    ),
              suffixIconConstraints: suffixIconSize == null
                  ? null
                  : BoxConstraints(
                      maxHeight: suffixIconSize!,
                      maxWidth: suffixIconSize!,
                    ),
              filled: filled ?? true,
              fillColor: fillColor ?? AppColors.white(context),
              focusColor: AppColors.white(context),
              iconColor: context.theme.colorScheme.shadow,
              prefixIconColor: AppColors.iconsThAndTCaptions(context),
              suffixIconColor: AppColors.iconsPrimary(context),
              prefixIcon: prefix,
              suffixIcon: suffix,
              // suffix: suffix,
              hintText: hint,
              hintStyle: hintStyle ?? AppStyles.styleRegular16(context),
              label: Text(
                label ?? '',
              ),
              labelStyle: AppStyles.styleRegular16(context).copyWith(
                color: enabled == false
                    ? AppColors.typographyBody(context)
                    : AppColors.typographyBody(context),
              ),
              floatingLabelStyle: AppStyles.styleRegular14(context).copyWith(
                color: AppColors.primary(context),
              ),
              // floatingLabelBehavior: FloatingLabelBehavior.auto,
              //OutlineInputBorder

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                    color: AppColors.backgroundTertiary(context), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                    color: AppColors.backgroundTertiary(context), width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                    color: AppColors.backgroundTertiary(context), width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(color: AppColors.error(context), width: 1),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(color: AppColors.primary(context), width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    BorderSide(color: AppColors.primary(context), width: 1),
              ),
            ),
          ),
        ),
        errorWidget ?? const SizedBox.shrink(),
      ],
    );
  }
}
