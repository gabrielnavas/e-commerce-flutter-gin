import 'package:flutter/material.dart';
import 'package:frontend/screens/home/components/shared/home_item_feedback_count.dart';
import 'package:frontend/screens/home/components/shared/home_item_starts.dart';

class HomeItemFeedback extends StatelessWidget {
  const HomeItemFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: const Row(
        children: [
          HomeItemStars(starsFill: 4, starsOutlined: 1),
          HomeItemFeedbackCount(count: 10),
        ],
      ),
    );
  }
}
