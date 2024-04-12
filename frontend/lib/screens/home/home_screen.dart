import 'package:flutter/material.dart';
import 'package:frontend/widgets/fashion_sale_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showFashionSaleBanner = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (showFashionSaleBanner)
              _fashionSaleBanner(
                width,
              ),
            if (!showFashionSaleBanner)
              FashionSaleList(
                widthScreen: width,
              )
          ],
        ),
      ),
    );
  }

  Stack _fashionSaleBanner(double width) {
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
                  onPressed: () => setState(
                    () => showFashionSaleBanner = false,
                  ),
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
