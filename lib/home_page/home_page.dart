import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/current_bids_page/current_bids_page.dart';
import 'package:chiraag_shoe_app/your_items_page/your_items_page.dart';
import 'package:chiraag_shoe_app/product_page/product_page.dart';
import 'package:chiraag_shoe_app/product_search_page/product_search_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), drawer: _buildDrawer(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Home'), 
      actions: <Widget>[
        _buildSearchButton()
      ]
    );
  }

  Widget _buildSearchButton() {
    void onPressed() {
      final MaterialPageRoute route = MaterialPageRoute(builder: (context) => const ProductSearchPage());
      Navigator.of(context).push(route);
    }

    return IconButton(icon: const Icon(Icons.search), onPressed: onPressed);
  }

  Widget _buildBody() {
    final ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: <Widget>[
            _buildCategorizedProductList('New Releases', frontendSampleProducts, theme),

            const SizedBox(height: 32.0),

            _buildCategorizedProductList('Popular', frontendSampleProducts, theme),

            const SizedBox(height: 32.0),

            _buildCategorizedProductList('Ongoing', frontendSampleProducts, theme)
          ]
        ),
      ),
    );
  }

  Widget _buildCategorizedProductList(final String category, List<Product> products, final ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(category, style: theme.textTheme.headline4),
        ),

        const SizedBox(height: 16.0),

        SizedBox(
          height: _cardSize,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) => _buildProductCard(products[index], theme),
            separatorBuilder: (context, index) => const SizedBox(width: 8.0)
          ),
        )
      ]
    );
  }

  Widget _buildProductCard(final Product product, final ThemeData theme) {
    return SizedBox(
      width: _cardSize,
      child: Card(
        child: InkWell(
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(builder: (context) => ProductPage(id: product.id));
            Navigator.of(context).push(route);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Center(child: Image(image: NetworkImage(product.mainImage), fit: BoxFit.cover))
                ),

                const SizedBox(height: 8.0),

                Text(product.name),

                const SizedBox(height: 8.0),

                Text('Rs. ${product.price}', style: theme.textTheme.headline6)
              ]
            ),
          ),
        )
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(      
          children: <Widget>[
            ListTile(
              title: const Text('Current Bids'), 
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) => const CurrentBidsPage());
                Navigator.of(context).push(route);
              }
            ),

            ListTile(
              title: const Text('Your Items'),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) => const YourItemsPage());
                Navigator.of(context).push(route);
              }
            )
          ]
        ),
      )
    );
  }

  static const double _cardSize = 256.0;
}


List<Product> frontendSampleProducts = <Product>[
  Product(
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
  ),
  Product(
    id: '1',
    name: 'Puma Insidiator',
    description: 'Amazing shoe',
    categoryId: null,
    price: 3000.0,
    createdAt: DateTime(2022, 1, 21),
    mainImage: 'https://freepngimg.com/thumb/categories/627.png',
    images: <String>[
      'https://freepngimg.com/thumb/categories/627.png'
    ]
  ),
  Product(
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
  ),
  Product(
    id: '1',
    name: 'Puma Insidiator',
    description: 'Amazing shoe',
    categoryId: null,
    price: 3000.0,
    createdAt: DateTime(2022, 1, 21),
    mainImage: 'https://freepngimg.com/thumb/categories/627.png',
    images: <String>[
      'https://freepngimg.com/thumb/categories/627.png'
    ]
  ),
  Product(
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
  ),
  Product(
    id: '1',
    name: 'Puma Insidiator',
    description: 'Amazing shoe',
    categoryId: null,
    price: 3000.0,
    createdAt: DateTime(2022, 1, 21),
    mainImage: 'https://freepngimg.com/thumb/categories/627.png',
    images: <String>[
      'https://freepngimg.com/thumb/categories/627.png'
    ]
  )
];