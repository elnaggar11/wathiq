import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';

class SelectTypeRadioButton extends StatefulWidget {
  const SelectTypeRadioButton({super.key});

  @override
  State<SelectTypeRadioButton> createState() => _SelectTypeRadioButtonState();
}

class _SelectTypeRadioButtonState extends State<SelectTypeRadioButton> {
  String? _selectedValue = 'suggestion';

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
      context.read<PagesCubit>().typeOfContactUs = _selectedValue!;
      print(_selectedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          RadioItem(
            label: 'استفسار',
            value: 'suggestion',
            groupValue: _selectedValue,
            onChanged: _handleRadioValueChange,
            context: context,
          ),
          SizedBox(width: 8),
          RadioItem(
            label: 'سؤال',
            value: 'question',
            groupValue: _selectedValue,
            onChanged: _handleRadioValueChange,
            context: context,
          ),
          SizedBox(width: 8),
          RadioItem(
            label: 'شكوى',
            value: 'complaint',
            groupValue: _selectedValue,
            onChanged: _handleRadioValueChange,
            context: context,
          ),
          SizedBox(width: 8),
          RadioItem(
            label: 'اخرى',
            value: 'other',
            groupValue: _selectedValue,
            onChanged: _handleRadioValueChange,
            context: context,
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFE9E9E9)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 8;
    double dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget RadioItem({
  required String label,
  required String value,
  required String? groupValue,
  required ValueChanged<String?> onChanged,
  required BuildContext context,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: AppColors.primary(context),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      Text(
        label,
        style: AppStyles.styleBold16(context).copyWith(
          color: AppColors.typographySubTitle(context),
        ),
      ),
    ],
  );
}
