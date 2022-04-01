import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/product_page/product_page.dart';
import 'package:flutter/material.dart';

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
                  child: TextField(
                    controller: _searchFieldController,
                    decoration: const InputDecoration(hintText: 'Search'),
                    onChanged: (value) => _updateSearch()
                  ),
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

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5,
      itemBuilder: (context, index) => _buildProductListTile(product),
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
    description: 'Crazy shoe',
    categoryId: null,
    price: 3000.0,
    createdAt: DateTime(2022, 1, 23),
    mainImage: 'https://freepngimg.com/thumb/categories/627.png',
    images: <String>[
      'https://freepngimg.com/thumb/categories/627.png'
    ]
  );
}