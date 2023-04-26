import 'package:afisha_market/core/data/source/remote/response/AdvertisementResponse.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'dots_indicator.dart';

class CustomCarouselSlider extends StatefulWidget {
  final AdvertisementItem carouselItems;

  const CustomCarouselSlider({Key? key, required this.carouselItems}) : super(key: key);

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: CarouselSlider.builder(
            itemCount: widget.carouselItems.images.length,
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (index, reason) {
                pageIndex = index;
                setState(() {});
              },
              scrollDirection: Axis.horizontal,
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey)),
                  width: MediaQuery.of(context).size.width - 26,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/placeholder_image.png", image: widget.carouselItems.images[index], fit: BoxFit.cover)));
            },
          ),
        ),
        CarouselDotsIndicator(dotsLength: widget.carouselItems.images.length, currentDot: pageIndex),
      ],
    );
  }
}