import 'package:rabble/config/export.dart';
import 'dart:io' show Platform;

class SplashView extends StatefulWidget {
  static const String route = '/splash';

  const SplashView({Key? key}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  late Timer _timer;
  late AuthCubit authCubit;
  StreamSubscription<Map>? streamSubscription;
  bool _branchProcessed = false;

  @override
  void initState() {
    super.initState();
    authCubit = AuthCubit();

    // Initialize Branch SDK

    init();
  }

  Future<void> routeBasedOnLocalStorage() async {
    if (_branchProcessed) return; // Don't execute if Branch already processed

    // Fallback mechanism if Branch doesn't respond in 5 seconds
    Future.delayed(Duration(seconds: 3), () async {
      if (!_branchProcessed) {
        String status = await RabbleStorage.getLoginStatus() ?? "0";
        String onBoardStatus = await RabbleStorage.getOnBoardStatus() ?? '0';

        if (onBoardStatus == '0') {
          NavigatorHelper().navigateAnClearAll('/onboard');
        } else {
          if (status == '0') {
            NavigatorHelper().navigateAnClearAll('/login');
          } else {
            String isFromNotification =
                await RabbleStorage.isFromNotification() ?? '0';

            print("isFromNotification ${isFromNotification}");
            if (isFromNotification == '1') {
              NavigatorHelper().navigateAnClearAll('/notification_list_view');
            } else {
              NavigatorHelper().navigateAnClearAll('/home');
            }
          }
        }
      }
    });
  }

  void handleDeepLinkParameters(Map<dynamic, dynamic> data) {
    if (data['token'] != null) {
      authCubit.verifyToken(data['token'].toString());
    } else if (data.containsKey('~feature') && data['~feature'] == 'Share') {
      Map map = {'teamId': data['\$canonical_identifier'], 'type': '0'};
      NavigatorHelper().navigateToScreen('/threshold_view', arguments: map);
    } else if (data.containsKey('~feature') &&
        data['~feature'] == 'Share Producer') {
      Map body = {
        'type': false,
        'id': data['\$canonical_identifier'],
      };

      NavigatorHelper().navigateToScreen('/producer', arguments: body);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_branchProcessed) {
      routeBasedOnLocalStorage();
    }

    return CubitProvider<RabbleBaseState, AuthCubit>(
        create: (context) => authCubit,
        builder: (context, state, bloc) {
          return Scaffold(
              backgroundColor: APPColors.appWhite,
              body: FocusChild(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff202405),
                        Color(0xff000000),
                        Color(0xff202405),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RabbleText.subHeaderText(
                          text: 'RABBLE',
                          fontSize: 62.sp,
                          fontWeight: FontWeight.bold,
                          color: APPColors.appPrimaryColor,
                        ),
                        SizedBox(
                          height: 0.7.h,
                        ),
                        RabbleText.subHeaderText(
                          text: 'The Team Buying Platform',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: APPColors.appPrimaryColor,
                        ),
                      ],
                    )),
                  ),
                ),
              ));
        });
  }

  void listenDynamicLinks() async {
    streamSubscription = FlutterBranchSdk.initSession().listen((data) {
      print('listenDynamicLinks - DeepLink Data: $data');
    }, onError: (error) {
      print('InitSesseion error: ${error.toString()}');
    });
  }

  void init() {
    FlutterBranchSdk.initSession().listen((data) {
      print('Branch InitSession Error:1');
      if (data.containsKey('+clicked_branch_link') &&
          data['+clicked_branch_link'] == true) {
        _branchProcessed = true; // Indicate that Branch has responded
        handleDeepLinkParameters(data);
      }
    }, onError: (error) {
      _branchProcessed = true;
      print('Branch InitSession Error: $error');
      routeBasedOnLocalStorage();
    });

    setState(() {});
  }
}
