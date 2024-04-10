import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/auth_screen.dart';
import 'package:frontend/screens/auth/forgot_password_enter_email_screen.dart';

class Routes {
  static const String auth = '/auth';
  static const String forgotPassword = '/forgot-password-enter-email';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      Routes.auth: (_) => const AuthScreen(),
      Routes.forgotPassword: (_) => const ForgotPasswordEnterEmailScreen(),
    };
  }
}
