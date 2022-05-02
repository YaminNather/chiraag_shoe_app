import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/order_page/order_page.dart';
import 'complete_checkout.dart';
import 'package:flutter/material.dart';

class CheckoutPageController extends ChangeNotifier {
  CheckoutPageController(this.order, {required this.context});

  void goBack() {
    Navigator.of(context).pop();
  }

  void setDeliveryDetails(final Address address, final String contactNumber) {
    _address = address;
    _contactNumber = contactNumber;
    notifyListeners();
  }

  Future<void> confirmButtonOnClicked(final BuildContext pageContext) async {
    final CompleteCheckout completeCheckout = new CompleteCheckout(order, address!, contactNumber!);
    try {
      await completeCheckout.completeCheckout();
    }
    on Exception catch(e) {
      print('Checkout Failed - $e');

      final ThemeData theme = Theme.of(pageContext);
      SnackBar snackBar = SnackBar(
        content: Text(
          'Checkout Failed!', 
          style: TextStyle(color: theme.colorScheme.error)
        )
      );
      ScaffoldMessenger.of(pageContext).showSnackBar(snackBar);
      return;
    }

    final MaterialPageRoute route = MaterialPageRoute(builder: (context) => OrderPage(order.product.id));
    Navigator.of(context).pushReplacement(route);
  }

  Address? get address => _address;

  String? get contactNumber => _contactNumber;


  Address? _address;
  String? _contactNumber;


  final Order order;

  final BuildContext context;
}