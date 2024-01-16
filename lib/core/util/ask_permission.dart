import 'package:rabble/config/export.dart';

class AskPermission {
  Future<bool> askPhotoPermission() async {
    final RabblePermissionStatus status =
        await PermissionHandlerService().askPermission(RabblePermission.PHOTO);
    if (status != RabblePermissionStatus.GRANTED) {
      return false;
    } else {
      return true;
    }
  }
}