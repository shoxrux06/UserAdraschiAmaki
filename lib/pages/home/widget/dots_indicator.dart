import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CarouselDotsIndicator extends StatefulWidget {
  final int dotsLength;
  final int currentDot;
  const CarouselDotsIndicator({Key? key, required this.dotsLength, required this.currentDot}) : super(key: key);

  @override
  State<CarouselDotsIndicator> createState() => _CarouselDotsIndicatorState();

}

class _CarouselDotsIndicatorState extends State<CarouselDotsIndicator> {
  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: widget.dotsLength,
      position: widget.currentDot.toDouble(),
      decorator: DotsDecorator(
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeColor: Colors.deepOrangeAccent,
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
