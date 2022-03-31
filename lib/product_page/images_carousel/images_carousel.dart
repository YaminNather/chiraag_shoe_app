import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:flutter/material.dart';

class ImagesCarousel extends StatefulWidget {
  const ImagesCarousel({ Key? key, required this.product }) : super(key: key);

  @override
  _ImagesCarouselState createState() => _ImagesCarouselState();

  final Product product;
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  @override
  Widget build(BuildContext context) {
    final Product product = widget.product;

    final List<String> images = [ product.mainImage ];
    if(product.images != null)
      images.addAll(product.images!);

    return Stack(
      children: <Widget>[
        SizedBox(
          height: 256.0,
          child: PageView.builder(
            onPageChanged: (value) => setState(() => _currentPage = value),
            itemCount: images.length,
            itemBuilder: (context, index) => Image.network(images[index])
          )
        ),

        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _buildPageIndexIndicator()
          )
        )
      ]
    );
  }

  Widget _buildPageIndexIndicator() {
    final int pagesCount =  1 + ((widget.product.images != null) ? widget.product.images!.length : 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for(int i = 0; i < _currentPage; i++)
          _buildCircle(false),

        _buildCircle(true),

        for(int i = _currentPage + 1; i < pagesCount; i++)
          _buildCircle(false)
      ]
    );
  }

  Widget _buildCircle(bool isFilled) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(radius: 4.0, backgroundColor: (isFilled) ? Colors.white : Colors.grey),
    );
  }


  int _currentPage = 0;
}