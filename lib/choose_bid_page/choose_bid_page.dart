import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/choose_bid_page/final_acceptance_dialog.dart';
import 'package:chiraag_shoe_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

import '../injector.dart';

class ChooseBidPage extends StatefulWidget {
  const ChooseBidPage(this.product, { Key? key }) : super(key: key);

  @override
  State<ChooseBidPage> createState() => _ChooseBidPageState();


  final String product;
}

class _ChooseBidPageState extends State<ChooseBidPage> {
  @override
  void initState() {
    super.initState();

    Future<void>(
      () async {
        final Product? product = (await _inventory.getProduct(widget.product))!;
        final List<Bid>? bid = (await _bidServices.getBidsForProduct(widget.product));
        setState(
          () {
            _product = product;
            _bids = bid;
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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: const Text('Choose Bid'));
  }

  Widget _buildBody() {
    if(_isLoading)
      return const LoadingIndicator();

    final List<Bid> bids = _bids!;

    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => _buildListTile(bids[index])
    );
  }

  Widget _buildListTile(final Bid bid) {
    return ListTile(
      title: Text('Rs.${bid.amount}'),
      subtitle: Text(bid.bidder),
      onTap: () async {
        bool? accepted = await showDialog(context: context, builder: (context) => const FinalAcceptanceDialog());
        if(accepted == null)
          return;
      }
    );
  }


  bool _isLoading = true;
  Product? _product;
  List<Bid>? _bids;


  final Inventory _inventory = getIt<Client>().inventory();
  final BidServices _bidServices = getIt<Client>().bidServices();
}