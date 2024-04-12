import 'package:flutter/material.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => provider.logoff(),
            icon: const Icon(Icons.logout),
          )
        ],
        title: const Text('title'),
      ),
      body: Center(
        child: Text(provider.user!.fullname),
      ),
    );
  }
}
