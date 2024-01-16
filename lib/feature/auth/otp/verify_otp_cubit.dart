import 'package:rabble/config/export.dart';
import 'package:rxdart/rxdart.dart';

import '../../branch/welcome_to_team_sheet.dart';

class VerifyOtpCubit extends RabbleBaseCubit with Validators {
  VerifyOtpCubit() : super(RabbleBaseState.idle()) {
    countdownTimer();
  }

  BehaviorSubject<String> selectedCountryImage$ = BehaviorSubject<String>();

  final BehaviorSubject<Map> otpDataSubject$ = BehaviorSubject();

  final BehaviorSubject<String> otpSubject$ = BehaviorSubject();

  Function(String) get otpC => otpSubject$.sink.add;

  Stream<String> get otpStream => otpSubject$.transform(validateOtp);

  Stream<bool> get validOTPField =>
      Rx.combineLatest([otpStream], (p) => true).onErrorReturn(false);

  ///Timer
  final BehaviorSubject<int> _timerSubject = BehaviorSubject<int>.seeded(60);

  Stream<int> get timer => _timerSubject.stream;

  int _duration = 60;
  Timer? _timerCountdown;

  Future<void> verifyOtp(
      String phoneNumber, String sId, String type, BuildContext context,
      {InvitationData? data}) async {
    String otp = otpSubject$.value;
    String number = phoneNumber;
    String code = otp;
    String sid = sId;
    emit(RabbleBaseState.secondaryBusy());

    final loginRes = await authRepo
        .verifyOtp(number, code, sid, throwOnError: true, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    print("type ${type}");

    if (loginRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: loginRes.message);
      UserModel userData = UserModel.fromJson(loginRes.data);

      if (type == '0') {
        await RabbleStorage.storeToken(userData.token!);
        await RabbleStorage.storePostalCode(userData.postalCode ?? '');
        await RabbleStorage.loginStatus('1');
        await RabbleStorage.onBoarStatus('1');
        await RabbleStorage.storeDynamicValue(
            RabbleStorage.userKey, jsonEncode(userData));

        if (userData.firstName != null && userData.lastName != null) {
          NavigatorHelper().navigateAnClearAll(
            '/home',
          );
        } else {
          Map data = {'number': number, 'type': '1'};
          NavigatorHelper()
              .navigateToScreen('/user_name_view', arguments: data);
        }
      } else if (type == '1') {
        UserModel userData = UserModel.fromJson(loginRes.data);
        await RabbleStorage.storeToken(userData.token!);
        await RabbleStorage.storePostalCode(userData.postalCode ?? '');
        await RabbleStorage.loginStatus('1');
        await RabbleStorage.onBoarStatus('1');
        await RabbleStorage.storeDynamicValue(
            RabbleStorage.userKey, jsonEncode(userData));

        if (userData.firstName != null && userData.lastName != null) {
          NavigatorHelper().navigateAnClearAll(
            '/home',
          );
        } else {
          Map data = {'number': number, 'type': '1'};
          NavigatorHelper()
              .navigateToScreen('/user_name_view', arguments: data);
        }
      } else {
        UserModel userData = UserModel.fromJson(loginRes.data);
        await RabbleStorage.storeToken(userData.token!);
        await RabbleStorage.storePostalCode(userData.postalCode ?? '');
        await RabbleStorage.loginStatus('1');
        await RabbleStorage.onBoarStatus('1');
        await RabbleStorage.storeDynamicValue(
            RabbleStorage.userKey, jsonEncode(userData));

        if (userData.firstName != null && userData.lastName != null) {
          Map<String, dynamic> body = {
            'userId': userData.id,
            'teamId': data!.teamId,
            'status': 'APPROVED'
          };

          var addTeamRes = await userRepo.addMember(
              throwOnError: true,
              body: body,
              errorCallBack: () {
                emit(RabbleBaseState.idle());
              });

          if (addTeamRes!.statusCode == 200) {
            CustomBottomSheet.showAccountBottomModelSheet(
                context, WelcomeToTeamSheet(data), false,
                isRemove: false);
          }
        } else {
          Map mapData = {'number': number, 'type': '2', 'data': data};
          Navigator.pushNamedAndRemoveUntil(
              context, '/user_name_view', (route) => false,
              arguments: mapData);
        }
      }
    } else {
      globalBloc.showErrorSnackBar(message: loginRes.message);
    }
    emit(RabbleBaseState.idle());
  }

  ///Timer
  dynamic countdownTimer() {
    const oneSec = Duration(seconds: 1);
    _timerCountdown = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_duration == 0) {
          timer.cancel();
        } else {
          _timerSubject.sink.add(--_duration);
        }
      },
    );
  }

  dynamic startCounter() {
    _duration = 60;

    const oneSec = Duration(seconds: 1);
    _timerCountdown = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_duration == 0) {
          timer.cancel();
        } else {
          _timerSubject.sink.add(--_duration);
        }
      },
    );
  }

  Future<void> sendOtp(Map map) async {
    emit(RabbleBaseState.tertiaryBusy());

    final loginRes = await authRepo.login(map['number'], throwOnError: true,
        errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    globalBloc.showSuccessSnackBar(message: loginRes!.message);
    if (loginRes.status == 200) {
      if (map['type'] == '2') {
        Map data = {
          'number': map['number'],
          'sid': loginRes.data['sid'],
          'type': map['type'],
          'data': map['data'],
        };
        startCounter();
        otpDataSubject$.sink.add(data);
      } else {
        Map data = {
          'number': map['number'],
          'sid': loginRes.data['sid'],
          'type': map['type'],
        };
        startCounter();
        otpDataSubject$.sink.add(data);
      }
    }
    emit(RabbleBaseState.idle());
  }
}
