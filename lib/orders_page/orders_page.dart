import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/injector.dart';
import 'package:chiraag_shoe_app/product_page/product_page.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({ Key? key }) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();

    Future<void> asyncPart() async {
      final List<Order> orders = await _orderServices.getOrders();
      
      setState(
        () {
          _orders = orders;
          _isLoading = false;
        }
      );
    }

    asyncPart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: const Text('Orders'));
  }

  Widget _buildBody() {
    if(_isLoading)
      return const Center(child: CircularProgressIndicator());

    final List<Order> orders = _orders!;


    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final Order order = orders[index];
          
          if(order.status == OrderStatus.verifying)
            return _buildVerifyingItem(order);
          else if(order.status == OrderStatus.delivering)
            return _buildDeliveringItem(order);
          else
            return _buildDeliveredItem(order);
        },
        separatorBuilder: (context, index) => const Divider(thickness: 2.0)
      )
    );
  }    

  Widget _buildVerifyingItem(final Order order) {
    return _buildItem(order, status: const Text('Item being verified') );
  }

  Widget _buildDeliveringItem(final Order order) {
    return _buildItem(
      order,
      status: const Text('Item being delivered')
    );
  }

  Widget _buildDeliveredItem(final Order order) {
    return _buildItem(
      order,
      status: const Text('Item delivered')
    );
  }

  Widget _buildItem(final Order order, {required final Widget status}) {
    return ListTile(
      leading: Image(image: NetworkImage(order.product.mainImage)),
      title:  Text(order.product.name),
      subtitle: status,
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (context) => ProductPage(id: order.product.id));
        Navigator.of(context).push(route);
      }
    );
  }



  bool _isLoading = true;
  List<Order>? _orders;

  final OrderServices _orderServices = getIt<Client>().orderServices();
}