import 'package:flutter/material.dart';

class FashionItemDiscount extends StatelessWidget {
  final double discount;

  const FashionItemDiscount({
    required this.discount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      child: Text(
        '-${discount.toString()}%',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
