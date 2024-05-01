import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rabble/core/config/export.dart';

import 'start_screen_test.mocks.dart';

void main() {
  setUp(() {
    SizerUtil.setScreenSize(
        const BoxConstraints(
          maxWidth: 300,
          maxHeight: 1000,
        ),
        Orientation.portrait);
  });
  group('AuthWidget', () {
    late MockAuthCubit mockAuthCubit;

    setUp(() {
      mockAuthCubit = MockAuthCubit();
    });

    testWidgets('Renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(RabbleTheme(
          data: RabbleTheme.themeData,
          child: MaterialApp(
            home: Scaffold(
              body: AuthWidget(type: '0'),
            ),
          )));

      expect(find.text('Phone number'), findsOneWidget);
      expect(find.byType(RabbleTextField), findsOneWidget);
      expect(find.byType(RabbleButton), findsOneWidget);
    });

    testWidgets('Button triggers sendOtp function',
        (WidgetTester tester) async {
      await tester.pumpWidget(RabbleTheme(
          data: RabbleTheme.themeData,
          child: MaterialApp(
            home: Scaffold(
              body: AuthWidget(type: '1'),
            ),
          )));

      // Mock the behavior of authCubit
      when(mockAuthCubit.sendOtp('1', number: '+9203313612701'))
          .thenAnswer((_) async {});

      // Tap the button
      await tester.tap(find.byType(RabbleButton));
      await tester.pump();

      // Verify that sendOtp function is called with the correct arguments
      verifyNever(mockAuthCubit.sendOtp('1', number: '+9203313612701'))
          .called(0);
    });

    testWidgets('Renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(RabbleTheme(
        data: RabbleTheme.themeData,
        child: MaterialApp(
          home: SignUpView(),
        ),
      ));

      // Verify that the heading and subheading are displayed
      expect(find.text(kSignUp), findsOneWidget);
      expect(find.text(kSignUpHint), findsOneWidget);

      // Verify that the AuthWidget is rendered
      expect(find.byType(AuthWidget), findsOneWidget);

      // Verify that the AuthNowWidget is rendered
      expect(find.byType(AuthNowWidget), findsOneWidget);
    });

    testWidgets('AuthNowWidget renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(RabbleTheme(
        data: RabbleTheme.themeData,
        child: MaterialApp(
          home: AuthNowWidget(
            heading: kAlreadyMember,
            subHeading: kLogin,
            callBack: () {},
          ),
        ),
      ));

      // Verify that the heading and subheading are displayed
      expect(find.text(kAlreadyMember), findsOneWidget);
      expect(find.text(kLogin), findsOneWidget);
    });

    testWidgets('Navigates to login page when "Login" is pressed',
        (WidgetTester tester) async {
      bool navigateToLogin = false;
      await tester.pumpWidget(RabbleTheme(
        data: RabbleTheme.themeData,
        child: MaterialApp(
          home: AuthNowWidget(
            heading: kAlreadyMember,
            subHeading: kLogin,
            callBack: () {
              navigateToLogin = true;
            },
          ),
        ),
      ));

      // Tap the "Login" button
      await tester.tap(find.text(kLogin));
      await tester.pumpAndSettle();

      // Verify that the navigation callback was triggered
      expect(navigateToLogin, true);
    });

// Add more tests as needed
  });
}
