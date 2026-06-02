import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import 'package:wathiq/app/app.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/widgets/adaptive_layout_widget.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/core/widgets/guest_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/change_password/change_password_button_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/change_password/new_password_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/change_password/old_password_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primarySurface(context),
        bottomSheet: KisGuest == true
            ? const SizedBox.shrink()
            : Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.white(context),
                child: const ChangePasswordButtonWidget(),
              ),
        appBar: CoustomAppBarWidget(
          title: 'تغيير كلمه المرور',
        ),
        body: KisGuest == true
            ? const GuestWidget()
            : AdaptiveLayout(
                mobileLayout: (context) =>
                    const ChangePasswordScreenMobileLayoutWidget(),
                tabletLayout: (context) => Center(
                  child: SizedBox(
                    height: 1.sw,
                    width: 600,
                    child: const ChangePasswordScreenMobileLayoutWidget(),
                  ),
                ),
              ),
      ),
    );
  }
}

class ChangePasswordScreenMobileLayoutWidget extends StatelessWidget {
  const ChangePasswordScreenMobileLayoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return Form(
      key: profileCubit.changePasswordeKey,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' يرجي إدخال كلمة المرور القديمة',
                    style: AppStyles.styleBold16(context)
                        .copyWith(color: AppColors.typographyHeading(context)),
                  ),
                  20.verticalSpace,
                  const OldPasswordWidget(),
                  20.verticalSpace,
                  const NewPasswordWidget(),
                  20.verticalSpace,
                  const ConfirmNewPasswordWidget(),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          context.navigateTo(Routes.forgetPasswordScreen);
                        },
                        child: Text(
                          'نسيت كلمة المرور',
                          style: AppStyles.styleMedium16(context)
                              .copyWith(color: AppColors.primary(context)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
