import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/feature/buying_team/main_view/buying_team_view.dart';
import 'package:rabble/feature/explore/explore_view.dart';
import 'package:rabble/feature/home/home_cubit.dart';
import 'package:rabble/feature/home/home_view.dart';

import 'home_test.mocks.dart';

// Mock HomeCubit
@GenerateMocks([
  HomeCubit,
])
void main() {
  setUpAll(() {
    SizerUtil.setScreenSize(
        const BoxConstraints(
          maxWidth: 300,
          maxHeight: 1000,
        ),
        Orientation.portrait);
    Config.initialize(Flavor.DEV, DevConfig());
  });

  testWidgets('HomeView displays ExploreView initially',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: RabbleTheme(data: RabbleTheme.themeData, child: const HomeView()),
    ));

    expect(find.byType(ExploreView), findsOneWidget);
    await tester
        .pump(const Duration(milliseconds: 500)); // Adjust duration as needed
  });

  // testWidgets('Tapping on bottom navigation bar changes view',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //     home: RabbleTheme(data: RabbleTheme.themeData, child: const HomeView()),
  //   ));
  //
  //   // Tapping on the second item in the bottom navigation bar
  //   await tester.tap(find.byKey(const ValueKey(1)));
  //   await tester.pumpAndSettle();
  //
  //   await tester.tap(find.byKey(const ValueKey(1)));
  //   await tester.pumpAndSettle();
  // });
}
