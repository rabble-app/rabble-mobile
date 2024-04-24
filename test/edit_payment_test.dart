import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rabble/core/config/export.dart';

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

    testWidgets('should contain 2 text fields for card number and holder name', (WidgetTester tester) async {
      await tester.pumpWidget(
        RabbleTheme(
            data: RabbleTheme.themeData,
            child: const MaterialApp(
              home: EditPaymentView(),
            )),
      );

      final cardNumberField = find.widgetWithText(RabbleTextField, kCardNumber);
      final cardHolderNameField = find.widgetWithText(RabbleTextField, kCardHolderName);

      expect(cardNumberField, findsOneWidget);
      expect(cardHolderNameField, findsOneWidget);
    });

    testWidgets('should contain 2 text fields for MM/YY and CVV', (WidgetTester tester) async {
      await tester.pumpWidget(
        RabbleTheme(
            data: RabbleTheme.themeData,
            child: const MaterialApp(
              home: EditPaymentView(),
            )),
      );

      final mmYYField = find.widgetWithText(RabbleTextField, kMMYY);
      final cvvField = find.widgetWithText(RabbleTextField, kCVV);

      expect(mmYYField, findsOneWidget);
      expect(cvvField, findsOneWidget);
    });

    testWidgets('should contain 3 text fields for address information', (WidgetTester tester) async {
      await tester.pumpWidget(
        RabbleTheme(
            data: RabbleTheme.themeData,
            child: const MaterialApp(
              home: EditPaymentView(),
            )),
      );

      final postCodeField = find.widgetWithText(RabbleTextField, kPostCode);
      final buildingNumberField = find.widgetWithText(RabbleTextField, kBuildingNumber);
      final addressLineField = find.widgetWithText(RabbleTextField, kAddressLine);

      expect(postCodeField, findsOneWidget);
      expect(buildingNumberField, findsOneWidget);
      expect(addressLineField, findsOneWidget);
    });

    testWidgets('should contain a header text for card update and billing address', (WidgetTester tester) async {
      await tester.pumpWidget(
        RabbleTheme(
            data: RabbleTheme.themeData,
            child: const MaterialApp(
              home: EditPaymentView(),
            )),
      );

      final cardUpdateHeader = find.widgetWithText(RabbleText, kUpdateYourCreditCard);
      final billingAddressHeader = find.widgetWithText(RabbleText, kBillingAddress);

      expect(cardUpdateHeader, findsOneWidget);
      expect(billingAddressHeader, findsOneWidget);
    });

    testWidgets('should contain a save button', (WidgetTester tester) async {
      await tester.pumpWidget(
        RabbleTheme(
            data: RabbleTheme.themeData,
            child: const MaterialApp(
              home: EditPaymentView(),
            )),
      );

      final saveButton = find.widgetWithText(RabbleButton, 'Save');

      expect(saveButton, findsOneWidget);
    });
  });
}
