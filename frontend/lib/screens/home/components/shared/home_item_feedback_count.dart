import 'package:flutter/material.dart';

class HomeItemFeedbackCount extends StatelessWidget {
  final int count;
  const HomeItemFeedbackCount({
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '(${count.toString()})',
      style: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
