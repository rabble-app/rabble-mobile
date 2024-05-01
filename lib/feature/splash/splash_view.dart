import 'package:package_info_plus/package_info_plus.dart';
import 'package:rabble/core/config/export.dart';
import 'dart:io' show Platform;

import '../../main.dart';

class SplashView extends StatefulWidget {
  static const String route = '/splash';

  const SplashView({Key? key}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AuthCubit authCubit;
  StreamSubscription<Map>? streamSubscription;
  bool branchProcessed = false;
  Offset offset = Offset.zero;
  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    authCubit = AuthCubit();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // Start from the top
      end: const Offset(0.0, 0.0), // Stop at the center
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceIn,
      ),
    );
    controller.forward();

    // Initialize Branch SDK
    init();
  }

  Future<void> routeBasedOnLocalStorage() async {
    if (branchProcessed) return; // Don't execute if Branch already processed

    // Fallback mechanism if Branch doesn't respond in 5 seconds
    Future.delayed(Duration(seconds: !branchProcessed ? 3 : 5), () async {
      if (!branchProcessed) {
        String status = await RabbleStorage().getLoginStatus() ?? '0';
        String onBoardStatus = await RabbleStorage().getOnBoardStatus() ?? '0';

        if (onBoardStatus == '0') {
          NavigatorHelper().navigateAnClearAll('/onboard');
        } else {
          if (status == '0') {
            NavigatorHelper().navigateAnClearAll('/login');
          } else {
            String isFromNotification =
                await RabbleStorage().isFromNotification() ?? '0';

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

  Future<void> handleDeepLinkParameters(Map<dynamic, dynamic> data) async {

    String forceVersion = await getForceVersion();
    PackageInfo.fromPlatform().then((value) async {
      String currentVersion = value.buildNumber;

      if (int.parse(currentVersion) < int.parse(forceVersion)) {
        NavigatorHelper().navigateAnClearAll('/force_update');
      } else {
        if (data['token'] != null) {
          authCubit.verifyToken(data['token'].toString());
        } else if (data.containsKey('~feature') &&
            data['~feature'] == 'Share') {
          Map map = {'teamId': data['\$canonical_identifier'], 'type': '0'};
          NavigatorHelper()
              .navigateAnClearAll('/threshold_view', arguments: map);
        } else if (data.containsKey('~feature') &&
            data['~feature'] == 'Share Producer') {
          Map body = {
            'type': false,
            'id': data['\$canonical_identifier'],
          };
          await RabbleStorage().onBoarStatus("1");
          NavigatorHelper().navigateAnClearAll('/producer', arguments: body);
        } else if (data.containsKey('~feature') &&
            data['~feature'] == 'Share Product') {
          Map body = {
            'productId': data['\$canonical_identifier'],
            'producerId': data['\$canonical_url'],
          };
          await RabbleStorage().onBoarStatus("1");
          NavigatorHelper().navigateAnClearAll('/detail', arguments: body);
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    animation.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!branchProcessed) {
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
                      image: DecorationImage(
                          image: AssetImage('assets/png/splash.png'),
                          fit: BoxFit.fill)),
                  child: SafeArea(
                    child: Center(
                        child: SlideTransition(
                      position: animation,
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
                      ),
                    )),
                  ),
                ),
              ));
        });
  }

  Future<void> init() async {
    await FlutterBranchSdk.init(
        useTestKey: false, enableLogging: true, disableTracking: false);

    FlutterBranchSdk.listSession().listen((data) {
      print('Branch InitSession Error:1');
      if (data.containsKey('+clicked_branch_link') &&
          data['+clicked_branch_link'] == true) {
        branchProcessed = true; // Indicate that Branch has responded
        handleDeepLinkParameters(data);
      }
    }, onError: (error) {
      branchProcessed = true;
      print('Branch InitSession Error: $error');
      routeBasedOnLocalStorage();
    });

    setState(() {});
  }


}
