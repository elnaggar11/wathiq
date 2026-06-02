import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:wathiq/core/utils/app_animations.dart';

class LoadingAppWidget extends StatelessWidget {
  const LoadingAppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 120),
        Center(
          child: Lottie.asset(
            AppAnimationAssets.screenLoading,
            height: 120,
          ),
        ),
      ],
    );
  }
}
