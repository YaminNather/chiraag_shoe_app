import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/checkout_page/enter_delivery_details_page.dart';

import 'checkout_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(this.order, { Key? key }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();


  final Order order;
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckoutPageController>(
      create: (context) => CheckoutPageController(widget.order, context: context),
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) => const EnterDeliveryDetailsPage());
        },
        initialRoute: 'Enter Address Page'
      )
    );
  }
}