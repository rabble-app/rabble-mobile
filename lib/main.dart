import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rabble/config/export.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.initialize(Flavor.DEV, DevConfig());

  if (kDebugMode) {
    Stripe.publishableKey =
        'pk_test_51MiiYmLOm4z6Mbsx2Bv78MsSqQdcBBPz8cRCvXHUNEw3C7mOCHVUf7mhpd7BqrrllgXPf9A9lnF7PaEJlvtY6Ycr00LL5Ld4OD';
  } else {
    Stripe.publishableKey =
        'pk_live_51MiiYmLOm4z6MbsxZYWSwC4J1DppaCp2QjtCnYNdoEAcmKIenBH1b0V8Sjoks1gN58kkGCJURrXK4LedQpQVLc6u000hSHq8cD';
  }

  Stripe.merchantIdentifier = 'merchant.com.postcodecollective';
  await Stripe.instance.applySettings();


  await FlutterBranchSdk.init(
      useTestKey: false, enableLogging: true, disableTracking: false);


  //  FlutterBranchSdk.validateSDKIntegration();


  await loadImage(AssetImage('assets/png/onboard1.png'));
  await loadImage(AssetImage('assets/png/onboard2.png'));
  await loadImage(AssetImage('assets/png/onboard3.png'));
  await loadImage(AssetImage('assets/png/onboard4.png'));

  await FirebaseMessagingManager().init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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

Future<void> _launchUrl() async {
  globalBloc.showSuccessSnackBar(message: 'HERE');
  String url = Platform.isIOS
      ? 'https://apps.apple.com/app/rabble/id6450045487'
      : 'https://apps.apple.com/app/rabble/id6450045487';
  if (!await launchUrl(Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication)) {
    globalBloc.showSuccessSnackBar(message: 'HERE 2');

    throw 'Could not launch $url';
  }
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
