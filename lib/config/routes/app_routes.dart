import 'package:flutter/material.dart';
import 'package:wathiq/features/auth/presentation/view/screens/login_screen.dart';
import 'package:wathiq/features/paegs/presentation/view/screens/contact_us_screen.dart';

import 'package:wathiq/features/auth/presentation/view/screens/complete_signup_screen.dart';
import 'package:wathiq/features/auth/presentation/view/screens/forget_password_screen.dart.dart';
import 'package:wathiq/features/auth/presentation/view/screens/otp_screen.dart';
import 'package:wathiq/features/auth/presentation/view/screens/reset_password_screen.dart.dart';
import 'package:wathiq/features/auth/presentation/view/screens/sign_up_screen.dart';
import 'package:wathiq/features/auth/presentation/view/screens/splash_screen.dart';
import 'package:wathiq/features/home/presentation/view/screens/assets_details_screen.dart';
import 'package:wathiq/features/home/presentation/view/screens/home_screen.dart';
import 'package:wathiq/features/home/presentation/view/screens/mazad_details_screen.dart';
import 'package:wathiq/features/home/presentation/view/screens/mazadat_menu_screen.dart';
import 'package:wathiq/features/home/presentation/view/screens/my_mazadat.dart';
import 'package:wathiq/features/home/presentation/view/screens/policy_screen.dart';
import 'package:wathiq/features/home/presentation/view/screens/saved_mazade_screen.dart';
import 'package:wathiq/features/home/presentation/view/screens/wallet.dart';
import 'package:wathiq/features/layout/presentation/view/screens/layout_screen.dart';
import 'package:wathiq/features/paegs/presentation/view/screens/add_real_state_screen.dart';
import 'package:wathiq/features/paegs/presentation/view/screens/notification_screen.dart';
import 'package:wathiq/features/paegs/presentation/view/screens/properity_managment.dart';
import 'package:wathiq/features/paegs/presentation/view/screens/question_screen.dart';
import 'package:wathiq/features/paegs/presentation/view/screens/sales_agent/add_sales_agent.dart';
import 'package:wathiq/features/paegs/presentation/view/screens/sales_agent/sales_agent_intro_screen.dart';
import 'package:wathiq/features/profile/presentation/view/screens/agencies_details_screen.dart';
import 'package:wathiq/features/profile/presentation/view/screens/agencies_screen.dart';
import 'package:wathiq/features/profile/presentation/view/screens/change_email_screen.dart';
import 'package:wathiq/features/profile/presentation/view/screens/change_password_screen.dart';
import 'package:wathiq/features/profile/presentation/view/screens/change_phone_number.dart';
import 'package:wathiq/features/profile/presentation/view/screens/profile_screen.dart';
import 'package:wathiq/features/profile/presentation/view/screens/user_info_screen.dart';
import 'package:wathiq/features/wallet/presentation/view/screens/transaction_details_screen.dart';
import 'package:wathiq/features/wallet/presentation/view/screens/trunsaction_history_screen.dart';
import 'package:wathiq/features/wallet/presentation/view/screens/wallet_screen.dart';
import 'package:wathiq/features/wallet/presentation/view/screens/withdraw_screen.dart';

class Routes {
  //auth
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signUpScreen = '/signUpScreen';
  static const String completeSignUpScreen = '/completeSignUpScreen';
  static const String oTPScreen = '/OTPScreen';
  static const String forgetPasswordScreen = '/ForgetPasswordScreen';
  static const String resetPasswordScreen = '/ResetPasswordScreen';
  static const String layoutScreen = '/LayoutScreen';
  static const String homeScreen = '/HomeScreen';
  static const String assetsDetailsScreen = '/AssetsDetailsScreen';
  static const String mazadDetailsScreen = '/MazadDetailsScreen';
  static const String profileScreen = '/ProfileScreen';
  static const String userInfoScreen = '/UserInfoScreen';
  static const String AgenciesDetailsScreen = '/AgenciesDetailsScreen';
  static const String savedMazadeScreen = '/SavedMazadeScreen';
  static const String changePasswordScreen = '/ChangePasswordScreen';
  static const String qustionScreen = '/QustionScreen';
  static const String contactUsScreen = '/ContactUsScreen';
  static const String addSalesAgent = '/SalesAgent';
  static const String SalesAgentIntroScreen = '/SalesAgentIntroScreen';
  static const String notificationScreen = '/NotificationScreen';
  static const String mazadatMenuScreen = '/MazadatMenuScreen';
  static const String changeEmailScreen = '/ChangeEmailScreen';
  static const String MyMazadat = '/MyMazadat';
  static const String Wallet = '/Wallet';
  static const String policyScreen = '/PolicyScreen';
  static const String changePhoneNumberScreen = '/ChangePhoneNumberScreen';
  static const String agenciesScreen = '/AgenciesScreen';
  static const String walletScreen = '/WalletScreen';
  static const String TrunsactionHistoryScreen = '/TrunsactionHistoryScreen';
  static const String TransactionDetailsScreen = '/TransactionDetailsScreen';
  static const String WithdrawScreen = '/WithdrawScreen';
  static const String HeldFundsDetailsScreen = '/HeldFundsDetailsScreen';
  static const String WithdrawDetailsScreen = '/WithdrawDetailsScreen';
  static const String InvoiceDetailsScreen = '/InvoiceDetailsScreen';
  static const String InvoicesBodyScreen = '/InvoicesBodyScreen';
  static const String HeldFundsBodyScreen = '/HeldFundsBodyScreen';
  static const String WithdrawBodyScreen = '/WithdrawBodyScreen';
  static const String AddRealStateScreen = '/AddRealStateScreen';
  static const String ProperityManagment = '/ProperityManagment';
}

