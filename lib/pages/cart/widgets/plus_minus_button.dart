import 'dart:ui';

import 'package:afisha_market/pages/utils/const.dart';
import 'package:flutter/material.dart';

class PlusMinusButton extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButton(
      {Key? key,
        required this.addQuantity,
        required this.deleteQuantity,
        required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: greyColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
          Text(text),
          IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}