import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:flutter/material.dart';

import '../injector.dart';
import '../product_page/product_page.dart';

class BiddingItemsTabView extends StatefulWidget {
  const BiddingItemsTabView(this.soldItems, { Key? key }) : super(key: key);

  @override
  State<BiddingItemsTabView> createState() => _BiddingItemsTabViewState();


  final List<SoldItem> soldItems;
}

class _BiddingItemsTabViewState extends State<BiddingItemsTabView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: widget.soldItems.length,
      itemBuilder: (context, index) => _buildItem(widget.soldItems[index]),
      separatorBuilder: (context, index) => const Divider(thickness: 2.0)
    );
  }

  Widget _buildItem(final SoldItem item) {
    return ListTile(
      leading: Image(image: NetworkImage(item.product.mainImage)),
      title:  Text(item.product.name),
      subtitle: Text('Highest Bid: ${item.bid!.amount}'),
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (context) => ProductPage(id: item.product.id));
        Navigator.of(context).push(route);
      }
    );
  }
}