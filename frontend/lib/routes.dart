import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/auth_screen.dart';
import 'package:frontend/screens/forgot_password/forgot_password_enter_email_screen.dart';
import 'package:frontend/screens/home/home_screen.dart';
import 'package:frontend/widgets/auth_or_page.dart';
import 'package:frontend/widgets/forward_auth.dart';

class Routes {
  static const String auth = '/auth';
  static const String forgotPassword = '/forgot-password-enter-email';
  static const String home = '/home';

  static const _primaryScreen = AuthOrPage(HomeScreen());

  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      Routes.auth: (_) => const ForwardAuth(
          stayScreen: AuthScreen(), forwardScreen: HomeScreen()),
      Routes.forgotPassword: (_) => const ForgotPasswordEnterEmailScreen(),
      Routes.home: (_) => _primaryScreen,
    };
  }

  static Widget get primaryScreen {
    return _primaryScreen;
  }
}
