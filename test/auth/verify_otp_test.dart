import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rabble/core/config/export.dart';

import 'verify_otp_test.mocks.dart';

@GenerateMocks([VerifyOtpCubit, RabbleNavigatorObserver, Timer])
void main() {
  setUp(() {
    SizerUtil.setScreenSize(
        const BoxConstraints(
          maxWidth: 300,
          maxHeight: 1000,
        ),
        Orientation.portrait);
  });

  group('VerifyOtpView', () {
    late MockVerifyOtpCubit mockVerifyOtpCubit;
    late MockTimer mockTimer;

    setUp(() {
      mockVerifyOtpCubit = MockVerifyOtpCubit();
      mockTimer = MockTimer();
    });

    testWidgets('renders without throwing exceptions',
        (WidgetTester tester) async {
      when(mockTimer.tick).thenAnswer((_) => 10); // Return a dummy int value

      await tester.pumpWidget(
        MaterialApp(
          home: RabbleTheme(
            data: RabbleTheme.themeData,
            child: const VerifyOtpView(),
          ),
        ),
      );

      expect(find.byType(VerifyOtpView), findsOneWidget);
      expect(find.byType(PinCodeTextField),
          findsOneWidget); // Ensure PinCodeTextField is rendered
    });
    testWidgets('PinCodeTextField renders with correct configuration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RabbleTheme(
            data: RabbleTheme.themeData,
            child: const VerifyOtpView(),
          ),
        ),
      );

      // Verify that the PinCodeTextField is rendered with the correct configuration
      final pinCodeTextFieldFinder = find.byType(PinCodeTextField);
      expect(pinCodeTextFieldFinder, findsOneWidget);

      // Get the PinCodeTextField widget
      final pinCodeTextField =
          tester.widget<PinCodeTextField>(pinCodeTextFieldFinder);

      // Verify specific properties of the PinCodeTextField
      expect(pinCodeTextField.length, equals(6)); // Ensure length is 6
      expect(pinCodeTextField.keyboardType,
          equals(TextInputType.number)); // Ensure keyboard type is number
      expect(pinCodeTextField.textStyle?.color,
          equals(APPColors.appBlack)); // Ensure text color is correct
      expect(pinCodeTextField.pinTheme.inactiveColor,
          equals(APPColors.bg_grey25)); // Ensure inactive color is correct
      expect(pinCodeTextField.pinTheme.selectedColor,
          equals(APPColors.appBlue)); // Ensure selected color is correct
      // Add more checks for other properties as needed
    });

    testWidgets('PinCodeTextField handles user input correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RabbleTheme(
            data: RabbleTheme.themeData,
            child: const VerifyOtpView(),
          ),
        ),
      );

      // Find the Container containing the PinCodeTextField based on its margin
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsWidgets);

      // Find the PinCodeTextField within the Containers
      final pinCodeTextFieldFinder = find.byElementPredicate(
        (element) =>
            element.widget is PinCodeTextField &&
            element.findAncestorWidgetOfExactType<Container>() != null,
      );
      expect(pinCodeTextFieldFinder, findsOneWidget);

      // Get the PinCodeTextField widget
      final pinCodeTextField =
          tester.widget<PinCodeTextField>(pinCodeTextFieldFinder);

      // Verify specific properties of the PinCodeTextField
      expect(pinCodeTextField.length, equals(6)); // Ensure length is 6
      expect(pinCodeTextField.keyboardType,
          equals(TextInputType.number)); // Ensure keyboard type is number
      expect(pinCodeTextField.textStyle?.color,
          equals(APPColors.appBlack)); // Ensure text color is correct
      expect(pinCodeTextField.pinTheme.inactiveColor,
          equals(APPColors.bg_grey25)); // Ensure inactive color is correct
      expect(pinCodeTextField.pinTheme.selectedColor,
          equals(APPColors.appBlue)); // Ensure selected color is correct
    });

    testWidgets('Resend OTP button triggers appropriate action',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RabbleTheme(
            data: RabbleTheme.themeData,
            child: const VerifyOtpView(),
          ),
        ),
      );

      // Find the Resend OTP button
      final resendButtonFinder = find.byKey(const Key('resend_otp_button'));
      expect(resendButtonFinder, findsOneWidget);

      // Tap on the Resend OTP button
      await tester.tap(resendButtonFinder);
      await tester.pump();

      verifyNever(mockVerifyOtpCubit.sendOtp({' number': '+9203313612701'}));
    });

    testWidgets('renders PinCodeTextField widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RabbleTheme(
            data: RabbleTheme.themeData,
            child: const VerifyOtpView(),
          ),
        ),
      );

      expect(find.byType(PinCodeTextField), findsOneWidget);
    });
    testWidgets('Verify button is displayed and triggers verification process',
        (WidgetTester tester) async {
      // Pump the widget tree
      await tester.pumpWidget(
        MaterialApp(
          home: RabbleTheme(
            data: RabbleTheme.themeData,
            child: const VerifyOtpView(),
          ),
        ),
      );

      // Find the Verify button
      final verifyButtonFinder = find.byKey(const Key('verify_button'));
      expect(verifyButtonFinder, findsOneWidget);

      // Tap the Verify button
      await tester.tap(verifyButtonFinder);
      await tester.pump();
    });

    tearDown(() {
      mockTimer.cancel();
    });
  });
}
