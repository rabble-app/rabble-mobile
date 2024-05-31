import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rabble/core/config/export.dart';

import 'user_name_test.mocks.dart';

@GenerateMocks([MyRabbleAccountCubit])
void main() {
  late MockMyRabbleAccountCubit mockCubit;

  setUp(() {
    Config.initialize(Flavor.DEV, DevConfig());

    SizerUtil.setScreenSize(
        const BoxConstraints(
          maxWidth: 300,
          maxHeight: 1000,
        ),
        Orientation.portrait);
    mockCubit = MockMyRabbleAccountCubit();
  });

  testWidgets('UserNameView renders correctly', (WidgetTester tester) async {
    // Build the widget under test
    await tester.pumpWidget(
      MaterialApp(
        home: RabbleTheme(
          data: RabbleTheme.themeData,
          child: const Scaffold(
            body: UserNameView(),
          ),
        ),
      ),
    );

    // Verify that the widget renders correctly
    expect(find.byType(UserNameView), findsOneWidget);
    expect(find.text(kFirstName), findsOneWidget);
    expect(find.text(kSurName), findsOneWidget);
    expect(find.byType(RabbleButton), findsOneWidget);
  });

}
