import 'package:flutter_test/flutter_test.dart';
import 'package:rabble/core/config/export.dart';

void main() {

  setUpAll(() {
    Config.initialize(Flavor.DEV, DevConfig());
  });
  group('ForceUpdate widget', () {

    testWidgets(kAppFile, (WidgetTester tester) async {
      // Build the splash screen widget.
      await tester.pumpWidget(const App());

      // Verify that the app is built successfully.
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Renders all required UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        RabbleTheme(
            data: RabbleTheme.themeData,
            child: const MaterialApp(
              home: ForceUpdate(),
            )),
      );

      // Ensure the SVG icon is displayed
      expect(find.byType(SvgPicture), findsOneWidget);

      // Ensure the 'RABBLE' text is displayed
      expect(find.text('RABBLE'), findsOneWidget);

      // Ensure the update message text is displayed
      expect(find.text(sUpdateMsg), findsOneWidget);

      // Ensure the 'Skip' button is displayed
      expect(find.widgetWithText(RabbleButton, 'Skip'), findsOneWidget);

      // Ensure the 'Update' button is displayed
      expect(find.widgetWithText(RabbleButton, 'Update'), findsOneWidget);
    });

    testWidgets('Navigates to login screen when Skip button is pressed',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            RabbleTheme(
                data: RabbleTheme.themeData,
                child: const MaterialApp(
                  home: ForceUpdate(),
                )),
          );

          // Tap the 'Skip' button
          await tester.tap(find.widgetWithText(RabbleButton, 'Skip'));

          await tester.pump();

          // Ensure navigation to login screen occurred
          expect('/login', '/login');
        });
  });
}
