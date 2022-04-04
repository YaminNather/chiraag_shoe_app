import 'package:chiraag_shoe_app/product_page/images_carousel/images_carousel.dart';
import 'package:flutter/material.dart';
import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';

import '../injector.dart';

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

    Future<void> asyncPart() async {
      final Product product = (await _client.inventory().getProduct(widget.id))!;
      final List<Bid> bids = await _bidServices().getBidsForProduct(product.id);
      
      setState(
        () {
          _product = product;
          _bids = bids;
        }
      );
    }

    asyncPart();    
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
              child: Text(product.name.toUpperCase(), style: theme.textTheme.headline4),
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

    final Product product = _product!;
    final List<Bid> bids = _bids!;

    Future<void> onPressed() async {
      await _bidServices().placeBid(product.id, double.parse(_amountFieldController.text));
      await _getBidsFromBackend();
    }

    return SizedBox(
      width: 160.0, height: 64.0,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Bid', style: theme.textTheme.headline6),

            const SizedBox(height: 8.0),

            Text('> Rs. ${(bids.isEmpty) ? product.initialPrice : bids.last.amount}')
          ]
        ),
        onPressed: (_getAmountFieldValue() > bids.last.amount) ? onPressed : null
      )
    );
  }

  Widget _buildSellButton() {
    final ThemeData theme = Theme.of(context);

    final Product product = _product!;

    Future<void> onPressed() async {}

    return SizedBox(
      width: 160.0, height: 64.0,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(theme.colorScheme.error)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Sell', style: theme.textTheme.headline6),

            const SizedBox(height: 8.0),

            Text('< Rs. ${product.initialPrice}')
          ],
        ),
        onPressed: (_getAmountFieldValue() < product.initialPrice) ? onPressed : null
      )
    );
  }

  Widget _buildAmountField() {
    return TextField(
      controller: _amountFieldController,
      decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Amount'),
      onChanged: (text) => setState(() {})
    );
  }

  Future<void> _getBidsFromBackend() async {
    List<Bid> bids = await _bidServices().getBidsForProduct(_product!.id);
    setState(() => _bids = bids);
  }

  double _getAmountFieldValue() {
    if(_amountFieldController.text.isNotEmpty)
      return double.parse(_amountFieldController.text);
    else
      return 0.0;
  }

  BidServices _bidServices() => _client.bidServices();


  Product? _product;
  List<Bid>? _bids;
  
  final Client _client = getIt<Client>();
  final TextEditingController _amountFieldController = TextEditingController();  
}