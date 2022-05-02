import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/injector.dart';
import 'package:chiraag_shoe_app/product_page/images_carousel/images_carousel.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../widgets/loading_indicator.dart';
import 'order_progress_stepper.dart';

class OrderPage extends StatefulWidget {
  const OrderPage(this.product, { Key? key }) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();


  final String product;
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();

    Future<void>(
      () async {
        final Order order = await _orderServices.getOrderForProduct(widget.product);

        setState(
          () {
            _order = order;
            _isLoading = false;
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() => AppBar(title: const Text('Order Details'));

  Widget _buildBody() {
    final ThemeData theme = Theme.of(context);

    if(_isLoading)
      return const LoadingIndicator();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 256.0, 
          child: ImagesCarousel(product: _order.product)
        ),
        
        const SizedBox(height: 32.0),

        SizedBox(
          height: 40.0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Marquee(
                text: _order.product.name.toUpperCase(),
                style: theme.textTheme.headline5,
                pauseAfterRound: const Duration(milliseconds: 5000),
                blankSpace: constraints.maxWidth,
                velocity: 200.0,
                startPadding: 16.0,
              );
            }
          ),
        ),

        const SizedBox(height: 16.0),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Order Progress', style: theme.textTheme.headline6),

                Expanded(child: OrderProgressStepper(_order)),
              ],
            ),
          ),
        )
      ]
    );
  }


  bool _isLoading = true;  

  late final Order _order;

  final OrderServices _orderServices = getIt<Client>().orderServices();
}