import 'package:flutter/material.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/screens/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class AuthOrPage extends StatelessWidget {
  final Widget page;
  const AuthOrPage(this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);

    return FutureBuilder(
      future: auth.loadUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!auth.isAuth) {
          return const AuthScreen();
        }
        return page;
      },
    );
  }
}
