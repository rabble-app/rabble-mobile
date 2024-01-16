import 'export.dart';

FlutterLocalNotificationsPlugin? localNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RabbleStorage.setFromNotification('1');
  globalBloc.isNotifcation.sink.add(true);
  NavigatorHelper().navigateTo('/notification_list_view');

}


@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  RabbleStorage.setFromNotification('1');
  globalBloc.isNotifcation.sink.add(true);
  NavigatorHelper().navigateTo('/notification_list_view');

}

class FirebaseMessagingManager {
  static final FirebaseMessagingManager manager = FirebaseMessagingManager._();

  factory FirebaseMessagingManager() => manager;

  FirebaseMessagingManager._();

  Future<void> init() async {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    } else {
      await Firebase.initializeApp();
    }

    ///Initialize
    await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      alert: true,
      carPlay: true,
      criticalAlert: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      sound: true,
      alert: true,
      badge: true,
    );

    localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidNotificationChannel androidChannel =
        AndroidNotificationChannel(
      'Rabble',
      'Rabble',
      importance: Importance.high,
    );

    await localNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    ///Adding drawable resource
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    localNotificationsPlugin!.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse str) {
        Map<String, dynamic> data = json.decode(str.payload!);
        print("1");
        handleClick(data);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    FirebaseMessaging.onBackgroundMessage(notificationHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      globalBloc.isNotifcation.sink.add(true);
      print("asdasd12123");
      _notificationsHandler(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
      globalBloc.isNotifcation.sink.add(true);

      RabbleStorage.setFromNotification('1');
      NavigatorHelper().navigateTo('/notification_list_view');
    });


    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (message != null) {
          globalBloc.isNotifcation.sink.add(true);
          RabbleStorage.setFromNotification('1');
        }
      });
    });
    getToken();
  }

  Future<String?> getToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      debugPrint('FCM Token $token');

      return token;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void handleClick(Map<String, dynamic> data) {
    debugPrint('*******************  handleClick called  *****************');

    print(data.toString());

    RabbleStorage.setFromNotification('1');
    NavigatorHelper().navigateTo('/splash');
  }

  Future<void> _notificationsHandler(RemoteMessage message) async {
    RemoteNotification notification =
        message.notification ?? const RemoteNotification();
    globalBloc.isNotifcation.sink.add(true);

    if (notification.title != null && notification.body != null) {
      _showNotificationWithDefaultSound(message);
    }
  }

  Future<void> _showNotificationWithDefaultSound(RemoteMessage message) async {
    RemoteNotification data =
        message.notification ?? const RemoteNotification();

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('Rabble', 'rabble_app',
            importance: Importance.max,
            playSound: true,
            channelDescription: 'description',
            icon: 'mipmap/ic_launcher',
            styleInformation: BigTextStyleInformation(data.body ?? ''),
            priority: Priority.high);

    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails();

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    localNotificationsPlugin!.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse str) {
      Map<String, dynamic> data = json.decode(str.payload!);
      print("4");

      handleClick(data);
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await localNotificationsPlugin?.show(
        1, data.title, data.body, platformChannelSpecifics,
        payload: Platform.isAndroid
            ? json.encode(message.data)
            : json.encode(message.notification));
  }

  Future<void> notificationHandler(RemoteMessage message) async {
    RabbleStorage.setFromNotification('1');
    NavigatorHelper().navigateTo('/notification_list_view');

    _notificationsHandler(message);
  }
}
