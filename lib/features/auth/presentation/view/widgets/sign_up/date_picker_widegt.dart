import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';

import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';

class DatePickerWidegt extends StatefulWidget {
  const DatePickerWidegt({
    super.key,
    required this.text,
    required this.controller,
    this.filled,
  });
  final String text;
  final TextEditingController controller;
  final bool? filled;

  @override
  State<DatePickerWidegt> createState() => _DatePickerWidegtState();
}

class _DatePickerWidegtState extends State<DatePickerWidegt> {
  String? _selectedDateFormatted;

  Future<void> _showDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      cancelText: 'إلغاء',
      confirmText: 'تأكيد',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          key: UniqueKey(),
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary(context),
              onPrimary: Colors.white,
              onSurface: AppColors.typographyHeading(context),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary(context),
                textStyle: AppStyles.styleMedium16(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
            dialogBackgroundColor: Colors.grey[100],
          ),
          child: child!,
        );
      },
    );

    handleSelectedDate(selectedDate, context);
  }

  void handleSelectedDate(DateTime? selectedDate, BuildContext context) {
    if (selectedDate != null) {
      // Add a default timezone if none exists
      selectedDate = selectedDate.isUtc
          ? selectedDate
          : selectedDate.toUtc().add(Duration(hours: 0)); // Default to -05:00

      final formattedDate = DateFormat("yyyy-MM-dd").format(selectedDate);
      final isoFormattedDate =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").format(selectedDate);
      print(isoFormattedDate);

      // Update UI state
      setState(() {
        _selectedDateFormatted = formattedDate;
      });

      // // Update cubit state outside of setState
      // context.read<AuthCubit>().completeSignUpCountryController.text =
      //     isoFormattedDate.toString();
      widget.controller.text = isoFormattedDate.toString();
      print(widget.controller.text + 'controller');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: UniqueKey(),
      onTap: _showDatePicker,
      child: TextFormFieldWithTitleWidget(
        key: UniqueKey(),
        fillColor: AppColors.primarySurface(context),
        filled: widget.filled ?? true,
        label: widget.text,

        controller: TextEditingController(
            text: widget.controller.text.isEmpty
                ? '' //widget.text
                : widget.controller.text.split('T').first),
        // // hint: _selectedDateFormatted ?? widget.text,
        // hintStyle: _selectedDateFormatted == null
        //     ? null
        //     : AppStyles.styleSemiBold16(context),
        validator: (value) {
          // if (widget.controller.text.isEmpty == null) {
          //   return 'يرجى ادخال  ${widget.text} ';
          // }
          // if (_selectedDateFormatted!.isEmpty) {
          //   return 'يرجى ادخال ${widget.text} ';
          // }
          if (widget.controller.text.isEmpty) {
            return 'يرجى ادخال ${widget.text} ';
          }
          return null;
        },
        suffixIconSize: 0,
        enabled: false,
        keyboardType: TextInputType.emailAddress,
        prefix: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 24,
              maxHeight: 24,
            ),
            child: SvgPicture.asset(
              AppAssets.app_imagesCalendar,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
