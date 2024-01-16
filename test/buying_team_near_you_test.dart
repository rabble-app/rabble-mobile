import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rabble/config/export.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  setUp(() {
    Config.initialize(Flavor.DEV, DevConfig());
  });

  group('BuyingTeamNearYou', () {
    testWidgets(kAppFile, (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(RabbleTheme(
          data: RabbleTheme.themeData,
          child: const MaterialApp(
            home: BuyingTeamNearYou(),
          )));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(RabbleAppbar), findsOneWidget);
      expect(find.byType(BuyingTeamNearYouWidget), findsOneWidget);

      final appBar = tester.widget<RabbleAppbar>(find.byType(RabbleAppbar));

      expect(appBar.backgroundColor, APPColors.bg_app_primary);
      expect(appBar.title, kBlackLines);

      final shareWidgetFinder = find.byType(ShareWidget);

      expect(shareWidgetFinder, findsOneWidget);
    });
  });
}
