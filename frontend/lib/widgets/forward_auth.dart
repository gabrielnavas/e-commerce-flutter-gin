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

    if (provider.isLoggin) {
      return forwardScreen;
    }
    return stayScreen;
  }
}
