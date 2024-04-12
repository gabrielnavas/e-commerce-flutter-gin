import 'package:flutter/material.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/screens/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class AuthOrNot extends StatefulWidget {
  final Widget screen;
  const AuthOrNot({required this.screen, super.key});

  @override
  State<AuthOrNot> createState() => _AuthOrNotState();
}

class _AuthOrNotState extends State<AuthOrNot> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);

    if (!provider.isLoggin) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        ),
      );
    }

    return widget.screen;
  }
}
