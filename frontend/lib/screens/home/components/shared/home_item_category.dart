import 'package:flutter/material.dart';

class HomeItemCategory extends StatelessWidget {
  final double widthScreen;
  final String text;

  const HomeItemCategory({
    required this.widthScreen,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, left: 2),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w400,
          fontSize: widthScreen * .031,
        ),
      ),
    );
    ;
  }
}
