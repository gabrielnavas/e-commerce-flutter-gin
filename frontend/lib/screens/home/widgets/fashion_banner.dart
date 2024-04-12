import 'package:flutter/material.dart';

class FashionBanner extends StatelessWidget {
  final double widthScreen;
  final void Function(bool isShow) setShowFrashionSaleBanner;

  const FashionBanner({
    required this.widthScreen,
    required this.setShowFrashionSaleBanner,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            width: widthScreen * 0.50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fashion Sale',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widthScreen * 0.10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => setShowFrashionSaleBanner(false),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: widthScreen * 0.15),
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
