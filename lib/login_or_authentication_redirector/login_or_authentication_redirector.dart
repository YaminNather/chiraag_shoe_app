import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import '../home_page/home_page.dart';
import '../login_page/login_page.dart';
import 'package:flutter/material.dart';

import '../injector.dart';

class LoginOrAuthenticationRedirector extends StatefulWidget {
  const LoginOrAuthenticationRedirector({Key? key}) : super(key: key);

  @override
  _LoginOrAuthenticationRedirectorState createState() => _LoginOrAuthenticationRedirectorState();
}

class _LoginOrAuthenticationRedirectorState extends State<LoginOrAuthenticationRedirector> {
  @override
  void initState() {    
    super.initState();

    Future<void> asyncPart() async {
      Client client = getIt<Client>();
      String? user = await client.authentication().getCurrentUser();

      final Widget page;
      if(user == null)
        page = const LoginPage();
      else
        page = const HomePage();

      final MaterialPageRoute route = MaterialPageRoute(builder: (context) => page);
      Navigator.of(context).push(route);
    }

    asyncPart();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator.adaptive()));
  }  
}