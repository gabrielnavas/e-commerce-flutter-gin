import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          _fashionBanner(
            width,
          ),
        ],
      ),
    );
  }

  Stack _fashionBanner(double width) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            'assets/images/home_fashion_sale.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 15,
          bottom: 30,
          child: SizedBox(
            width: width * 0.50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fashion Sale',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                  ),
                  child: const Text(
                    'Check',
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
