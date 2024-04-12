import 'package:flutter/material.dart';

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
              _image(),
              _discount(context),
              _favoriteIconButton(),
            ],
          ),
          Row(
            children: [
              ..._stars(),
              _feedbacks(),
            ],
          ),
          _category(),
          _title(),
          _price(context),
        ],
      ),
    );
  }

  Padding _category() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 2),
      child: Text(
        'Dorothy Perkins',
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w400,
          fontSize: widthScreen * .031,
        ),
      ),
    );
  }

  Padding _title() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 2),
      child: Text(
        'Evening Dress',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: widthScreen * .045,
        ),
      ),
    );
  }

  Padding _price(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 2),
      child: Row(
        children: [
          Text(
            '15\$',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: widthScreen * .045,
            ),
          ),
          SizedBox(
            width: widthScreen * .01,
          ),
          Text(
            '12\$',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w500,
              fontSize: widthScreen * .045,
            ),
          ),
        ],
      ),
    );
  }

  Text _feedbacks() {
    return const Text(
      '(10)',
      style: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  List _stars() {
    return List.generate(
        5,
        (_) => const Icon(
              Icons.star,
              color: Color(0xFFFFBA49),
            ));
  }

  Positioned _favoriteIconButton() {
    return Positioned(
      bottom: -5,
      right: 2,
      child: IconButton(
        padding: const EdgeInsets.all(10),
        iconSize: widthScreen * .06,
        color: Colors.black54,
        onPressed: () {},
        icon: const Icon(Icons.favorite_outline),
      ),
    );
  }

  Positioned _discount(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).colorScheme.onBackground,
        ),
        child: const Text(
          '-20%',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  SizedBox _image() {
    return SizedBox(
      width: widthScreen * .405,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/images/aux.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
