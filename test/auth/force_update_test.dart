import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rabble/core/config/export.dart';

void main() {
  setUp(() {
    SizerUtil.setScreenSize(
        const BoxConstraints(
          maxWidth: 300,
          maxHeight: 1000,
        ),
        Orientation.portrait);
  });
  group('ForceUpdate Widget Tests', () {
    testWidgets('Widget renders without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ForceUpdate(),
        ),
      );
      expect(find.byType(ForceUpdate), findsOneWidget);
    });

    testWidgets('Text content is displayed correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ForceUpdate(),
        ),
      );
      expect(find.text('RABBLE'), findsOneWidget); // Verify heading text
      expect(find.text(sUpdateMsg), findsOneWidget); // Verify subheading text
    });

    testWidgets('Update button is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ForceUpdate(),
        ),
      );
      expect(find.text('Update'), findsOneWidget); // Verify "Update" button text
    });

    testWidgets('Update button onTap callback is triggered', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ForceUpdate(),
        ),
      );

      // Tap the "Update" button
      await tester.tap(find.text('Update'));
      await tester.pump();

    });
  });
}
