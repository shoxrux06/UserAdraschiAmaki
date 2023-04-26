import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../home/widget/dots_indicator.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageList;

  const ImageCarousel({Key? key, required this.imageList}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("1");
    if (widget.imageList.isEmpty) {
      return Container(
        child: Image.asset("assets/images/placeholder_image.png", fit: BoxFit.cover),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(12)),
      );
    } else {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
              child: CarouselSlider.builder(
                itemCount: widget.imageList.length,
                options: CarouselOptions(
                  viewportFraction: 1,
                  initialPage: 0,
                  aspectRatio: 1 / 1,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {
                    pageIndex = index;
                    setState(() {});
                  },
                  scrollDirection: Axis.horizontal,
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return SizedBox(
                      width: double.infinity,
                      child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/placeholder_image.png", image: widget.imageList[index], fit: BoxFit.cover));
                },
              ),
            ),
          ),
          Builder(
            builder: (BuildContext context) {
              if (widget.imageList.isNotEmpty) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    CarouselDotsIndicator(dotsLength: widget.imageList.length, currentDot: pageIndex),
                  ],
                );
              }
              return Container();
            },
          )
        ],
      );
    }
  }
}
