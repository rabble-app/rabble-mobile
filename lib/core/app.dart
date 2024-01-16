import 'package:rabble/config/export.dart';
import 'package:rabble/core/GlobalVariable.dart';
import 'package:upgrader/upgrader.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Routes.configureRoutes(NavigatorHelper.router);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: APPColors.appBlack, // Replace with your desired color
      ),
    );
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (_, orientation, device) {
      return RabbleTheme(
          data: RabbleTheme.themeData,
          child: MaterialApp(
            scaffoldMessengerKey: globalBloc.rootScaffoldMessengerKey,
            themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            title: 'Rabble',
            builder: (context, child) => DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyText1!,
              child: Scaffold(resizeToAvoidBottomInset: false, body: child),
            ),
            navigatorKey: NavigatorHelper.navigatorKey,
            navigatorObservers: <NavigatorObserver>[
              // routeObserver,
              RabbleNavigatorObserver(),
            ],
            initialRoute: '/splash',
            //initialRoute: '/order_history_view',
            onGenerateRoute: NavigatorHelper.router.generator,
            theme: RabbleTheme.generateThemeDataFromrabbleThemeData(
                RabbleTheme.themeData),
          ));
    });
  }

  Future<void> init() async {
    await RepositoryBarrel().initializeAll();
  }


}
