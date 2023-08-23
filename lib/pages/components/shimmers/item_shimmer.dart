import 'package:afisha_market/pages/components/shimmers/make_shimmer.dart';
import 'package:flutter/material.dart';

class ItemShimmer extends StatelessWidget {
  const ItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MakeShimmer(child: Container(
      width: MediaQuery.of(context).size.width - 24,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
    ));
  }
}
