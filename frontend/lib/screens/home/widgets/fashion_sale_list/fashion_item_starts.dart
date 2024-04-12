import 'package:flutter/material.dart';

class FashionItemStars extends StatelessWidget {
  final int starsFill;
  final int starsOutlined;

  const FashionItemStars({
    required this.starsFill,
    required this.starsOutlined,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Icon> starFillIcons = List.generate(
      starsFill,
      (_) => const Icon(
        Icons.star,
        color: Color(0xFFFFBA49),
      ),
    );

    List<Icon> starOutliendIcons = List.generate(
      starsOutlined,
      (_) => const Icon(
        Icons.star_border_outlined,
        color: Color(0xFFFFBA49),
      ),
    );

    List<Icon> stars = [];
    stars.addAll(starFillIcons);
    stars.addAll(starOutliendIcons);

    return Row(
      children: stars,
    );
  }
}
