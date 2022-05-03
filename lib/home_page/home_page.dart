import 'package:chiraag_shoe_app/add_product_page/add_product_page.dart';
import 'package:chiraag_shoe_app/product_page/product_page.dart';
import 'package:chiraag_shoe_app/widgets/carousel/carousel.dart';
import 'package:chiraag_shoe_app/widgets/carousel/carousel_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/current_bids_page/bids_page.dart';
import 'package:chiraag_shoe_app/orders_page/orders_page.dart';
import 'package:chiraag_shoe_app/your_items_page/your_items_page.dart';
import 'package:chiraag_shoe_app/product_search_page/product_search_page.dart';
import '../injector.dart';
import '../widgets/carousel/carousel_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/compact_product_card/compact_product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future<void> asyncPart() async {
      final List<Future<dynamic>> getTasks = <Future<dynamic>>[
        _inventory.getLatestArrivals(),
        _bidServices.getBidsOfUser()
      ];
      final List<dynamic> tasksResults = await Future.wait(getTasks);    

      setState(
        () {
          _latestArrivals = tasksResults[0];
          _bids = tasksResults[1];
          _isLoading = false;
        }
      );
    }

    asyncPart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), drawer: _buildDrawer(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: const Text('Home'));
  }

  Widget _buildSearchButton() {
    void onPressed() {
      final MaterialPageRoute route = MaterialPageRoute(builder: (context) => const ProductSearchPage());
      Navigator.of(context).push(route);
    }

    return IconButton(icon: const Icon(Icons.search), onPressed: onPressed);
  }

  Widget _buildBody() {
    if(_isLoading)
      return const Center(child: CircularProgressIndicator());

    final List<Product> latestArrivals = _latestArrivals!;
    final List<BidWithProduct> bids = _bids!;

    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size screenSize = mediaQuery.size;    

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Text('Discover', style: theme.textTheme.headline4),
            // ),

            // const SizedBox(height: 32.0),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Latest Arrivals', style: theme.textTheme.headline6),
            ),
            
            const SizedBox(height: 16.0),

            SizedBox(
              height: screenSize.width - 64.0,
              child: Carousel.builder(
                controller: _latestArrivalsCarouselController,
                itemCount: latestArrivals.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ProductCard(latestArrivals[index])
                  );
                }
              )
            ),

            const SizedBox(height: 8.0),

            Center(
              child: CarouselPageIndicator(
                controller: _latestArrivalsCarouselController,
                pagesCount: latestArrivals.length
              ),
            ),

            const SizedBox(height: 32.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Current Bids', style: theme.textTheme.headline6),

                  TextButton(
                    child: const Text('Show all'), 
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(builder: (context) => const BidsPage());
                      Navigator.of(context).push(route);
                    }
                  )
                ]
              )
            ),

            // const SizedBox(height: 16.0),

            SizedBox(
              height: 272.0,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: bids.length,
                itemBuilder: (context, index) {
                  final Product product = bids[index].product;

                  return SizedBox(
                    width: screenSize.width / 2,
                    child: CompactProductCard(
                      product,
                      onTap: () {
                        final Widget page = ProductPage(id: product.id);
                        final MaterialPageRoute route = MaterialPageRoute(builder: (context) => page);
                        Navigator.of(context).push(route);
                      }
                    )
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 4.0)
              )
            )
          ]
        )
      )
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


  bool _isLoading = true;
  List<Product>? _latestArrivals;
  List<BidWithProduct>? _bids;

  final Inventory _inventory = getIt<Client>().inventory();
  final BidServices _bidServices = getIt<Client>().bidServices();

  final CarouselController _latestArrivalsCarouselController = CarouselController();
}


List<Product> frontendSampleProducts = <Product>[
  Product(
    id: '0',
    name: 'Nike Air Vapor Max 2020 FK',
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