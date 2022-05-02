import 'package:chiraag_shoe_app/product_page/images_carousel/images_carousel.dart';
import 'package:flutter/material.dart';
import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:marquee/marquee.dart';

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
          _isLoading = false;
        }
      );
    }

    asyncPart();    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: _buildAppBar(), body: _buildBody()));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar();
  }

  Widget _buildBody() {
    final ThemeData theme = Theme.of(context);

    if(_isLoading)
      return const Center( child: CircularProgressIndicator.adaptive() );
    
    final Product product = _product!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ImagesCarousel(product: product),

                const SizedBox(height: 32.0),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                        child: Marquee(
                          text: product.name.toUpperCase(),
                          style: theme.textTheme.headline5,
                          pauseAfterRound: const Duration(milliseconds: 5000)
                        )
                      ),

                      _buildSizeInfo(),

                      const SizedBox(height: 16.0),

                      Text(product.description)
                    ]
                  ),
                ),

                const SizedBox(height: 16.0)
              ]
            )
          )
        ),

        const SizedBox(height: 16.0),

        _buildBottomArea()
      ]
    );
  }  

  Widget _buildSizeInfo() {
    final ThemeData theme = Theme.of(context);

    return RichText(
      text: TextSpan(
        text: 'Size: ',
        style: theme.textTheme.bodyText2,
        children: <TextSpan>[
          TextSpan(text: '10', style: theme.textTheme.headline6)
        ]
      )
    );
  }    

  Widget _buildBottomArea() {
    final ThemeData theme = Theme.of(context);
    
    return Stack(
      children: <Widget>[
        _buildBottomLayerInactiveOverlay(          
          enabled: !_product!.isAvailable,
          child: SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: new BoxDecoration(
                border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(16.0)
              ),
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
          )
        ),

        if(!_product!.isAvailable)
          Positioned.fill(
            child: Center(child: Text('Not available for bidding!!', style: theme.textTheme.headline5))
          )
      ]
    );
  }

  Widget _buildBottomLayerInactiveOverlay({required Widget child, bool enabled = true}) {
    return IgnorePointer(
      ignoring: enabled,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode((enabled) ? Colors.grey.shade700 : Colors.white, BlendMode.multiply),
        child: child
      ),
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
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(theme.colorScheme.primary)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Bid', style: theme.textTheme.headline6!.copyWith(color: theme.colorScheme.onPrimary)),

            const SizedBox(height: 8.0),

            Text('> Rs. ${_getLargestBidAmount()}', style: TextStyle(color: theme.colorScheme.onPrimary))
          ]
        ),
        onPressed: (_getAmountFieldValue() > _getLargestBidAmount()) ? onPressed : null
      )
    );
  }

  Widget _buildSellButton() {
    final ThemeData theme = Theme.of(context);

    final Product product = _product!;

    Future<void> onPressed() async {
      setState(() => _isLoading = true);
      final Product createdProduct = await _inventory().sellBid(_product!.id, _getAmountFieldValue());

      MaterialPageRoute route = MaterialPageRoute(builder: (context) => ProductPage(id: createdProduct.id));
      Navigator.of(context).pushReplacement(route);
      setState(() => _isLoading = false);
    }

    return SizedBox(
      width: 160.0, height: 64.0,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Sell', style: theme.textTheme.headline6!.copyWith(color: theme.colorScheme.onPrimary)),

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
      keyboardType: TextInputType.number,
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

  double _getLargestBidAmount() => (_bids!.isEmpty) ? _product!.initialPrice : _bids!.last.amount;

  BidServices _bidServices() => _client.bidServices();

  Inventory _inventory() => _client.inventory();

  bool _isLoading = true;

  Product? _product;
  List<Bid>? _bids;
  
  final Client _client = getIt<Client>();
  final TextEditingController _amountFieldController = TextEditingController();  
}