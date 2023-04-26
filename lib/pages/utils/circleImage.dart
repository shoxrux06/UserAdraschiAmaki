import 'package:flutter/material.dart';

class CircleImage extends StatefulWidget {
  const CircleImage({Key? key}) : super(key: key);

  @override
  State<CircleImage> createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {


  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/cat.jpg'),
        radius: 80,
      ),
    );
  }
}
