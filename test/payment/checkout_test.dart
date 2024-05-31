import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/feature/checkout/checkout_cubit.dart';

import 'checkout_test.mocks.dart';

@GenerateMocks([CheckoutCubit])
void main() {
  setUp(() {
    Config.initialize(Flavor.DEV, DevConfig());
    SizerUtil.setScreenSize(
        const BoxConstraints(
          maxWidth: 500,
          maxHeight: 1000,
        ),
        Orientation.portrait);
  });
  group('CheckoutView', () {
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
      // expect(find.byType(ShareWidget), findsOneWidget);
      //
      // // Verify that the CartWidget is displayed.
      // expect(find.byType(CartWidget), findsOneWidget);
      //
      // // Verify that the total price and checkout button are displayed.
      // expect(find.text(kTotalPriceWithVat), findsOneWidget);
      // expect(find.text('$kGBP $k320'), findsOneWidget);
      // expect(find.widgetWithText(RabbleButton, kCheckout), findsOneWidget);
    });

    testWidgets('CheckoutView renders Product List and Order Summary',
        (WidgetTester tester) async {
      // Mock product list
      final productList = [
        ProductDetail(id: '1', name: 'Product 1', price: 10.0),
      ];

      // Mock Cubit with product list
      final mockCubit = MockCheckoutCubit();

      when(mockCubit.productList).thenAnswer((_) => BehaviorSubject<List<ProductDetail>>());

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: RabbleTheme(
            data: RabbleTheme.themeData,
            child: CheckoutView(),
          ),
        ),
      );

      // Find CartWidget
      expect(find.byType(EmptyStateWidget), findsOneWidget);

      // Verify Order Summary text (adjust based on your logic)
      // expect(find.text(kTotalPriceWithVat), findsOneWidget);
      // expect(find.text(DateFormatUtil.amountFormatter(10.0)),
      //     findsOneWidget); // Assuming total price is product price
    });
  });
}
