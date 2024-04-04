import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carouselmages extends StatefulWidget {
  const Carouselmages({Key? key, required this.imagesList, this.height, this.networkImages = false}) : super(key: key);

  final List<String> imagesList;
  final double? height;
  final bool networkImages;

  @override
  State<Carouselmages> createState() => _HomeImages();
}

class _HomeImages extends State<Carouselmages> {
  int activeIndex = 0;
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        CarouselSlider.builder(
            carouselController: controller,
            itemCount: widget.imagesList.length,
            itemBuilder: (context, index, realIndex) {
              return Card(
                semanticContainer: true,
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: widget.networkImages ? Image.network(widget.imagesList[index], fit: BoxFit.cover) : Image.asset(widget.imagesList[index], fit: BoxFit.cover),
              );
            },
            options: CarouselOptions(
                height: widget.height,
                autoPlay: true,
                enableInfiniteScroll: false,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                enlargeCenterPage: true,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index))),
        const SizedBox(height: 20),
        buildIndicator(activeIndex, widget.imagesList.length, animateToSlide),
      ],
    );
  }
  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildIndicator(int activeIndex, int lenght, Function(int) onClicked) => AnimatedSmoothIndicator(
  onDotClicked: onClicked,
  effect: const ExpandingDotsEffect(dotWidth: 15, activeDotColor: Colors.orangeAccent ,dotColor: Colors.black),
  activeIndex: activeIndex,
  count: lenght,
);
