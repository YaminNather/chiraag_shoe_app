import 'dart:math';

import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:flutter/material.dart';

import '../product_page/product_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(this.product, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 0.0,
            bottom: 0.0,
            child: _buildTickButton(theme)
          ),

          InkWell(
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context) => ProductPage(id: product.id));
              Navigator.of(context).push(route);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Rs. ${product.initialPrice}', style: theme.textTheme.headline6),
                  
                  const SizedBox(height: 32.0),
                  
                  Expanded(
                    child: _buildImage()
                  ),


                  const SizedBox(height: 32.0),

                  Text(product.name, style: theme.textTheme.headline5)
                ]
              )
            )
          ),
        ],
      )
    );    
  }

  Widget _buildImage() {
    return Transform.rotate(
      angle: -pi * 0.05,
      child: Transform.translate(
        offset: const Offset(32.0, -32.0),
        child: Image(image: NetworkImage(product.mainImage), fit: BoxFit.cover)
      )
    );
  }

  Widget _buildTickButton(final ThemeData theme) {
    final RoundedRectangleBorder shape = theme.cardTheme.shape as RoundedRectangleBorder;
    final Radius radius = shape.borderRadius.resolve(TextDirection.ltr).topLeft;
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.only(topLeft: radius, bottomRight: radius)
      ),
      padding: const EdgeInsets.all(8.0),
      child: IconButton(icon: const Icon(Icons.check), onPressed: () {})
    );
  }



  final Product product;
}