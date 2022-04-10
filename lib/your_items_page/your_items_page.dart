import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/your_items_page/bidding_items_tab_view.dart';
import 'package:flutter/material.dart';

import '../injector.dart';
import 'accepted_items_tab_view.dart';
import 'added_items_tab_view.dart';

class YourItemsPage extends StatefulWidget {
  const YourItemsPage({ Key? key }) : super(key: key);

  @override
  State<YourItemsPage> createState() => _YourItemsPageState();
}

class _YourItemsPageState extends State<YourItemsPage> {
   @override
  void initState() {    
    super.initState();

    Future<void> asyncPart() async {
      final List<SoldItem> soldItems = await _inventory.getAllSellersProducts();

      setState(
        () {
          _isLoading = false;
          _soldItems = soldItems;
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
    return AppBar(title: const Text('Your Items'));
  }

  Widget _buildBody() {
    final ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          TabBar(
            labelColor: theme.textTheme.bodyText1!.color,
            tabs: const <Tab>[
              Tab(text: 'Added'),
              
              Tab(text: 'Bidding'),
              
              Tab(text: 'Accepted')
            ]
          ),

          Expanded(
            child: _buildTabBarView()
          )
        ]
      )
    );
  }

  Widget _buildTabBarView() {
    if(_isLoading)
      return const Center(child: CircularProgressIndicator());

    return TabBarView(
      children: <Widget>[              
        _buildAddedItemsTabView(),

        _buildBiddingItemsTabView(),

        _buildAcceptedItemsTabView()
      ]
    );
  }

  Widget _buildAddedItemsTabView() {
    List<SoldItem> addedItems = List<SoldItem>.from(_soldItems!);
    addedItems.removeWhere((element) => element.bid != null || element.order != null);
    
    return AddedItemsTabView(addedItems);
  }
  
  Widget _buildBiddingItemsTabView() {
    List<SoldItem> biddingItems = List<SoldItem>.from(_soldItems!);
    biddingItems.removeWhere((element) => !(element.bid != null && element.order == null));
    
    return BiddingItemsTabView(biddingItems);
  }
  
  Widget _buildAcceptedItemsTabView() {
    List<SoldItem> acceptedItems = List<SoldItem>.from(_soldItems!);
    acceptedItems.removeWhere((element) => !(element.bid == null && element.order != null));
    
    return AcceptedItemsTabView(acceptedItems);
  }



  bool _isLoading = true;
  List<SoldItem>? _soldItems;
  final Inventory _inventory = getIt<Client>().inventory();
}