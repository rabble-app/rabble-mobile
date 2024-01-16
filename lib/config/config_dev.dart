import 'export.dart';

class DevConfig {
  static const String stagingUrl =
      "https://rabble-dev-9986f7458157.herokuapp.com";
  static const String productionUrl = "https://rabble.herokuapp.com";

  final SERVER_URL = kDebugMode ? stagingUrl : productionUrl;
 // final SERVER_URL = 'https://rabble-dev-9986f7458157.herokuapp.com';
  final API_SUFFIX = '';
}

