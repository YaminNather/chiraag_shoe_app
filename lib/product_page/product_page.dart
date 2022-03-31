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
        
        const Spacer(),


        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Size', style: theme.textTheme.headline6),

                  const SizedBox(width: 16.0),

                  RadioGroup<int>(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        for(int i = 6; i < 11; i++)
                          _buildSizeRadioButton(i)
                      ]
                    )
                  )
                ]
              ),

              const SizedBox(height: 16.0),

              Row(
                children: <Widget>[
                  Text('Color', style: theme.textTheme.headline6),

                  const SizedBox(width: 16.0),

                  RadioGroup<Color>(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[                        
                        _buildColorButton(Colors.cyan),

                        const SizedBox(width: 16.0),

                        _buildColorButton(Colors.red),
                    
                        const SizedBox(width: 16.0),

                        _buildColorButton(Colors.green),
                    
                        const SizedBox(width: 16.0),

                        _buildColorButton(Colors.yellow)
                      ]
                    )
                  )
                ]
              )
            ]
          ),
        ),

        const SizedBox(height: 16.0),

        _buildBottomArea()
      ]
    );
  }  

  Widget _buildSizeRadioButton(final int size) {
    Widget _builder(final Color color) {
      return Container(
        width: 36.0, height: 36.0, 
        decoration: new BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: color),
        alignment: Alignment.center,
        child: Text(size.toString())
      );  
    }

    return RadioButton<int>(
      value: size,
      notSelected: _builder(Colors.transparent), 
      onSelected: _builder(Colors.grey.shade100.withOpacity(0.3))
    );
  }

  Widget _buildColorButton(final Color color) {
    Widget _builder(final bool isSelected) {
      return Container(
        width: 36.0, height: 36.0, 
        decoration: new BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: color),
        child: (isSelected) ? Container(
          width: double.infinity, height: double.infinity,
          alignment: Alignment.center,
          color: Colors.black.withOpacity(0.1),
          child: const Icon(Icons.check_outlined)
        ) 
        : null
      );  
    }

    return RadioButton<Color>(
      value: color,
      notSelected: _builder(false), 
      onSelected: _builder(true)
    );
  }

  Widget _buildBottomArea() {
    final ThemeData theme = Theme.of(context);
    final Product product = _product!;

    return DecoratedBox(
      decoration: new BoxDecoration(color: theme.colorScheme.surface),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Row(
          children: <Widget>[
            Text('Rs. ${product.price}', style: theme.textTheme.headline5),

            const Spacer(),

            SizedBox(
              width: 160.0, height: 64.0,
              child: ElevatedButton(
                child: Text('Buy Now', style: theme.textTheme.headline6),
                onPressed: () {
                  SnackBar snackBar = const SnackBar(content: Text('Adding to cart'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              )
            )
          ]
        )
      )
    );
  }


  final Client _client = Client();
  Product? _product;
}