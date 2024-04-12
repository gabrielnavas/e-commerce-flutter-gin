import 'package:flutter/material.dart';
import 'package:frontend/screens/home/components/new_list/new_item.dart';

class NewListItems extends StatelessWidget {
  final double widthScreen;

  const NewListItems({
    required this.widthScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return NewItem(widthScreen: widthScreen);
        },
      ),
    );
  }
}
