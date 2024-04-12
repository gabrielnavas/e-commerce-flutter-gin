import 'package:flutter/material.dart';

class FashionItemImage extends StatelessWidget {
  final double widthScreen;
  const FashionItemImage({required this.widthScreen, super.key});

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
