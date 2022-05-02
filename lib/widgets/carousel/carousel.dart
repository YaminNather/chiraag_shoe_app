import 'package:chiraag_shoe_app/widgets/carousel/carousel_controller.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({ 
    Key? key,
    this.controller,
    this.physics,
    required this.itemBuilder,
    required this.itemCount,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();

  final CarouselController? controller;
  final ScrollPhysics? physics;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
}

class _CarouselState extends State<Carousel> {
  @override
  void initState() {
    super.initState();

    if(widget.controller != null)
      controller = widget.controller!;
    else
      controller = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.controller != null && widget.controller != controller)
      controller = widget.controller!;

    return Column(
      children: <Widget>[
        Expanded(
          child: PageView.builder(
            controller: controller.pageController,
            physics: widget.physics,
            itemCount: widget.itemCount,
            itemBuilder: widget.itemBuilder
          )
        )
      ]
    );
  }



  late CarouselController controller;
}