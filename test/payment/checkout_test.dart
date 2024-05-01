import 'package:flutter_test/flutter_test.dart';
import 'package:rabble/core/config/export.dart';

void main() {

  setUp(() {
    Config.initialize(Flavor.DEV, DevConfig());
  });
  group('CheckoutView', () {


    testWidgets(kAppFile, (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MaterialApp), findsOneWidget);
    });


    testWidgets('renders correct UI elements', (WidgetTester tester) async {
      // Build the CheckoutView widget.
      await tester.pumpWidget(
        RabbleTheme(
            data: RabbleTheme.themeData,
            child: const MaterialApp(
              home: CheckoutView(),
            )),
      );

      // Verify that the Appbar widget with the ShareWidget is displayed.
      expect(find.byType(RabbleAppbar), findsOneWidget);
      expect(find.byType(ShareWidget), findsOneWidget);

      // Verify that the CartWidget is displayed.
      expect(find.byType(CartWidget), findsOneWidget);

      // Verify that the total price and checkout button are displayed.
      expect(find.text(kTotalPriceWithVat), findsOneWidget);
      expect(find.text('$kGBP $k320'), findsOneWidget);
      expect(find.widgetWithText(RabbleButton, kCheckout), findsOneWidget);
    });
  });
}
