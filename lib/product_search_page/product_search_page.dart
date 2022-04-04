import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/product_page/product_page.dart';
import 'package:flutter/material.dart';

import '../widgets/product_card.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({ Key? key }) : super(key: key);

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildBody()));
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),

                const SizedBox(width: 16.0),

                Expanded(
                  child: _buildSearchField()
                )
              ]
            )
          ),

          Expanded(
            child: _buildSearchResults()
          )
        ]
      )
    );
  }

  Widget _buildSearchResults() {
    if(_isLoading)
      return const Center(child: CircularProgressIndicator.adaptive());

    final MediaQueryData mediaQuery = MediaQuery.of(context);

    const double padding = 32.0;

    return ListView.separated(
      padding: const EdgeInsets.all(padding),
      itemCount: 5,
      itemBuilder: (context, index) {
        return SizedBox(
          height: mediaQuery.size.width - padding * 2.0,
          child: ProductCard(product)
        );
      },
      separatorBuilder: (context, index) => const Divider(thickness: 2.0)
    );
  }

  Widget _buildProductListTile(final Product product) {
    void onTap() {
      final MaterialPageRoute route = MaterialPageRoute(builder: (context) => const ProductPage(id: '0'));
      Navigator.of(context).push(route);
    }

    return ListTile(
      leading: Image(image: NetworkImage(product.mainImage)),
      title: Text(product.name),
      onTap: onTap
    );
  }

  Widget _buildSearchField() {
    return TextField(    
      controller: _searchFieldController,
      decoration: const InputDecoration(
        hintText: 'Search', 
        suffixIcon: Icon(Icons.search)
      ),
      onChanged: (value) => _updateSearch()
    );
  }

  Future<void> _updateSearch() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() => _isLoading = false);
  }  



  bool _isLoading = false;
  final TextEditingController _searchFieldController = TextEditingController();

  static Product product = Product(
    id: '0',
    name: 'Nike Radion',
    seller: 'Yamin',
    description: 'Crazy shoe',    
    initialPrice: 3000.0,
    createdAt: DateTime(2022, 1, 23),
    mainImage: 'https://freepngimg.com/thumb/categories/627.png',
    images: <String>[
      'https://freepngimg.com/thumb/categories/627.png'
    ],
    isAvailable: true
  );
}