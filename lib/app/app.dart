import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wathiq/app/injector.dart';
import 'package:wathiq/core/bloc/theme_manager/theme_manager_cubit.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';

import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/features/wallet/presentation/view_model/wallet/wallet_cubit.dart';

bool KisGuest = false;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

const SystemUiOverlayStyle _defaultSystemUiOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.white,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarIconBrightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(_defaultSystemUiOverlayStyle);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemManagerCubit(),
        ),
        BlocProvider.value(
          value: serviceLocator<AuthCubit>(),
        ),
        BlocProvider.value(
          value: serviceLocator<ProfileCubit>(),
        ),
        BlocProvider.value(
          value: serviceLocator<PagesCubit>(),
        ),
        BlocProvider.value(
          value: serviceLocator<HomeCubit>(),
        ),
        BlocProvider.value(
          value: serviceLocator<WalletCubit>(),
        ),
      ],
      child: BlocBuilder<ThemManagerCubit, ThemManagerState>(
        builder: (context, state) {
          return ScreenUtilInit(
            fontSizeResolver: FontSizeResolvers.diagonal,
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            builder: (context, child) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('ar'),
                  Locale('en'),
                ],
                locale: const Locale('ar'),
                theme: state.themeData,
                debugShowCheckedModeBanner: false,
                // locale: DevicePreview.locale(context),
                builder: (context, child) {
                  return AnnotatedRegion<SystemUiOverlayStyle>(
                    value: _defaultSystemUiOverlayStyle,
                    child: ColoredBox(
                      color: AppColors.white(context),
                      child: DevicePreview.appBuilder(context, child),
                    ),
                  );
                },
                onGenerateRoute: (settings) =>
                    AppRoutes.onGenerateRoute(settings),
                initialRoute: Routes.splash,
              );
            },
          );
        },
      ),
    );
  }
}

// builder: (context, child) => MediaQuery(
//           data: const MediaQueryData(textScaler: TextScaler.linear(1)),
//           child: child!,
//         ),