class AppRoutes {
  static final List<Widget> layoutScreenBody = [
    const HomeScreen(),
    const MyMazadatScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case Routes.completeSignUpScreen:
        return MaterialPageRoute(
          builder: (_) => const CompleteSignUpScreen(),
        );
      case Routes.oTPScreen:
        return MaterialPageRoute(
          builder: (_) {
            var params = routeSettings.arguments as Map<String, dynamic>?;
            if (params == null ||
                params['totalSteps'] == null ||
                params['currentStep'] == null) {
              return const Scaffold(
                body: Center(child: Text('Missing required OTP parameters')),
              );
            }
            return OTPScreen(
              nextRoute: params['nextRoute'] as String? ?? '',
              totalSteps: params['totalSteps'] as int? ?? 0,
              currentStep: params['currentStep'] as int? ?? 0,
              width: params['width'] as double? ?? 0.0,
              title: params['title'] as String?,
            );
          },
        );
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordScreen(),
        );
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ResetePasswordScreen(),
        );
      case Routes.layoutScreen:
        return MaterialPageRoute(
          builder: (_) => const LayoutScreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.mazadDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const MazadDetailsScreen(),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case Routes.userInfoScreen:
        return MaterialPageRoute(
          builder: (_) => const UserInfoScreen(),
        );
      case Routes.AgenciesDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const AgenciesDetailsScreen(),
        );
      case Routes.savedMazadeScreen:
        return MaterialPageRoute(
          builder: (_) => const SavedMazadeScreen(),
        );
      case Routes.changePasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ChangePasswordScreen(),
        );
      case Routes.qustionScreen:
        return MaterialPageRoute(
          builder: (_) => const QustionScreen(),
        );
      case Routes.contactUsScreen:
        return MaterialPageRoute(
          builder: (_) => const ContactUsScreen(),
        );
      case Routes.addSalesAgent:
        return MaterialPageRoute(
          builder: (_) => const AddSalesAgentScreen(),
        );
      case Routes.SalesAgentIntroScreen:
        return MaterialPageRoute(
          builder: (_) => const SalesAgentIntroScreen(),
        );
      case Routes.notificationScreen:
        return MaterialPageRoute(
          builder: (_) => NotificationScreen(),
        );
      case Routes.mazadatMenuScreen:
        return MaterialPageRoute(
          builder: (_) => const MazadatMenuScreen(),
        );
      case Routes.changeEmailScreen:
        return MaterialPageRoute(
          builder: (_) => const ChangeEmailScreen(),
        );
      case Routes.Wallet:
        return MaterialPageRoute(
          builder: (_) => const MyMazadatScreen(),
        );
      case Routes.MyMazadat:
        return MaterialPageRoute(
          builder: (_) => const Wallet(),
        );
      case Routes.assetsDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const AssetsDetailsScreen(),
        );
      case Routes.policyScreen:
        return MaterialPageRoute(
          builder: (_) => const PolicyScreen(),
        );
      case Routes.changePhoneNumberScreen:
        return MaterialPageRoute(
          builder: (_) => const ChangePhoneNumberScreen(),
        );
      case Routes.agenciesScreen:
        return MaterialPageRoute(
          builder: (_) => const AgenciesScreen(),
        );
      case Routes.walletScreen:
        return MaterialPageRoute(
          builder: (_) => const WalletScreen(),
        );
      case Routes.TrunsactionHistoryScreen:
        return MaterialPageRoute(
          builder: (_) => const TrunsactionHistoryScreen(),
        );
      case Routes.TransactionDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const TransactionDetailsScreen(),
        );
      case Routes.WithdrawScreen:
        return MaterialPageRoute(
          builder: (_) => const WithdrawScreen(),
        );
      case Routes.HeldFundsDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const HeldFundsDetailsScreen(),
        );
      case Routes.WithdrawDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const WithdrawDetailsScreen(),
        );
      case Routes.InvoiceDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const InvoiceDetailsScreen(),
        );
      // case Routes.WithdrawBodyScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const WithdrawBodyScreen(),
      //   );
      // case Routes.HeldFundsBodyScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const HeldFundsBodyScreen(),
      //   );
      // case Routes.InvoicesBodyScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const InvoicesBodyScreen(),
      //   );
      case Routes.AddRealStateScreen:
        return MaterialPageRoute(
          builder: (_) => const AddRealStateScreen(),
        );
      case Routes.ProperityManagment:
        return MaterialPageRoute(
          builder: (_) => const ProperityManagmentScreen(),
        );
    }
    return null;
  }
}
