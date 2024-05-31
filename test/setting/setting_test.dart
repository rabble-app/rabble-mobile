import 'package:flutter_test/flutter_test.dart';
import 'package:rabble/core/config/export.dart';

void main() {
  setUpAll(() {
    Config.initialize(Flavor.DEV, DevConfig());
  });
  group('Setting widget', () {
    testWidgets(kAppFile, (WidgetTester tester) async {
      // Build the splash screen widget.
      await tester.pumpWidget(const App());

      // Verify that the app is built successfully.
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('SettingView should build without any errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(RabbleTheme(
          data: RabbleTheme.themeData,
          child: const MaterialApp(
            home: SettingView(),
          )));

      expect(find.byType(SettingView), findsOneWidget);
    });

    testWidgets('SettingView should contain a RabbleAppbar with the correct title', (WidgetTester tester) async {
      await tester.pumpWidget(RabbleTheme(
          data: RabbleTheme.themeData,
          child: const MaterialApp(
            home: SettingView(),
          )));

      expect(find.text(kSetting), findsOneWidget);
    });


    testWidgets('SettingView should contain a list of options', (WidgetTester tester) async {
      await tester.pumpWidget(RabbleTheme(
          data: RabbleTheme.themeData,
          child: const MaterialApp(
            home: SettingView(),
          )));

      expect(find.text(kContactUsFeedback), findsOneWidget);
      expect(find.text(kFAQs), findsOneWidget);
      expect(find.text(kRateRabble), findsOneWidget);
      expect(find.text(kUpdateRABBLE), findsOneWidget);
      expect(find.text(kTermsofUse), findsOneWidget);
      expect(find.text(kPrivacyPolicy), findsOneWidget);
    });



  });
}
