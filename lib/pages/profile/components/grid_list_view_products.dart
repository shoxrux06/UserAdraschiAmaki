import 'package:flutter/material.dart';

class GridListViewProducts extends StatelessWidget {
  const GridListViewProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 150.0,
      ),
      children: List<Widget>.generate(20, (int i) {
        return Builder(builder: (BuildContext context) {
          return Text('$i');
        });
      }),
    );
  }
}
