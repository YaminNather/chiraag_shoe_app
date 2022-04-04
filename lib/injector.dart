import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';


final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(getIt);

@module
abstract class BackendClientModule {
  Client get client => _client;


  final Client _client = Client();
}