import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rabble/core/config/export.dart';

void main() {
  setUp(() {
    Config.initialize(Flavor.DEV, DevConfig());
  });

  testWidgets(kAppFile, (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Test Login View widgets', (WidgetTester tester) async {
    // Build LoginView widget
    await tester.pumpWidget(RabbleTheme(
        data: RabbleTheme.themeData, child: MaterialApp(home: LoginView())));

    // Test if widgets are present on the screen
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(SizedBox), findsWidgets);
    expect(find.byType(Align), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(RabbleText), findsWidgets);
    expect(find.byType(RabbleTextField), findsWidgets);
  });

  testWidgets('Test Login View show country picker',
      (WidgetTester tester) async {
    // Build LoginView widget
    await tester.pumpWidget(RabbleTheme(
        data: RabbleTheme.themeData, child: MaterialApp(home: LoginView())));

    // Tap on the country picker widget
    await tester.tap(find.byIcon(Icons.keyboard_arrow_down_outlined));
    await tester.pumpAndSettle();
  });

  testWidgets('Test Login View phone number input field',
      (WidgetTester tester) async {
    // Build LoginView widget
    await tester.pumpWidget(RabbleTheme(
        data: RabbleTheme.themeData, child: MaterialApp(home: LoginView())));

    // Enter phone number in the input field
    await tester.enterText(find.byType(RabbleTextField), '1234567890');

    // Test if the entered phone number is displayed in the input field
    expect(find.text('1234567890'), findsOneWidget);
  });
}
