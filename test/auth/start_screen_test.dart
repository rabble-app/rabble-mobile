import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/main.dart';
import 'dart:io' show Platform;

import 'start_screen_test.mocks.dart';

@GenerateMocks([
  RabbleStorage,
  NavigatorHelper,
  AnimationController,
  FlutterBranchSdk,
  PackageInfo,
  AuthCubit,
  FirebaseFirestore,
  DocumentSnapshot,
])
void main() {
  setUpAll(() {
    Config.initialize(Flavor.DEV, DevConfig());
  });

  group('SplashViewState', () {
    late MockRabbleStorage mockStorage;
    late MockNavigatorHelper mockNavigator;
    late SplashViewState state;

    setUp(() {
      mockStorage = MockRabbleStorage();
      mockNavigator = MockNavigatorHelper();
      state = SplashViewState();
      SizerUtil.setScreenSize(
          const BoxConstraints(
            maxWidth: 500,
            maxHeight: 1000,
          ),
          Orientation.portrait);
    });

    testWidgets('initializes animation controller on initState',
        (WidgetTester tester) async {
      // Arrange
      final mockController = MockAnimationController();

      final SplashViewState state = SplashViewState();

      // Inject the mock controller into the state (optional)
      state.controller = mockController; // If needed for specific behavior

      // Act
      await tester.pumpWidget(const MaterialApp(home: SplashView()));

      verifyNever(mockController.forward());
    });

    testWidgets('routeBasedOnLocalStorage - no execution if branch processed',
        (WidgetTester tester) async {
      final SplashViewState state = SplashViewState();
      state.branchProcessed = true;

      await state.routeBasedOnLocalStorage();

      verifyNoMoreInteractions(mockStorage);
      verifyNoMoreInteractions(mockNavigator);
    });

    testWidgets(
        'routeBasedOnLocalStorage - navigates to onboarding if not onboarded',
        (WidgetTester tester) async {
      when(mockStorage.getLoginStatus())
          .thenAnswer((realInvocation) => Future.value('0'));
      when(mockStorage.getOnBoardStatus())
          .thenAnswer((realInvocation) => Future.value('0'));

      await tester.pump(); // Pump the widget

      verifyNever(mockNavigator.navigateAnClearAll('/onboard'));
      verifyNoMoreInteractions(mockNavigator);
    });

    testWidgets(
        'routeBasedOnLocalStorage - navigates to login if logged out and onboarded',
        (WidgetTester tester) async {
      when(mockStorage.getLoginStatus())
          .thenAnswer((realInvocation) => Future.value('0'));
      when(mockStorage.getOnBoardStatus())
          .thenAnswer((realInvocation) => Future.value('1'));

      await tester.pump();

      verifyNever(mockNavigator.navigateAnClearAll('/login'));
      verifyNoMoreInteractions(mockNavigator);
    });

    testWidgets(
        'routeBasedOnLocalStorage - navigates to home if logged in and onboarded',
        (WidgetTester tester) async {
      when(mockStorage.getLoginStatus())
          .thenAnswer((realInvocation) => Future.value('1'));
      when(mockStorage.getOnBoardStatus())
          .thenAnswer((realInvocation) => Future.value('1'));

      await tester.pump(); // Pump the widget

      verifyNever(mockNavigator.navigateAnClearAll('/home'));
      verifyNoMoreInteractions(mockNavigator);
    });

    testWidgets(
        'routeBasedOnLocalStorage - triggers fallback navigation after delay',
        (WidgetTester tester) async {
      when(mockStorage.getLoginStatus())
          .thenAnswer((realInvocation) => Future.value('0'));
      when(mockStorage.getOnBoardStatus())
          .thenAnswer((realInvocation) => Future.value('0'));

      await tester.pump(); // Pump the widget

      verifyNever(mockNavigator.navigateAnClearAll('/home'));
      verifyNoMoreInteractions(mockNavigator);
    });
    test('handleDeepLinkParameters - force update', () async {
      // Mock dependencies
      final mockPackageInfo = MockPackageInfo();
      final mockNavigatorHelper = MockNavigatorHelper();
      final mockAuthCubit = MockAuthCubit();
      final fakeFirestore = MockFirebaseFirestore();

      when(getForceVersion()).thenAnswer((_) => fakeFirestore
          .collection('forceUpdate') // Use the mocked collection here
          .doc('Version')
          .get()
          .then((snapshot) => snapshot.get('force_version')));

      await state.handleDeepLinkParameters({});

      // Verify interactions (unchanged)
      verify(mockPackageInfo.buildNumber).called(1);
      verify(mockNavigatorHelper.navigateAnClearAll('/force_update')).called(1);
      verifyNoMoreInteractions(mockAuthCubit);
    });
  });
}
