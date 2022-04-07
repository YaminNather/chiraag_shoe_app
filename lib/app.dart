import 'package:chiraag_shoe_app/login_page/login_page.dart';

import 'login_or_authentication_redirector/login_or_authentication_redirector.dart';
import 'package:chiraag_shoe_app/product_page/product_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'products_page/products_page.dart';

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData defaultTheme = ThemeData.dark();

    return MaterialApp(
      theme: defaultTheme.copyWith(
        colorScheme: defaultTheme.colorScheme.copyWith(
          primary: const Color(0xFF98c642)
        ),
        scaffoldBackgroundColor: const Color(0xFF232323),
        textTheme: GoogleFonts.poppinsTextTheme(defaultTheme.textTheme).apply(displayColor: Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          foregroundColor: Colors.white
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          // color: const Color(0xFF222222)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
            )
          )
        )
      ),
      routes: <String, Widget Function(BuildContext)>{
        'ProductPage': (context) => const ProductPage(id: "0"),
        'ProductsPage': (context) => const ProductsPage()
      },
      // home: const LoginPage()
      home: const LoginOrAuthenticationRedirector()
    );
  }
}