import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/feature/payment/add_card_view.dart';

void main() {
  setUpAll(() {
    Config.initialize(Flavor.DEV, DevConfig());
    SizerUtil.setScreenSize(
        const BoxConstraints(
          maxWidth: 500,
          maxHeight: 1000,
        ),
        Orientation.portrait);
  });
  group('EditPaymentView widget', () {
    testWidgets('should contain 2 text fields for card number and holder name',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        RabbleTheme(
            data: RabbleTheme.themeData,
            child: MaterialApp(
              home: AddNewCardView(),
            )),
      );

      final cardNumberField = find.widgetWithText(RabbleTextField, k44444);

      expect(cardNumberField, findsOneWidget);
    });

    testWidgets('should contain 2 text fields for MM/YY and CVV',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        RabbleTheme(
            data: RabbleTheme.themeData,
            child: MaterialApp(
              home: AddNewCardView(),
            )),
      );

      final mmYYField = find.widgetWithText(RabbleTextField, kExpiryDate);
      final cvvField = find.widgetWithText(RabbleTextField, kCVVStar);

      expect(mmYYField, findsOneWidget);
      expect(cvvField, findsOneWidget);
    });

    testWidgets('should contain a save button', (WidgetTester tester) async {
      await tester.pumpWidget(
        RabbleTheme(
            data: RabbleTheme.themeData,
            child: MaterialApp(
              home: AddNewCardView(),
            )),
      );

      final saveButton = find.widgetWithText(RabbleButton, kAddNewCard);

      expect(saveButton, findsOneWidget);
    });
  });
}
