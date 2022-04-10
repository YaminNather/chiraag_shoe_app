import 'package:chiraag_shoe_app/add_product_page/add_product_page.dart';
import 'package:chiraag_shoe_app/widgets/carousel/carousel.dart';
import 'package:flutter/material.dart';
import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/current_bids_page/bids_page.dart';
import 'package:chiraag_shoe_app/orders_page/orders_page.dart';
import 'package:chiraag_shoe_app/your_items_page/your_items_page.dart';
import 'package:chiraag_shoe_app/product_search_page/product_search_page.dart';
import '../widgets/product_card.dart';

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
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size screenSize = mediaQuery.size;

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
          height: screenSize.width - 64.0,
          child: Carousel(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: ProductCard(products[index])
              );
            }
          )
        )
      ]
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
                MaterialPageRoute route = MaterialPageRoute(builder: (context) => const BidsPage());
                Navigator.of(context).push(route);
              }
            ),

            ListTile(
              title: const Text('Orders'),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) => const OrdersPage());
                Navigator.of(context).push(route);
              }
            ),

            ListTile(
              title: const Text('Your Items'),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) => const YourItemsPage());
                Navigator.of(context).push(route);
              }
            ),
            
            ListTile(
              title: const Text('Add Product'),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(builder: (context) => const AddProductPage());
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
    seller: 'Yamin',
    description: 'Crazy shoe',    
    initialPrice: 3000.0,
    createdAt: DateTime(2022, 1, 23),
    mainImage: 'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png',
    images: <String>[
      'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png'
    ],
    isAvailable: true
  ),
  Product(
    id: '1',
    name: 'Puma Insidiator',
    seller: 'Yamin',
    description: 'Amazing shoe',    
    initialPrice: 3000.0,
    createdAt: DateTime(2022, 1, 21),
    mainImage: 'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png',
    images: <String>[
      'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png'
    ],
    isAvailable: true
  ),
  Product(
    id: '0',
    name: 'Nike Radion',
    seller: 'Yamin',
    description: 'Crazy shoe',    
    initialPrice: 3000.0,
    createdAt: DateTime(2022, 1, 23),
    mainImage: 'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png',
    images: <String>[
      'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png'
    ],
    isAvailable: true
  ),
  Product(
    id: '1',
    name: 'Puma Insidiator',
    seller: 'Yamin',
    description: 'Amazing shoe',    
    initialPrice: 3000.0,
    createdAt: DateTime(2022, 1, 21),
    mainImage: 'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png',
    images: <String>[
      'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png'
    ],
    isAvailable: true
  ),
  Product(
    id: '0',
    name: 'Nike Radion',
    seller: 'Yamin',
    description: 'Crazy shoe',    
    initialPrice: 3000.0,
    createdAt: DateTime(2022, 1, 23),
    mainImage: 'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png',
    images: <String>[
      'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png'
    ],
    isAvailable: true
  ),
  Product(
    id: '1',
    name: 'Puma Insidiator',
    seller: 'Yamin',
    description: 'Amazing shoe',    
    initialPrice: 3000.0,
    createdAt: DateTime(2022, 1, 21),
    mainImage: 'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png',
    images: <String>[
      'https://nzjzbovrzkimbccsxptb.supabase.co/storage/v1/object/public/default-bucket/shoe.png'
    ],
    isAvailable: true
  )
];