import 'package:flutter/material.dart';

class FashionBannerTitle extends StatelessWidget {
  final double widthScreen;
  final String title;

  const FashionBannerTitle({
    required this.widthScreen,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: widthScreen * 0.10,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
