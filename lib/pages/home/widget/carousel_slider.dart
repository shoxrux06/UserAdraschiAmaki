import 'package:afisha_market/core/data/source/remote/response/AdvertisementResponse.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../product_detail/video_palyer_network_image.dart';
import 'dots_indicator.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<AdvItem> carouselItems;

  const CustomCarouselSlider({Key? key, required this.carouselItems})
      : super(key: key);

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int pageIndex = 0;

  List<String> list = [];

  @override
  void initState() {
    for (var element in widget.carouselItems) {
      for (var element in element.images) {
        list.add(element);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: CarouselSlider.builder(
            itemCount: list.length,
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
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
              if(list[index].substring(list[index].lastIndexOf('.') + 1, list[index].length) == 'jpeg'
                  || list[index].substring(list[index].lastIndexOf('.') + 1, list[index].length) == 'png'
                  || list[index].substring(list[index].lastIndexOf('.') + 1, list[index].length) == 'jpg'
              ){
                return  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  width: MediaQuery.of(context).size.width - 24,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: CachedNetworkImage(
                      placeholder:(context,url) => Image.asset("assets/images/placeholder_image.png"),
                      imageUrl: list.isNotEmpty ? list[index] : '',
                      imageBuilder: (context, imageProvider) => PhotoView(
                        minScale: 0.4,
                        maxScale: 2.0,
                        imageProvider: imageProvider,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }else if(
              list[index].substring(list[index].lastIndexOf('.') + 1, list[index].length) == 'gif'||
                  list[index].substring(list[index].lastIndexOf('.') + 1, list[index].length) == 'mp4'
                  || list[index].substring(list[index].lastIndexOf('.') + 1, list[index].length) == 'avi'
                  || list[index].substring(list[index].lastIndexOf('.') + 1, list[index].length) == 'mov'
              ){
                return VideoPlayerNetworkImage(list[index]);
              }else{
                return SizedBox();
              }

              // return Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(color: Colors.grey),
              //   ),
              //   width: MediaQuery.of(context).size.width - 24,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(11),
              //     child: FadeInImage.assetNetwork(
              //       placeholder: "assets/images/placeholder_image.png",
              //       image: list.isNotEmpty ? list[index] : '',
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // );
            },
          ),
        ),
        CarouselDotsIndicator(dotsLength: list.length, currentDot: pageIndex),
      ],
    );
  }
}
