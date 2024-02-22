import 'package:rabble/config/export.dart';
import 'package:rxdart/rxdart.dart';

class AuthCubit extends RabbleBaseCubit with Validators {
  AuthCubit() : super(RabbleBaseState.idle());

  final BehaviorSubject<int> currentIndex = BehaviorSubject<int>.seeded(0);

  final BehaviorSubject<double> containerWidth =
      BehaviorSubject<double>.seeded(100.w);

  final BehaviorSubject<bool> isActiveNextButtonController =
      BehaviorSubject<bool>.seeded(false);

  final BehaviorSubject<List<double>> progressValues$subject =
      BehaviorSubject<List<double>>.seeded([0.0, 0.0, 0.0, 0.0]);

  final List<int> storyDurations = [
    5,
    5,
    5,
    5
  ]; // Durations of each story in seconds

  List<OnBoardModel> data = [
    OnBoardModel(
        heading: 'RABBLE',
        subHeading: 'The Team Buying Platform',
        image: 'assets/png/splash.png',
        title: 'Buy as a Team',
        desc:
            'Combine orders with friends and neighbours to move up the supply chain and buy direct from farmer, producer or importer'),
    OnBoardModel(
        heading: 'Support',
        subHeading: 'Sustatinable Producers',
        image: 'assets/png/onboard2.png',
        title: 'Bypass Conventional Supply Chains',
        desc:
            'The conventional supply chain fails small producers. Give local producers and sustainable farming a chance by going direct'),
    OnBoardModel(
        heading: 'Help',
        subHeading: 'The Environment',
        image: 'assets/png/onboard3.png',
        title: 'Slash your carbon footprint',
        desc:
            'Align your community and collectively avoid inefficient, CO2 intensive and wasteful supply chains that are bad for the environment and bad for the food itself'),
    OnBoardModel(
        heading: 'Access',
        subHeading: 'Better Products',
        image: 'assets/png/onboard4.png',
        title: 'Access sustainable high quality \nproducts',
        desc:
            'Get access to a curation of the highest quality sustainable producers for supermarket prices')
  ];

  BehaviorSubject<String> selectedCountryImage$ = BehaviorSubject<String>();
  BehaviorSubject<bool> focus$ = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<String> selectedCountryCode$ =
      BehaviorSubject<String>.seeded('44');
  BehaviorSubject<String> ErrorCode$ = BehaviorSubject<String>.seeded('');

  BehaviorSubject<bool> iSCompletedNumber$ =
      BehaviorSubject<bool>.seeded(false);

  final BehaviorSubject<String> _phoneC = BehaviorSubject();

  Function(String) get phoneC => _phoneC.sink.add;

  Stream<String> get phoneStream => _phoneC.transform(validatePhone);

  ///Login
  Stream<bool> get validFPField =>
      Rx.combineLatest([phoneStream], (p) => true).onErrorReturn(false);

  Future<void> sendOtp(String type,
      {String? number, InvitationData? invitationData}) async {
    emit(RabbleBaseState.secondaryBusy());

    number ??= '+${selectedCountryCode$.value}${_phoneC.value}';

    final loginRes =
        await authRepo.login(number, throwOnError: false, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (loginRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: loginRes.message);

      if (type == '2') {
        Map data = {
          'number': number,
          'sid': loginRes.data['sid'],
          'type': type,
          'data': invitationData,
        };
        NavigatorHelper().navigateToScreen('/verify_otp', arguments: data);
      } else {
        Map data = {
          'number': number,
          'sid': loginRes.data['sid'],
          'type': type,
        };
        NavigatorHelper().navigateToScreen('/verify_otp', arguments: data);
      }
    } else {
      globalBloc.showErrorSnackBar(message: loginRes.message);
    }

    emit(RabbleBaseState.idle());
  }

  Future<void> updateUserInfo() async {
    String number = '+${selectedCountryCode$.value}${_phoneC.value}';
    emit(RabbleBaseState.secondaryBusy());

    final loginRes =
        await authRepo.login(number, throwOnError: false, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (loginRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: loginRes.message);

      Map data = {
        'phone': '+${selectedCountryCode$.value}${_phoneC.value}',
        'firstName': loginRes.data['sid'],
        'lastName': '1',
      };
      NavigatorHelper().navigateToScreen('/verify_otp', arguments: data);
    } else {
      globalBloc.showErrorSnackBar(message: loginRes.message);
    }
    emit(RabbleBaseState.idle());
  }

  Future<void> verifyToken(String token) async {

    showDialog(
      context: NavigatorHelper.navigatorKey.currentState!.context,
      barrierDismissible: false, // determines if outside tap will close the dialog
      builder: (BuildContext context) {
        authRepo.verifyToken(token, throwOnError: true, errorCallBack: () {
          emit(RabbleBaseState.idle());
        },retryCallBack: (verifyTokenAPI){
          Navigator.pop(context);
          if (verifyTokenAPI!.statusCode == 200) {
            sendOtp('2',
                number: verifyTokenAPI.data!.phone,
                invitationData: verifyTokenAPI.data);
          } else {
            route();
          }
        }).then((verifyTokenAPI) {
          Navigator.pop(context);
          if (verifyTokenAPI!.statusCode == 200) {
            sendOtp('2',
                number: verifyTokenAPI.data!.phone,
                invitationData: verifyTokenAPI.data);
          } else {
            route();
          }
        });
        return Dialog(
          backgroundColor: Colors.transparent, // makes the dialog background transparent
          elevation: 0,
          child: Container(
            color: Colors.transparent, // this makes the container inside the dialog transparent
            alignment: Alignment.center, // this aligns the logo to the center of the screen
            child: SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(
                color: APPColors.appWhite,
                backgroundColor: APPColors.appPrimaryColor,
              ),
            ), // your logo asset here
          ),
        );
      },
    );

  }



  Future<void> route() async {
    String status = await RabbleStorage.getLoginStatus() ?? "0";
//      String dataStatus = await RabbleStorage.getUserDataStatus() ?? "0";
    String onBoardStatus = await RabbleStorage.getOnBoardStatus() ?? '0';
//      NavigatorHelper().navigateTo('/force_update');

    if (onBoardStatus == '0') {
      NavigatorHelper().navigateAnClearAll('/onboard');
    } else {
      if (status == '0') {
        NavigatorHelper().navigateAnClearAll('/login');
      } else {
        NavigatorHelper().navigateAnClearAll('/home');
      }
    }
  }
}
