import 'package:rabble/core/config/export.dart';

class AskPermission {
  Future<bool> askPhotoPermission() async {
    final RabblePermissionStatus status =
        await PermissionHandlerService().askPermission(RabblePermission.PHOTO);
    if (status != RabblePermissionStatus.GRANTED) {
      return false;
    } else {
      return true;
    }
  }  Future<bool> askLocationPermission() async {
    final RabblePermissionStatus status =
        await PermissionHandlerService().askPermission(RabblePermission.LOCATION);
    if (status != RabblePermissionStatus.GRANTED) {
      return false;
    } else {
      return true;
    }
  }
}
