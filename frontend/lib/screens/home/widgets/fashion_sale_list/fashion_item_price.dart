import 'package:flutter/material.dart';

class FashionItemPrice extends StatelessWidget {
  final double widthScreen;
  final double priceWithDiscount;
  final double oldPrice;

  const FashionItemPrice({
    required this.widthScreen,
    required this.priceWithDiscount,
    required this.oldPrice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 2),
      child: Row(
        children: [
          Text(
            '$oldPrice\$',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: widthScreen * .045,
            ),
          ),
          SizedBox(
            width: widthScreen * .01,
          ),
          Text(
            '$priceWithDiscount\$',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w500,
              fontSize: widthScreen * .045,
            ),
          ),
        ],
      ),
    );
  }
}
