import 'package:chiraag_shoe_app/choose_bid_page/choose_bid_page.dart';

import 'login_or_authentication_redirector/login_or_authentication_redirector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData defaultTheme = ThemeData.light();

    final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: Colors.green);

    return MaterialApp(
      theme: defaultTheme.copyWith(
        colorScheme: colorScheme,
        textTheme: _getTextTheme(defaultTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent, 
          elevation: 0.0, 
          foregroundColor: colorScheme.onSurface
        ),
        cardTheme: CardTheme(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
            side: BorderSide(width: 1.0, color: colorScheme.onSurface.withOpacity(0.2))
          )
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 8.0)
      ),      
      // home: const LoginPage()
      // home: const LoginOrAuthenticationRedirector()
      home: const ChooseBidPage('0')
    );
  }

  TextTheme _getTextTheme(ThemeData defaultTheme) {
    TextTheme r = GoogleFonts.poppinsTextTheme(defaultTheme.textTheme);
    r = r.copyWith(
      headline1: r.headline1!.copyWith(fontWeight: FontWeight.bold),
      headline2: r.headline2!.copyWith(fontWeight: FontWeight.bold),
      headline3: r.headline3!.copyWith(fontWeight: FontWeight.bold),
      headline4: r.headline4!.copyWith(fontWeight: FontWeight.bold),
      headline5: r.headline5!.copyWith(fontWeight: FontWeight.bold),
      headline6: r.headline6!.copyWith(fontWeight: FontWeight.bold)
    );

    return r;
  }
}