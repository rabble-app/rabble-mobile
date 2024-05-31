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
}
