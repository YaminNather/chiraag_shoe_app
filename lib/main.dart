import 'package:chiraag_shoe_app/app.dart';
import 'package:chiraag_shoe_app/injector.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();  

  runApp(const App());
}