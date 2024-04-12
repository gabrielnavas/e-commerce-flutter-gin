import 'package:flutter/material.dart';
import 'package:frontend/screens/home/components/new_list/new_list_header.dart';
import 'package:frontend/screens/home/components/new_list/new_list_items.dart';

class NewList extends StatelessWidget {
  final double widthScreen;

  const NewList({
    required this.widthScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: widthScreen * .04),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                NewListHeader(widthScreen: widthScreen),
                const SizedBox(
                  height: 20,
                ),
                NewListItems(widthScreen: widthScreen),
              ],
            ),
          )
        ],
      ),
    );
  }
}
