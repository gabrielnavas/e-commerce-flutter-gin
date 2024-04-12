import 'package:flutter/material.dart';

class FashionTitle extends StatelessWidget {
  final double widthScreen;
  final String text;

  const FashionTitle({
    required this.widthScreen,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 2),
      child: Text(
        'Evening Dress',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: widthScreen * .045,
        ),
      ),
    );
  }
}
