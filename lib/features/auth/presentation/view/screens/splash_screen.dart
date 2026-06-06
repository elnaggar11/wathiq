import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/app/app.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import 'package:wathiq/app/injector.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/functions/local_auth.dart';
import 'package:wathiq/core/storage/flutter_secure_storage.dart';
import 'package:wathiq/core/storage/i_app_local_storage.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/widgets/adaptive_layout_widget.dart';

bool KisHijri = false;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScaleAnimation;
  late Timer timer;

  final String text = '0.1 V';

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    super.initState();
    KisHijri =
        serviceLocator<IAppLocalStorage>().getValue(AppStrings.KisHijri) ??
            false;
    initController();

    initLogoScaleAnimation();

    initTextAnimations();

    _controller.forward();
    _completeInitSetUp();
  }

  void _completeInitSetUp() async {
    bool isAppLocked =
        serviceLocator<IAppLocalStorage>().getValue(AppStrings.isAppLocked) ??
            false;
    if (isAppLocked) {
      bool authenticated =
          await authenticateUser('الرجاء المصادقة للوصول إلى التطبيق');
      if (authenticated) {
        if (mounted) {
          navigateToNextScreen(context);
        }
      }
    } else {
      navigateToNextScreen(context);
    }
  }

  void initController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  void initTextAnimations() {}

  void initLogoScaleAnimation() {
    _logoScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
  }

  void navigateToNextScreen(BuildContext context) async {
    // await SecureStorageServices().deleteCookie().then((value) => value);
    var value =
        await SecureStorageServices().getCookie().then((value) => value);
    bool isAppLocked =
        serviceLocator<IAppLocalStorage>().getValue(AppStrings.isAppLocked) ??
            false;

    timer = Timer(
      Duration(seconds: isAppLocked ? 0 : 3),
      () {
        if (value != null) {
          KisGuest = false;
          context.navigateToWithReplacementAndClearStack(Routes.layoutScreen);
        } else {
          KisGuest = true;
          context.navigateToWithReplacementAndClearStack(Routes.layoutScreen);
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          AdaptiveLayout(
            mobileLayout: (context) => SplashScreenMobileLayoutWidget(
                logoScaleAnimation: _logoScaleAnimation,
                size: MediaQuery.of(context).size),
            tabletLayout: (context) => Center(
              child: SizedBox(
                height: 1.sw,
                width: 600,
                child: SplashScreenMobileLayoutWidget(
                  logoScaleAnimation: _logoScaleAnimation,
                  size: MediaQuery.of(context).size,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashScreenMobileLayoutWidget extends StatelessWidget {
  const SplashScreenMobileLayoutWidget({
    super.key,
    required Animation<double> logoScaleAnimation,
    required this.size,
  }) : _logoScaleAnimation = logoScaleAnimation;

  final Animation<double> _logoScaleAnimation;
  final Size size;

  @override
  Widget build(BuildContext context) {
    bool isAppLocked =
        serviceLocator<IAppLocalStorage>().getValue(AppStrings.isAppLocked) ??
            false;
    return Stack(
      children: [
        Image.asset(
          AppAssets.app_imagesSplashBg,
          fit: BoxFit.cover,
          width: size.width,
          height: size.height,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _logoScaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: SizedBox(
                      width: size.width * 0.35,
                      height: size.height * 0.25,
                      child: SvgPicture.asset(
                        AppAssets.app_imagesLogoWithGreen,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
              isAppLocked
                  ? GestureDetector(
                      onTap: () async {
                        bool authenticated = await authenticateUser(
                            'الرجاء المصادقة للوصول إلى التطبيق');
                        if (authenticated) {
                          if (context.mounted) {
                            _SplashScreenState().navigateToNextScreen(context);
                          }
                        }
                      },
                      child: Text(
                        'فتح القفل',
                        style: AppStyles.styleMedium14(context).copyWith(
                            color: AppColors.typographyHeadingWhite(context)),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
