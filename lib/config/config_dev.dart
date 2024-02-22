import 'export.dart';

class DevConfig {
  static const String stagingUrl =
      "https://api.dev.rabble.market";
  static const String productionUrl = "https://api.rabble.market";

  final SERVER_URL = kDebugMode ? stagingUrl : productionUrl;
//  final SERVER_URL = stagingUrl;
  final API_SUFFIX = '';
}

