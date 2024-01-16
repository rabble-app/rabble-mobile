import 'package:flutter_test/flutter_test.dart';
import 'package:rabble/config/export.dart';

void main() {
  setUpAll(() {
    Config.initialize(Flavor.DEV, DevConfig());
  });
  group('EditPaymentView widget', () {
    testWidgets(kAppFile, (WidgetTester tester) async {
      // Build the splash screen widget.
      await tester.pumpWidget(const App());

      // Verify that the app is built successfully.
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('MyRabbleAccountView should display recently viewed products',
        (WidgetTester tester) async {
      await tester.pumpWidget(RabbleTheme(
          data: RabbleTheme.themeData,
          child: const MaterialApp(
            home: MyRabbleAccountView(),
          )));

      // Find the widget that displays the recently viewed products heading
      final headingWidget = find.text('Recently Viewed');

      // Expect the heading widget to be displayed
      expect(headingWidget, findsOneWidget);

      // Find the widget that displays the recently viewed products
      final productsWidget = find.byType(ProductWidget);

      // Expect the products widget to be displayed
      expect(productsWidget, findsOneWidget);
    });
  });
}
