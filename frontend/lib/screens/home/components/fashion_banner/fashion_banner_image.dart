import 'package:flutter/material.dart';

class FashionBannerImage extends StatelessWidget {
  final String imagePath;

  const FashionBannerImage({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
