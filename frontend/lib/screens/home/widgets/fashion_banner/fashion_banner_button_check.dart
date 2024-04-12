import 'package:flutter/material.dart';

class FashionBannerButtonCheck extends StatelessWidget {
  final void Function(bool state) setShowFrashionSaleBanner;
  final double widthScreen;
  final String text;

  const FashionBannerButtonCheck({
    required this.widthScreen,
    required this.setShowFrashionSaleBanner,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setShowFrashionSaleBanner(false),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.15),
      ),
      child: Text(
        text,
      ),
    );
  }
}
