import 'package:chiraag_shoe_app/widgets/carousel/carousel_page_indicator.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({ 
    Key? key,
    this.controller,
    this.physics,
    required this.itemBuilder, 
    required this.itemCount, 
    this.circleCount = 3
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();

  final PageController? controller;
  final ScrollPhysics? physics;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final int circleCount;
}

class _CarouselState extends State<Carousel> {
  @override
  void initState() {
    super.initState();

    if(widget.controller != null)
      controller = widget.controller!;
    else
      controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.controller != null && widget.controller != controller)
      controller = widget.controller!;

    return Column(
      children: <Widget>[
        Expanded(
          child: PageView.builder(
            controller: controller,
            physics: widget.physics,
            itemCount: widget.itemCount,
            itemBuilder: widget.itemBuilder
          ),
        ),

        const SizedBox(height: 16.0),

        CarouselPageIndicator(controller: controller, pagesCount: widget.itemCount, maxCircleCount: widget.circleCount)
      ]
    );
  }


  late PageController controller;
}