import 'package:flutter/material.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_list/fashion_item_category.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_list/fashion_item_discount.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_list/fashion_item_favorite_button.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_list/fashion_item_feedback.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_list/fashion_item_image.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_list/fashion_item_price.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_list/fashion_item_starts.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_list/fashion_title.dart';

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
              FashionItemImage(widthScreen: widthScreen),
              const Positioned(
                top: 10,
                left: 10,
                child: FashionItemDiscount(discount: 20),
              ),
              Positioned(
                bottom: -5,
                right: 2,
                child: FashionItemFavoriteButton(widthScreen: widthScreen),
              ),
            ],
          ),
          const Row(
            children: [
              FashionItemStars(starsFill: 4, starsOutlined: 1),
              FashionItemFeedback(count: 10),
            ],
          ),
          FashionItemCategory(
              widthScreen: widthScreen, text: 'Dorothy Perkins'),
          FashionTitle(widthScreen: widthScreen, text: 'Evening Dress'),
          FashionItemPrice(
              widthScreen: widthScreen, priceWithDiscount: 12.0, oldPrice: 15.0)
        ],
      ),
    );
  }
}
