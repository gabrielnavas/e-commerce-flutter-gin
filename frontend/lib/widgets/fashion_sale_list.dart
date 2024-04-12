import 'package:flutter/material.dart';
import 'package:frontend/widgets/fashion_sale_item.dart';

class FashionSaleList extends StatelessWidget {
  final double widthScreen;

  const FashionSaleList({
    required this.widthScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widthScreen * .04),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
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
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 500,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return FashionSaleItem(widthScreen: widthScreen);
              },
            ),
          )
        ],
      ),
    );
  }
}
