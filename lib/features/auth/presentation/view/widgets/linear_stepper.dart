import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class LinearStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final double width;

  const LinearStepper({
    Key? key,
    required this.totalSteps,
    required this.currentStep,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stepWidth = width / totalSteps;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Row(
            children: List.generate(totalSteps, (index) {
              final isActive = index < currentStep;

              return Container(
                width: width,
                height: 6,
                margin: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 8),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.secondColor(context)
                      : AppColors.disabled(context),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
