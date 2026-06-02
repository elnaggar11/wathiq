import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class ShowErrorUnderTFFWidget extends StatelessWidget {
  const ShowErrorUnderTFFWidget(
      {super.key, required this.title, required this.condition});
  final bool condition;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: condition,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 8,
          start: 8,
        ),
        child: Text(
          title,
          style: AppStyles.stylBold10(context),
        ),
      ),
    );
  }
}
