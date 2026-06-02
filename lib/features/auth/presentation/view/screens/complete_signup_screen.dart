import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wathiq/core/widgets/adaptive_layout_widget.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/sign_up/complete_sign_up_mobile_layout_widget.dart';

class CompleteSignUpScreen extends StatefulWidget {
  const CompleteSignUpScreen({super.key});

  @override
  State<CompleteSignUpScreen> createState() => _CompleteSignUpScreenState();
}

class _CompleteSignUpScreenState extends State<CompleteSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(),
        body: AdaptiveLayout(
          mobileLayout: (context) => const CompleteSignUpMobileLayoutWidget(),
          tabletLayout: (context) => Center(
            child: SizedBox(
              height: 1.sw,
              width: 600,
              child: const CompleteSignUpMobileLayoutWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
