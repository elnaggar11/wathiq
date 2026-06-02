import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget({
    super.key,
    required this.stepperList,
  });
  final List<Widget> stepperList;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        child: Row(
          children: stepperList,
        ),
      ),
    );
  }
}

class StepperCard extends StatelessWidget {
  StepperCard({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.isActive,
    required this.stepNum,
  });
  final String title, stepNum;
  final bool isCompleted, isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
              height: 36,
              width: (!isActive && !isCompleted) ? 36 : 36,
              child: (isActive && !isCompleted)
                  ? Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.darkBlue(context),
                        ),
                      ),
                      child: Text(
                        stepNum,
                        textAlign: TextAlign.center,
                        style: AppStyles.styleBold16(context).copyWith(
                          color: AppColors.darkBlue(context),
                        ),
                      ),
                    )
                  : (isActive && isCompleted)
                      ? Container(
                          width: 34,
                          height: 34,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.darkBlue(context),
                            border: Border.all(
                              color: AppColors.darkBlue(context),
                            ),
                          ),
                          child: Text(
                            stepNum,
                            textAlign: TextAlign.center,
                            style: AppStyles.styleBold16(context).copyWith(
                              color: AppColors.white(context),
                            ),
                          ),
                        )
                      : Container(
                          width: 34,
                          height: 34,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.borderPrimary(context),
                            ),
                          ),
                          child: Text(
                            stepNum,
                            textAlign: TextAlign.center,
                            style: AppStyles.styleBold16(context).copyWith(
                              color: AppColors.typographyBodyWhite(context),
                            ),
                          ),
                        ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: isActive
                  ? AppStyles.styleMedium14(context)
                      .copyWith(color: AppColors.primary(context))
                  : AppStyles.styleMedium14(context).copyWith(
                      color: AppColors.typographyBody(context),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}

class SteperLineWidegt extends StatelessWidget {
  const SteperLineWidegt({
    super.key,
    required this.isActive,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        color: isActive
            ? AppColors.darkBlue(context)
            : AppColors.borderPrimary(context),
        height: 2,
      ),
    ).animate().fadeIn().scaleX();
  }
}

class BuildStep extends StatelessWidget {
  const BuildStep({
    super.key,
    required this.title,
    required this.stepNum,
    required this.isCompleted,
    required this.isActive,
  });
  final String title, stepNum;
  final bool isCompleted, isActive;

  @override
  Widget build(BuildContext context) {
    return (isActive && !isCompleted)
        ? StepperCard(
            isActive: isActive,
            isCompleted: isCompleted,
            title: title,
            stepNum: stepNum,
          )
            .animate(
              delay: 200.ms,
            )
            .scale()
            .shimmer(
              delay: Duration(seconds: 1),
            )
            .then(delay: 500.ms)
            .shimmer(
              delay: Duration(seconds: 1),
            )
        : StepperCard(
            isActive: isActive,
            isCompleted: isCompleted,
            title: title,
            stepNum: stepNum,
          );
  }
}
