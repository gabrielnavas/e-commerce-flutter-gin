import 'package:flutter/material.dart';
import 'package:frontend/screens/home/components/fashion_sale_list/fashion_header_image.dart';
import 'package:frontend/screens/home/components/fashion_sale_list/fashion_list_header.dart';
import 'package:frontend/screens/home/components/fashion_sale_list/fashion_list_items.dart';

class FashionSaleList extends StatelessWidget {
  final double widthScreen;

  const FashionSaleList({
    required this.widthScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          FashionHeaderImage(
            widthScreen: widthScreen,
            imagePath: 'assets/images/sale_header_image.png',
            text: 'Street Clothes',
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: widthScreen * .04),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                FashionListHeader(widthScreen: widthScreen),
                const SizedBox(
                  height: 20,
                ),
                FashionListItems(widthScreen: widthScreen),
              ],
            ),
          )
        ],
      ),
    );
  }
}
