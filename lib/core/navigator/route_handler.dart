import 'package:rabble/config/export.dart';
import 'package:rabble/feature/web_view/webview.dart';

class RouteHandlers {
  static Handler notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return const NotFoundScreen();
    // return;
  });

  static Handler webScreenHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) {
      return WebView(
        url: parameters['url'][0],
        title: parameters['title'][0],
      );
    },
  );

  static Handler makeHandler(Function creator) =>
      Handler(handlerFunc: (context, parameters) => creator());
}
