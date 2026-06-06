import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/utils/media_query_values.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';

import 'package:wathiq/app/app.dart';
// import 'package:wathiq/app/injector.dart';
// import 'package:wathiq/core/storage/i_app_local_storage.dart';
// import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/widgets/guest_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/profile/profile_cart_widget.dart';
import 'package:wathiq/features/profile/presentation/view/widgets/profile/show_log_out_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    _updateStatusBar();
    super.initState();
  }

  void _updateStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    Future.delayed(const Duration(milliseconds: 100)).then((v) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateStatusBar();
    // bool isAppLocked =
    //     serviceLocator<IAppLocalStorage>().getValue(AppStrings.isAppLocked) ??
    //         false;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primarySurface(context),
        appBar: CoustomAppBarWidget(
          title: 'الملف الشخصي',
        ),
        body: KisGuest == true
            ? const GuestWidget()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            ProfileCartWidget(
                              image: AppAssets.app_imagesProfilr,
                              onTap: () {
                                context.navigateTo(Routes.userInfoScreen);
                              },
                              text: 'المعلومات الشخصية',
                            ),
                            Divider(
                              height: 0,
                              thickness: 1,
                              color: AppColors.separatingBorder(context),
                            ),
                            const SizedBox(height: 8),
                            ProfileCartWidget(
                              image: AppAssets.app_imagesHeart,
                              onTap: () {
                                context.navigateTo(Routes.savedMazadeScreen);
                              },
                              text: 'المفضلة',
                            ),
                            const SizedBox(height: 8),
                            Divider(
                              height: 0,
                              thickness: 1,
                              color: AppColors.separatingBorder(context),
                            ),
                            const SizedBox(height: 8),
                            ProfileCartWidget(
                              image: AppAssets.app_imagesAgencies,
                              onTap: () {
                                context.navigateTo(Routes.agenciesScreen);
                              },
                              text: 'الوكالات',
                            ),
                            const SizedBox(height: 8),
                            Divider(
                              height: 0,
                              thickness: 1,
                              color: AppColors.separatingBorder(context),
                            ),
                            const SizedBox(height: 8),
                            // ProfileCartWidget(
                            //   image: AppAssets.app_imagesCalendar,
                            //   onTap: () {
                            //     changeAppDateSheet(context);
                            //   },
                            //   text: 'تاريخ التطبيق',
                            // ),
                            // const SizedBox(height: 8),
                            // Divider(
                            //   height: 0,
                            //   thickness: 1,
                            //   color: AppColors.separatingBorder(context),
                            // ),
                            // const SizedBox(height: 8),
                            ProfileCartWidget(
                              image: AppAssets.app_imagesChangePassword,
                              onTap: () {
                                context.navigateTo(Routes.changePasswordScreen);
                              },
                              text: 'تغير كلمة المرور',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // ProfileCartWidget(
                      //   image: Platform.isAndroid
                      //       ? AppAssets.app_imagesFingerprint
                      //       : AppAssets.app_imagesFaceID,
                      //   onTap: () async {
                      //     if (isAppLocked) {
                      //       bool result = await authenticateUser(
                      //           'الرجاء المصادقة لاكمال الالغاء');
                      //       if (result) {
                      //         FloatingSnackBar.show(
                      //             context, 'تم الغاء قفل التطبيق ',
                      //             isError: false);
                      //         serviceLocator<IAppLocalStorage>()
                      //             .setValue(AppStrings.isAppLocked, false);
                      //         setState(() {});
                      //       } else {
                      //         FloatingSnackBar.show(
                      //             context, 'تعذر الغاء قفل التطبيق حاول مجددا');
                      //       }
                      //     } else {
                      //       bool result = await authenticateUser(
                      //           'الرجاء المصادقة لاكمال التفعيل');
                      //       if (result) {
                      //         FloatingSnackBar.show(
                      //             context, 'تم قفل التطبيق بالبصمة',
                      //             isError: false);
                      //         serviceLocator<IAppLocalStorage>()
                      //             .setValue(AppStrings.isAppLocked, true);
                      //         setState(() {});
                      //       } else {
                      //         FloatingSnackBar.show(
                      //             context, 'تعذر القفل بالبصمه حاول مجددا');
                      //       }
                      //     }
                      //   },
                      //   text: isAppLocked
                      //       ? 'الغاء القفل بالبصمة'
                      //       : 'قفل التطبيق بالبصمة',
                      // ),
                      // const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          showLogOutBottomSheet(context);
                        },
                        child: Container(
                          height: 64,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: AppColors.white(context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 26,
                                width: 26,
                                child: SvgPicture.asset(
                                    AppAssets.app_imagesLogout),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'تسجيل الخروج',
                                style: AppStyles.styleMedium16(context)
                                    .copyWith(color: AppColors.danger(context)),
                              ),
                              const Spacer(),
                              SvgPicture.asset(
                                AppAssets.app_imagesProfileArrow,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
