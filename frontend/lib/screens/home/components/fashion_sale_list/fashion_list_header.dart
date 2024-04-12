import 'package:flutter/material.dart';

class FashionListHeader extends StatelessWidget {
  final double widthScreen;

  const FashionListHeader({
    required this.widthScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sale',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: widthScreen * .10,
              ),
            ),
            Text(
              'Super summer sale',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.black54,
                fontSize: widthScreen * .03,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text('View all'),
        )
      ],
    );
  }
}
