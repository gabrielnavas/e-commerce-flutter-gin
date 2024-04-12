import 'package:flutter/material.dart';
import 'package:frontend/screens/home/widgets/fashion_sale_item.dart';

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
          _headerImage(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: widthScreen * .04),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                _headerList(),
                const SizedBox(
                  height: 20,
                ),
                _items()
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox _items() {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return FashionSaleItem(widthScreen: widthScreen);
        },
      ),
    );
  }

  Row _headerList() {
    return Row(
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
    );
  }

  Stack _headerImage() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            'assets/images/sale_header_image.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 15,
          child: Text(
            'Street clothes',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: widthScreen * .08,
            ),
          ),
        )
      ],
    );
  }
}
