import 'package:flutter/material.dart';

class NewItemPrice extends StatelessWidget {
  final double widthScreen;
  final double price;

  const NewItemPrice({
    required this.widthScreen,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 2),
      child: Row(
        children: [
          Text(
            '$price\$',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontSize: widthScreen * .040,
            ),
          ),
        ],
      ),
    );
  }
}
