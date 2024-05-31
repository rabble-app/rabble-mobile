import 'package:flutter_test/flutter_test.dart';
import 'package:rabble/core/config/export.dart';

// Mock necessary dependencies

void main() {
  setUp(() {
    SizerUtil.setScreenSize(
        const BoxConstraints(
          maxWidth: 300,
          maxHeight: 1000,
        ),
        Orientation.portrait);
  });
  testWidgets('LoginView displays UI elements correctly',
      (WidgetTester tester) async {
    // Build the LoginView widget
    await tester.pumpWidget(
      RabbleTheme(
          data: RabbleTheme.themeData,
          child: MaterialApp(
            home: LoginView(),
          )),
    );

    // Verify that AuthUpperWidget is rendered with the correct properties
    expect(find.text(kLoginToRabble), findsOneWidget);
    expect(find.text(kLoginHint), findsOneWidget);
    // Verify that AuthWidget is rendered
    expect(find.byType(AuthWidget), findsOneWidget);
    // Verify that AuthNowWidget is rendered with the correct properties
    expect(find.text(kNewToRabble), findsOneWidget);
    expect(find.text(kRegisterNow), findsOneWidget);


    // Verify that navigation occurs when AuthNowWidget is tapped
    await tester.tap(find.text(kRegisterNow));
    await tester.pumpAndSettle(); // Wait for navigation to complete

  });
}
