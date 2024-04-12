import 'package:flutter/material.dart';

class NewItemImageDescription extends StatelessWidget {
  final String description;

  const NewItemImageDescription({
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Text(
        description,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
