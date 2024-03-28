import 'package:rabble/core/config/export.dart';

final GetIt di = GetIt.instance;

void setupInjection() {

  di.registerSingleton<ApiProvider>(ApiProvider());
  di.registerSingleton<AddressRepository>(AddressRepository(di<ApiProvider>()));
  di.registerSingleton<AuthRepository>(AuthRepository(di<ApiProvider>()));

}
