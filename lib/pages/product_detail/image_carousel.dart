import 'package:afisha_market/pages/product_detail/video_palyer_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
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
  Widget build(BuildContext context){
    if (widget.imageList.isEmpty) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(12)),
        child: Image.asset("assets/images/placeholder_image.png",
            fit: BoxFit.cover),
      );
    } else {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CarouselSlider.builder(
                itemCount: widget.imageList.length,
                options: CarouselOptions(
                  viewportFraction: 1.4,
                  initialPage: 0,
                  aspectRatio: 1 / 1,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 10),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {
                    pageIndex = index;
                    setState(() {});
                  },
                  scrollDirection: Axis.horizontal,
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  if(widget.imageList[index].substring(widget.imageList[index].lastIndexOf('.') + 1, widget.imageList[index].length) == 'jpeg'
                      || widget.imageList[index].substring(widget.imageList[index].lastIndexOf('.') + 1, widget.imageList[index].length) == 'png'
                      || widget.imageList[index].substring(widget.imageList[index].lastIndexOf('.') + 1, widget.imageList[index].length) == 'jpg'
                  ){
                    return  SizedBox(
                      width: double.infinity,
                      child: CachedNetworkImage(
                        placeholder:(context,url) => Image.asset("assets/images/placeholder_image.png"),
                        imageUrl: widget.imageList[index],
                        imageBuilder: (context, imageProvider) => PhotoView(
                          minScale: 0.4,
                          maxScale: 2.0,
                          imageProvider: imageProvider,
                        ),
                        fit: BoxFit.cover,
                      ),
                    );
                  }else if(
                  widget.imageList[index].substring(widget.imageList[index].lastIndexOf('.') + 1, widget.imageList[index].length) == 'gif'||
                   widget.imageList[index].substring(widget.imageList[index].lastIndexOf('.') + 1, widget.imageList[index].length) == 'mp4'
                      || widget.imageList[index].substring(widget.imageList[index].lastIndexOf('.') + 1, widget.imageList[index].length) == 'avi'
                      || widget.imageList[index].substring(widget.imageList[index].lastIndexOf('.') + 1, widget.imageList[index].length) == 'mov'
                  ){
                    return VideoPlayerNetworkImage(widget.imageList[index]);
                  }else{
                    return SizedBox();
                  }

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
                    CarouselDotsIndicator(
                        dotsLength: widget.imageList.length,
                        currentDot: pageIndex),
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
