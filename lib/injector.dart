import 'package:chiraag_app_backend_client/chiraag_app_backend_client.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase/supabase.dart';

import 'injector.config.dart';


final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(getIt);

@module
abstract class BackendClientModule {
  Client get client => Client();
}