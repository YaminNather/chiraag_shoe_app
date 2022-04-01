import 'package:flutter/material.dart';

import '../product_page/product_page.dart';

class YourItemsPage extends StatefulWidget {
  const YourItemsPage({ Key? key }) : super(key: key);

  @override
  State<YourItemsPage> createState() => _YourItemsPageState();
}

class _YourItemsPageState extends State<YourItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: const Text('Your Items'));
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: 6,
        itemBuilder: (context, index) {
          final int remainder = index % 3;
          
          if(remainder == 0)
            return _buildOngoingBidItem();
          else if(remainder == 1)
            return _buildAcceptedBidItem();
          else
            return _buildDeclinedBidItem();
        },
        separatorBuilder: (context, index) => const Divider(thickness: 2.0)
      )
    );
  }

  Widget _buildItem({required final Widget bidStatus}) {
    return ListTile(
      leading: const Image(image: NetworkImage('https://freepngimg.com/thumb/categories/627.png')),
      title:  const Text('Nike Shoe'),
      subtitle: bidStatus,
      onTap: () {
        final MaterialPageRoute route = MaterialPageRoute(builder: (context) => const ProductPage(id: '0'));
        Navigator.of(context).push(route);
      }
    );
  }

  Widget _buildOngoingBidItem() {
    final ThemeData theme = Theme.of(context);

    return _buildItem(
      bidStatus: RichText(
        text: TextSpan(
          text: 'Highest Bid: ', 
          children: <TextSpan>[
            TextSpan(text: 'Rs 32,000', style: theme.textTheme.headline6!.copyWith(color: Colors.green))
          ]
        )
      )
    );
  }

  Widget _buildDeclinedBidItem() {
    final ThemeData theme = Theme.of(context);

    return _buildItem( bidStatus: Text('Bid declined', style: TextStyle(color: theme.colorScheme.error)) );
  }

  Widget _buildAcceptedBidItem() {
    final ThemeData theme = Theme.of(context);

    return _buildItem(
      bidStatus: Text('Bid accepted: Delivered', style: TextStyle(color: theme.colorScheme.primary))
    );
  }
}