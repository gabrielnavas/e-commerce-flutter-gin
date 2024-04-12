import 'package:flutter/material.dart';

class FashionImage extends StatelessWidget {
  final double widthScreen;
  const FashionImage({required this.widthScreen, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthScreen * .405,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/images/aux.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
