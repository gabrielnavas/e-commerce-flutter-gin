import 'package:flutter/material.dart';

class FashionHeaderImage extends StatelessWidget {
  final double widthScreen;
  final String imagePath;
  final String text;

  const FashionHeaderImage({
    required this.widthScreen,
    required this.imagePath,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 15,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: widthScreen * .08,
            ),
          ),
        )
      ],
    );
  }
}
