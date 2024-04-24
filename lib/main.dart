import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rabble/config/export.dart';
import 'package:upgrader/upgrader.dart';




// Steps to go on production

// 1 : uncomment kStripeReleasePublishKey key.
// 2 : uncomment getForceVersion() method.
// 3 : change dev environment to production.
// 4 : check pusher keys on ChatRoomCubit

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.initialize(Flavor.DEV, DevConfig());

//   Stripe.publishableKey = kStripeDebugPublishKey;

  if (kDebugMode) {
    Stripe.publishableKey = kStripeDebugPublishKey;
  } else {
    Stripe.publishableKey = kStripeReleasePublishKey;
  }

  Stripe.merchantIdentifier = kStripeMerchantIdentifier;

  await Stripe.instance.applySettings();

  await FlutterBranchSdk.init(
      useTestKey: false, enableLogging: true, disableTracking: false);

  //  FlutterBranchSdk.validateSDKIntegration();

  await loadImage(AssetImage('assets/png/splash.png'));
//  await loadImage(AssetImage('assets/png/onboard1.png'));
  await loadImage(AssetImage('assets/png/onboard2.png'));
  await loadImage(AssetImage('assets/png/onboard3.png'));
  await loadImage(AssetImage('assets/png/onboard4.png'));

  await FirebaseMessagingManager().init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // runApp(const MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: App(),
  // ));

  String forceVersion = await getForceVersion();
  PackageInfo.fromPlatform().then((value) {
    String currentVersion = value.buildNumber;

    if (int.parse(currentVersion) < int.parse(forceVersion)) {
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ForceUpdate(),
      ));
    } else {
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: App(),
      ));
    }
  });
}

Future<void> loadImage(ImageProvider provider) {
  final config = ImageConfiguration(
    bundle: rootBundle,
    devicePixelRatio: 1,
    platform: defaultTargetPlatform,
  );
  final Completer<void> completer = Completer();
  final ImageStream stream = provider.resolve(config);

  late final ImageStreamListener listener;

  listener = ImageStreamListener((ImageInfo image, bool sync) {
    completer.complete();
    stream.removeListener(listener);
  }, onError: (dynamic exception, StackTrace? stackTrace) {
    completer.complete();
    stream.removeListener(listener);
    FlutterError.reportError(FlutterErrorDetails(
      context: ErrorDescription('image failed to load'),
      library: 'image resource service',
      exception: exception,
      stack: stackTrace,
      silent: true,
    ));
  });

  stream.addListener(listener);
  return completer.future;
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RabbleStorage.setFromNotification('1');
  NavigatorHelper().navigateTo('/splash');
}

Future<String> getForceVersion() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get a reference to the 'forceUpdate' collection.
  CollectionReference forceUpdateCollection =
      firestore.collection('forceUpdate');

  // Get a reference to the 'Version' document.
  DocumentReference versionDocument = forceUpdateCollection.doc('Version');

  // Get the value of the 'force_version' key.
  String forceVersion = (await versionDocument.get()).get('force_version');

  return forceVersion;
}
// Put this in main function
// await preloadSVGs([
// 'assets/icon_comment.svg',
// 'assets/icon_info.svg',
// 'assets/icon_link.svg',
// ]);


// Future<void> preloadSVGs(List<String> assetPaths) async {
//   for (final path in assetPaths) {
//     final loader = SvgAssetLoader(path);
//     await svg.cache.putIfAbsent(
//       loader.cacheKey(null),
//           () => loader.loadBytes(null),
//     );
//   }
// }
