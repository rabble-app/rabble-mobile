// ignore_for_file: use_build_context_synchronously

import 'package:rabble/config/export.dart';

class RabbleStorage {
  static FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static const String tokenKey = 'tokenKey';
  static const String loginKey = 'loginkey';
  static const String onBoardKey = 'onBoardKey';
  static const String userKey = 'userKey';
  static const String data = 'data';
  static const String address = 'address';
  static const String inivitationData = 'inivitationData';
  static const String postalCode = 'postalCode';
  static const String shareStatus = 'shareStatus';
  static const String notificatioKey = 'notificationKey';

  static dynamic storeToken(String token) async {
    await secureStorage.write(key: tokenKey, value: token);
  }

  static dynamic getToken() async {
    var result = await secureStorage.read(key: tokenKey);
    return result;
  }  static dynamic setFromNotification(String type) async {
    await secureStorage.write(key: notificatioKey, value: type);
  }

  static dynamic isFromNotification() async {
    var result = await secureStorage.read(key: notificatioKey);
    return result;
  }

  static dynamic storePostalCode(String token) async {
    await secureStorage.write(key: postalCode, value: token);
  }

  static dynamic getPostalCode() async {
    var result = await secureStorage.read(key: postalCode);
    return result;
  }

  static dynamic setStatusShareWidget(String status) async {
    await secureStorage.write(key: shareStatus, value: status);
  }

  static dynamic getStatusShareWidget() async {
    var result = await secureStorage.read(key: shareStatus);
    return result;
  }

  static dynamic loginStatus(String status) async {
    await secureStorage.write(key: loginKey, value: status);
  }

  static dynamic getLoginStatus() async {
    var result = await secureStorage.read(key: loginKey);
    return result;
  }

  static dynamic onBoarStatus(String status) async {
    await secureStorage.write(key: onBoardKey, value: status);
  }

  static dynamic getOnBoardStatus() async {
    return await secureStorage.read(key: onBoardKey);
  }

  static dynamic userDataStatus(String status) async {
    await secureStorage.write(key: data, value: status);
  }

  static dynamic getUserDataStatus() async {
    var result = await secureStorage.read(key: data);
    return result;
  }


  static dynamic setInivitationData(String data) async {
    await secureStorage.write(key: inivitationData, value: data);
  }

  static dynamic getinivitationData() async {
    var result = await secureStorage.read(key: inivitationData);
    return result;
  }

  static dynamic storeDynamicValue(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  static dynamic retrieveDynamicValue(String key) async {
    var result = await secureStorage.read(key: key);
    return result;
  }

  static dynamic logout(BuildContext context) async {
   await dbHelper.truncateCartItems();
   await dbHelper.clearAll();
    await secureStorage.deleteAll();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SplashView()),
        (Route<dynamic> route) => false);
  }

  static Future<void> userAccountDeletion() async {
    await secureStorage.delete(key: RabbleStorage.userKey);
    await secureStorage.delete(key: RabbleStorage.onBoardKey);
    await secureStorage.delete(key: RabbleStorage.tokenKey);
    await secureStorage.delete(key: RabbleStorage.loginKey);
    await loginStatus("0");

    NavigatorHelper().navigateToClearAll('/splash');
  }

  static Future<void> deleteKey(String key) async {
    await secureStorage.delete(key: key);

  }
}
