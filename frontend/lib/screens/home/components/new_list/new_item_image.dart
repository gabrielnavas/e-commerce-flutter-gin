import 'package:flutter/material.dart';

class NewItemImage extends StatelessWidget {
  final double widthScreen;
  const NewItemImage({required this.widthScreen, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthScreen * .405,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/images/aux2.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
