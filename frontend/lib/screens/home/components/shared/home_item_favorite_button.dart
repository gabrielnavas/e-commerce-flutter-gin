import 'package:flutter/material.dart';

class HomeItemFavoriteButton extends StatelessWidget {
  final double widthScreen;

  const HomeItemFavoriteButton({
    required this.widthScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(10),
      iconSize: widthScreen * .06,
      color: Colors.black54,
      onPressed: () {},
      icon: const Icon(Icons.favorite_outline),
    );
  }
}
