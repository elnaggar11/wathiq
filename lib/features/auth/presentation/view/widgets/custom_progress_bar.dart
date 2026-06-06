import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/core/utils/app_colors.dart';

class CustomProgressBar extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const CustomProgressBar({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        // In an RTL layout, index 0 is the rightmost element.
        // We want the active steps to start from the right.
        // So indices from 0 to (currentStep - 1) will be active.
        bool isActive = index < currentStep;

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              // Add margin to the left of all elements except the leftmost one.
              // In RTL, index `totalSteps - 1` is the leftmost element.
              left: index < totalSteps - 1 ? 12.w : 0,
            ),
            height: 8.h,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.color3(context)
                  : AppColors.separatingBorder(context),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );
      }),
    );
  }
}
