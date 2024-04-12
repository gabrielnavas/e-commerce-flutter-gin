import 'package:flutter/material.dart';
import 'package:frontend/screens/home/components/shared/home_item_category.dart';
import 'package:frontend/screens/home/components/shared/home_item_feed.dart';
import 'package:frontend/screens/home/components/shared/home_item_feedback_count.dart';
import 'package:frontend/screens/home/components/shared/home_item_title.dart';
import 'package:frontend/screens/home/components/shared/home_item_starts.dart';
import 'package:frontend/screens/home/components/new_list/new_item_image.dart';
import 'package:frontend/screens/home/components/new_list/new_item_image_description.dart';
import 'package:frontend/screens/home/components/shared/home_item_favorite_button.dart';
import 'package:frontend/screens/home/components/new_list/new_item_price.dart';

class NewItem extends StatelessWidget {
  final double widthScreen;

  const NewItem({
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
              NewItemImage(widthScreen: widthScreen),
              const Positioned(
                top: 10,
                left: 10,
                child: NewItemImageDescription(description: 'NEW'),
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
          NewItemPrice(widthScreen: widthScreen, price: 20.0)
        ],
      ),
    );
  }
}
