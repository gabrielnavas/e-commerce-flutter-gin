import 'package:flutter/material.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_item/fashion_category.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_item/fashion_discount.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_item/fashion_favorite_icon_button.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_item/fashion_feedback.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_item/fashion_image.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_item/fashion_price.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_item/fashion_starts.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_item/fashion_title.dart';

class FashionSaleItem extends StatelessWidget {
  final double widthScreen;

  const FashionSaleItem({
    required this.widthScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: widthScreen * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              FashionImage(widthScreen: widthScreen),
              const Positioned(
                top: 10,
                left: 10,
                child: FashionDiscount(discount: 20),
              ),
              Positioned(
                bottom: -5,
                right: 2,
                child: FashionFavoriteIconButton(widthScreen: widthScreen),
              ),
            ],
          ),
          const Row(
            children: [
              FashionStars(starsFill: 4, starsOutlined: 1),
              FashionFeedback(count: 10),
            ],
          ),
          FashionCategory(widthScreen: widthScreen, text: 'Dorothy Perkins'),
          FashionTitle(widthScreen: widthScreen, text: 'Evening Dress'),
          FashionPrice(
              widthScreen: widthScreen, priceWithDiscount: 12.0, oldPrice: 15.0)
        ],
      ),
    );
  }
}
