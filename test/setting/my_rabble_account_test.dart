import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/feature/myRabbleAccount/my_rabble_account_cubit.dart';

import 'my_rabble_account_test.mocks.dart';

@GenerateMocks([MyRabbleAccountCubit])
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
    testWidgets('User with image URL', (WidgetTester tester) async {
      final mockCubit = MockMyRabbleAccountCubit();
      when(mockCubit.userDataSubject$)
          .thenAnswer((_) => BehaviorSubject<UserModel>.seeded(UserModel(
                firstName: 'John',
                lastName: 'Doe',
                phone: '1234567890',
                imageUrl: 'https://example.com/user.png',
              )));

      await tester.pumpWidget(
        Provider<MyRabbleAccountCubit>.value(
          value: mockCubit,
          child: const MaterialApp(
            home: MyRabbleAccountView(),
          ),
        ),
      );

      expect(find.byType(CircularAvatarWidget), findsNothing);
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('User data loading', (WidgetTester tester) async {
      final mockCubit = MockMyRabbleAccountCubit();
      when(mockCubit.userDataSubject$)
          .thenAnswer((_) => BehaviorSubject<UserModel>()); // Empty stream

      await tester.pumpWidget(
        Provider<MyRabbleAccountCubit>.value(
          value: mockCubit,
          child: const MaterialApp(
            home: MyRabbleAccountView(),
          ),
        ),
      );

      expect(find.byType(RabbleFullScreenProgressIndicator), findsOneWidget);
    });
  });
}
