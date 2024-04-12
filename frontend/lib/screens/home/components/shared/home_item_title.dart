import 'package:flutter/material.dart';

class HomeItemTitle extends StatelessWidget {
  final double widthScreen;
  final String text;

  const HomeItemTitle({
    required this.widthScreen,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 2),
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
