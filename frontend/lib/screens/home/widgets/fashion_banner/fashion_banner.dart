import 'package:flutter/material.dart';
import 'package:frontend/screens/home/widgets/fashion_banner/fashion_banner_button_check.dart';
import 'package:frontend/screens/home/widgets/fashion_banner/fashion_banner_title.dart';
import 'package:frontend/screens/home/widgets/fashion_banner/fashion_banner_image.dart';

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
        const FashionBannerImage(
            imagePath: 'assets/images/home_fashion_sale.png'),
        Positioned(
          left: 15,
          bottom: 30,
          child: SizedBox(
            width: widthScreen * 0.50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FashionBannerTitle(
                    widthScreen: widthScreen, title: 'Fashion Sale'),
                FashionBannerButtonCheck(
                  widthScreen: widthScreen,
                  text: 'Check',
                  setShowFrashionSaleBanner: (state) =>
                      setShowFrashionSaleBanner(state),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
