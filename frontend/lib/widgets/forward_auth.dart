import 'package:flutter/material.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ForwardAuth extends StatelessWidget {
  final Widget stayScreen;
  final Widget forwardScreen;

  const ForwardAuth({
    required this.stayScreen,
    required this.forwardScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    return FutureBuilder(
      future: provider.loadUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.isAuth) {
          return forwardScreen;
        }
        return stayScreen;
      },
    );
  }
}
