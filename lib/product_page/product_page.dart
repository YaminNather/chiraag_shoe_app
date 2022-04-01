import 'package:chiraag_shoe_app/product_page/images_carousel/images_carousel.dart';
import 'package:chiraag_shoe_app/product_page/radio_button.dart';
import 'package:chiraag_shoe_app/product_page/radio_group.dart';
import 'package:flutter/material.dart';
import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({ Key? key, required this.id }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();


  final String id;
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();

    print("WIDGET_ID ${ widget.id }");
    _client.inventory().getProduct(widget.id).then(
      (value) {
        setState(() => _product = value);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: _buildAppBar(), body: _buildBody()));
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: <IconButton>[
        IconButton(icon: const Icon(Icons.search_outlined), onPressed: () {})
      ]
    );
  }

  Widget _buildBody() {
    final ThemeData theme = Theme.of(context);

    final Product? product = _product;
    if(product == null)
      return const Center( child: CircularProgressIndicator.adaptive() );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 40.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(product.name, style: theme.textTheme.headline4),
            ),

            const SizedBox(height: 16.0),

            ImagesCarousel(product: product),

            // Center(
            //   child: SizedBox(
            //     height: 256.0,
            //     child: Image.network(product.mainImage)
            //   )
            // ),

            const SizedBox(height: 16.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Description', style: theme.textTheme.headline5),

                  const SizedBox(height: 16.0),

                  Text(product.description)
                ]
              ),
            )
          ]
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildSizeInfo(),

              const SizedBox(height: 16.0),
            ]
          ),
        ),

        const SizedBox(height: 16.0),

        Expanded(child: _buildBottomArea())
      ]
    );
  }  

  Widget _buildSizeInfo() {
    final ThemeData theme = Theme.of(context);

    return RichText(
      text: TextSpan(
        text: 'Size: ',
        children: <TextSpan>[
          TextSpan(text: '10', style: theme.textTheme.headline6)
        ]
      )
    );
  }    

  Widget _buildBottomArea() {
    final ThemeData theme = Theme.of(context);
    
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: new BoxDecoration(color: theme.colorScheme.surface),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildAmountField(),
              
              const SizedBox(height: 32.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildBidButton(),
                  
                  _buildSellButton()
                ]
              )
            ]
          )
        )
      )
    );
  }


  Widget _buildBidButton() {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      width: 160.0, height: 64.0,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Bid', style: theme.textTheme.headline6),

            const SizedBox(height: 8.0),

            const Text('Rs. 3000')
          ],
        ),
        onPressed: () {}
      )
    );
  }

  Widget _buildSellButton() {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      width: 160.0, height: 64.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(theme.colorScheme.error)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Sell', style: theme.textTheme.headline6),

            const SizedBox(height: 8.0),

            const Text('Rs. 2500')
          ],
        ),
        onPressed: () {}
      )
    );
  }

  Widget _buildAmountField() {
    return TextField(
      decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Amount')
    );
  }


  final Client _client = Client();
  Product? _product;
}