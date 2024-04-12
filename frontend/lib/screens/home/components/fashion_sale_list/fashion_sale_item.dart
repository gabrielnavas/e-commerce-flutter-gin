import 'package:flutter/material.dart';
import 'package:frontend/screens/home/components/shared/home_item_category.dart';
import 'package:frontend/screens/home/components/fashion_sale_list/fashion_item_discount.dart';
import 'package:frontend/screens/home/components/shared/home_item_favorite_button.dart';
import 'package:frontend/screens/home/components/shared/home_item_feed.dart';
import 'package:frontend/screens/home/components/fashion_sale_list/fashion_item_image.dart';
import 'package:frontend/screens/home/components/fashion_sale_list/fashion_item_price.dart';
import 'package:frontend/screens/home/components/shared/home_item_title.dart';

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
                bottom: 2,
                right: 4,
                child: HomeItemFavoriteButton(widthScreen: widthScreen),
              ),
            ],
          ),
          const HomeItemFeedback(),
          HomeItemCategory(widthScreen: widthScreen, text: 'Dorothy Perkins'),
          HomeItemTitle(widthScreen: widthScreen, text: 'Evening Dress'),
          FashionItemPrice(
              widthScreen: widthScreen, priceWithDiscount: 12.0, oldPrice: 15.0)
        ],
      ),
    );
  }
}
