import 'package:flutter/material.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_list/fashion_sale_item.dart';

class FashionListItems extends StatelessWidget {
  final double widthScreen;

  const FashionListItems({
    required this.widthScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return FashionSaleItem(widthScreen: widthScreen);
        },
      ),
    );
  }
}
