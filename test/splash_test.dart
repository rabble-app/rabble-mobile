import 'package:flutter_test/flutter_test.dart';
import 'package:rabble/config/export.dart';

void main() {
  setUp(() {
    Config.initialize(Flavor.DEV, DevConfig());
  });

  testWidgets(kAppFile, (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  testWidgets('RabbleText subHeaderText renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(RabbleTheme(
        data: RabbleTheme.themeData,
        child: MaterialApp(
          home: RabbleText.subHeaderText(
            text: 'R',
            fontSize: 200.sp,
            fontWeight: FontWeight.bold,
            color: APPColors.appPrimaryColor,
          ),
        )));

    final rabbleTextFinder = find.byType(RabbleText);
    final textFinder = find.text('R');

    expect(rabbleTextFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('RabbleSecondaryScreenProgressIndicator renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(RabbleTheme(
        data: RabbleTheme.themeData,
        child: const MaterialApp(
          home: RabbleSecondaryScreenProgressIndicator(
            enabled: true,
          ),
        )));

    final progressIndicatorFinder = find.byType(CircularProgressIndicator);

    expect(progressIndicatorFinder, findsOneWidget);
  });
}
