import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/widgets/carousel/carousel.dart';
import 'package:flutter/material.dart';

class ImagesCarousel extends StatelessWidget {
  const ImagesCarousel({ Key? key, required this.product }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> images = [ product.mainImage ];
    if(product.images != null)
      images.addAll(product.images!);

    return Carousel(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Image(image: NetworkImage(images[index]))
        );
      }
    );
  }



  final Product product;
}