import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:flutter/material.dart';

import '../product_page/product_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(this.product, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Card(
        child: InkWell(
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(builder: (context) => ProductPage(id: product.id));
            Navigator.of(context).push(route);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Center(child: Image(image: NetworkImage(product.mainImage), fit: BoxFit.cover))
                ),

                const SizedBox(height: 8.0),

                Text(product.name),

                const SizedBox(height: 8.0),

                Text('Rs. ${product.initialPrice}', style: theme.textTheme.headline6)
              ]
            )
          )
        )
      )
    );
  }



  final Product product;
}