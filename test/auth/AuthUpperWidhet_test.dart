import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/core/widgets/AuthUpperWidget.dart';

void main() {
  setUp(() {
    SizerUtil.setScreenSize(
        const BoxConstraints(
          maxWidth: 300,
          maxHeight: 1000,
        ),
        Orientation.portrait);
  });

  group('AuthUpperWidget', () {
    testWidgets('Widget builds without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          // or WidgetsApp
          home: Directionality(
            textDirection: TextDirection.ltr, // Provide a text direction
            child: AuthUpperWidget(
              heading: 'Heading',
              subHeading: 'Sub Heading',
            ),
          ),
        ),
      );
      expect(find.byType(AuthUpperWidget), findsOneWidget);
    });

    testWidgets('Widget renders heading and subheading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: AuthUpperWidget(
              heading: 'Heading',
              subHeading: 'Sub Heading',
            ),
          ),
        ),
      );
      expect(find.text('Heading'), findsOneWidget);
      expect(find.text('Sub Heading'), findsOneWidget);
    });

    testWidgets('Widget renders steps if provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: AuthUpperWidget(
              heading: 'Heading',
              subHeading: 'Sub Heading',
              steps: '3 steps',
            ),
          ),
        ),
      );
      expect(find.text('3 steps'), findsOneWidget);
    });

    testWidgets('Widget does not render steps if not provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: AuthUpperWidget(
              heading: 'Heading',
              subHeading: 'Sub Heading',
            ),
          ),
        ),
      );
      expect(find.text('3 steps'), findsNothing);
    });

    testWidgets('Widget renders without image if not provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: AuthUpperWidget(
              heading: 'Heading',
              subHeading: 'Sub Heading',
            ),
          ),
        ),
      );
      expect(find.byType(Image), findsNothing);
    });
    testWidgets('Widget renders long texts without overflow',
        (WidgetTester tester) async {
      const longHeading =
          'A very long heading text that exceeds the usual length';
      const longSubHeading =
          'A very long subheading text that exceeds the usual length';
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: AuthUpperWidget(
              heading: longHeading,
              subHeading: longSubHeading,
            ),
          ),
        ),
      );
      expect(find.text(longHeading), findsOneWidget);
      expect(find.text(longSubHeading), findsOneWidget);
    });
    testWidgets('Widget renders correctly with null values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: AuthUpperWidget(
              heading: 'Heading',
              subHeading: 'Sub Heading',
              steps: null,
            ),
          ),
        ),
      );
      expect(find.text('3 steps'), findsNothing);
    });
  });
}
