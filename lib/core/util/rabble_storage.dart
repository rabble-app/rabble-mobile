
import 'package:rabble/core/config/export.dart';

class RabbleStorage {
   FlutterSecureStorage secureStorage = FlutterSecureStorage();

    String tokenKey = 'tokenKey';
    String loginKey = 'loginkey';
    String onBoardKey = 'onBoardKey';
    String userKey = 'userKey';
    String data = 'data';
    String address = 'address';
    String inivitationData = 'inivitationData';
    String postalCode = 'postalCode';
    String producerInfo = 'producerInfo';
    String shareStatus = 'shareStatus';
    String notificatioKey = 'notificationKey';

   dynamic storeToken(String token) async {
    await secureStorage.write(key: tokenKey, value: token);
  }

   dynamic getToken() async {
    var result = await secureStorage.read(key: tokenKey);
    return result;
  }   dynamic setFromNotification(String type) async {
    await secureStorage.write(key: notificatioKey, value: type);
  }

   dynamic isFromNotification() async {
    var result = await secureStorage.read(key: notificatioKey);
    return result;
  }


   dynamic storeProducerInfo(String data) async {
    await secureStorage.write(key: producerInfo, value: data);
  }

   dynamic getProducerInfo() async {
    var result = await secureStorage.read(key: producerInfo);
    return result;
  }

   dynamic storePostalCode(String token) async {
    await secureStorage.write(key: postalCode, value: token);
  }

   dynamic getPostalCode() async {
    var result = await secureStorage.read(key: postalCode);
    return result;
  }

   dynamic setStatusShareWidget(String status) async {
    await secureStorage.write(key: shareStatus, value: status);
  }

   dynamic getStatusShareWidget() async {
    var result = await secureStorage.read(key: shareStatus);
    return result;
  }

   dynamic loginStatus(String status) async {
    await secureStorage.write(key: loginKey, value: status);
  }

   dynamic getLoginStatus() async {
    var result = await secureStorage.read(key: loginKey);
    return result;
  }

   dynamic onBoarStatus(String status) async {
    await secureStorage.write(key: onBoardKey, value: status);
  }

   dynamic getOnBoardStatus() async {
    return await secureStorage.read(key: onBoardKey);
  }

   dynamic userDataStatus(String status) async {
    await secureStorage.write(key: data, value: status);
  }

   dynamic getUserDataStatus() async {
    var result = await secureStorage.read(key: data);
    return result;
  }


   dynamic setInivitationData(String data) async {
    await secureStorage.write(key: inivitationData, value: data);
  }

   dynamic getinivitationData() async {
    var result = await secureStorage.read(key: inivitationData);
    return result;
  }

   dynamic storeDynamicValue(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

   dynamic retrieveDynamicValue(String key) async {
    var result = await secureStorage.read(key: key);
    return result;
  }

   dynamic logout(BuildContext context) async {
   await dbHelper.truncateCartItems();
   await dbHelper.clearAll();
    await secureStorage.deleteAll();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) =>  SplashView()),
        (Route<dynamic> route) => false);
  }

   Future<void> userAccountDeletion() async {
    await secureStorage.delete(key: userKey);
    await secureStorage.delete(key: onBoardKey);
    await secureStorage.delete(key: tokenKey);
    await secureStorage.delete(key: loginKey);
    await loginStatus('0');

    NavigatorHelper().navigateToClearAll('/splash');
  }

   Future<void> deleteKey(String key) async {
    await secureStorage.delete(key: key);

  }
}
