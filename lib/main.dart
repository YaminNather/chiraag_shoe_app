import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:chiraag_shoe_app/app.dart';
import 'package:chiraag_shoe_app/injector.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Client.initialize();  
  configureDependencies();

  runApp(const App());
}