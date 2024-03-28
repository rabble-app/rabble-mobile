import 'package:rabble/core/config/export.dart';

enum RabblePermission { CONTACTS, LOCATION, STORAGE, PHOTO, NOTIFICATION }

enum RabblePermissionStatus { GRANTED, DENIED, PERMANENTLYDENIED }

class PermissionHandlerService {
  static final PermissionHandlerService _instance =
      PermissionHandlerService._internal();
  final BehaviorSubject<RabblePermissionStatus> notificaitonPermissionStatus$ =
      BehaviorSubject();

  factory PermissionHandlerService() => _instance;

  PermissionHandlerService._internal();

  // TODO split this into askContactsPermission and askStoragePermission -> cleaner
  Future<RabblePermissionStatus> askPermission(
    RabblePermission permission,
  ) async {
    PermissionStatus? permissionStatus;
    if (permission == RabblePermission.CONTACTS) {
      permissionStatus = await _getContactPermission();
    }
    if (permission == RabblePermission.STORAGE) {
      permissionStatus = await _getStoragePermission();
    }
    if (permission == RabblePermission.PHOTO) {
      permissionStatus = await _getPhotoPermission();
      print(permissionStatus);
    }
    if (permission == RabblePermission.LOCATION) {
      permissionStatus = await _getLocationPermission();
    }
    if (permission == RabblePermission.NOTIFICATION) {
      permissionStatus = await _getNotificationPermission();
    }
    if (permissionStatus != null) {
      final RabblePermissionStatus rabbleStatus =
          RabblePermissionStatusFromPermissionStatus(permissionStatus);
      notificaitonPermissionStatus$.add(rabbleStatus);
    }
    if (permissionStatus != null &&
        permissionStatus == PermissionStatus.denied) {
      return RabblePermissionStatus.DENIED;
    } else if (permissionStatus != null &&
        permissionStatus == PermissionStatus.permanentlyDenied)
      return RabblePermissionStatus.PERMANENTLYDENIED;
    return RabblePermissionStatus.GRANTED;
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.permanentlyDenied &&
        permission != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<PermissionStatus> _getLocationPermission() async {
    PermissionStatus permission = await Permission.location.status;
    if (permission != PermissionStatus.permanentlyDenied &&
        permission != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.location.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<PermissionStatus> _getNotificationPermission() async {
    // if (Platform.isIOS) {
    //   final setting = await FirebaseNotifications().requestPermissionsIOS();
    //   if (setting.authorizationStatus == AuthorizationStatus.authorized)
    //     return PermissionStatus.granted;
    //   else
    //     return PermissionStatus.denied;
    // } else
    return Permission.notification.request();
  }

  Future<PermissionStatus> _getStoragePermission() async {
    PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.permanentlyDenied &&
        permission != PermissionStatus.granted) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<PermissionStatus> _getPhotoPermission() async {
    if (Platform.isIOS) {
      return Permission.photos.request();
    } else {
      return Permission.storage.request();
    }
  }

  Future<RabblePermissionStatus> checkPermissionStatus(
      RabblePermission permission) async {
    PermissionStatus? permissionStatus;
    if (permission == RabblePermission.CONTACTS) {
      permissionStatus = await Permission.contacts.status;
    }
    if (permission == RabblePermission.STORAGE) {
      permissionStatus = await Permission.storage.status;
    }
    if (permission == RabblePermission.NOTIFICATION) {
      // if (Platform.isIOS) {
      //   final status =
      //       await FirebaseNotifications().notificationPermissionStatus();
      //   if (status == AuthorizationStatus.authorized)
      //     permissionStatus = PermissionStatus.granted;
      //   else
      //     permissionStatus = PermissionStatus.denied;
      // } else
      permissionStatus = await Permission.notification.status;
      if (permissionStatus != null) {
        final RabblePermissionStatus RabbleStatus =
            RabblePermissionStatusFromPermissionStatus(permissionStatus);
        notificaitonPermissionStatus$.add(RabbleStatus);
      }
    }
    if (permission == RabblePermission.PHOTO) {
      if (Platform.isIOS)
        permissionStatus = await Permission.photos.status;
      else
        permissionStatus = await Permission.storage.status;
    }
    if (permission == RabblePermission.LOCATION) {
      permissionStatus = await Permission.location.status;
    }
    // Denied or expired https://github.com/Baseflow/flutter-permission-handler/wiki/Changes-in-6.0.0
    return RabblePermissionStatusFromPermissionStatus(permissionStatus);
  }

  RabblePermissionStatus RabblePermissionStatusFromPermissionStatus(
      PermissionStatus? permissionStatus) {
    if (permissionStatus == PermissionStatus.denied)
      return RabblePermissionStatus.DENIED;
    else if (permissionStatus == PermissionStatus.permanentlyDenied ||
        permissionStatus == PermissionStatus.restricted)
      return RabblePermissionStatus.PERMANENTLYDENIED;
    return RabblePermissionStatus.GRANTED;
  }

  Future<void> showStorageDeniedPermissionDialog(BuildContext context) {
    if (Platform.isIOS) {
      return permissionDialog(
        context,
        'Please allow us access to your Files on you device.\n\n'
        "You can change permissions any time in your phone's settings under \"Files\".",
      );
    } else {
      return permissionDialog(
        context,
        'Please allow us access to your Photos, Files and Media on you device.\n\n'
        "You can change permissions any time in your phone's settings under \"Storage\".",
      );
    }
  }

  Future<void> showPhotosDeniedPermissionDialog(BuildContext context) {
    if (Platform.isIOS) {
      return permissionDialog(
        context,
        'Please allow us access to your Photos on you device.\n\n'
        "You can change permissions any time in your phone's settings under \"Photos\".",
      );
    } else {
      return permissionDialog(
        context,
        'Please allow us access to your Photos, Files and Media on you device.\n\n'
        "You can change permissions any time in your phone's settings under \"Storage\".",
      );
    }
  }

  Future<void> showNotificationDeniedPermissionDialog(BuildContext context) {
    return permissionDialog(
      context,
      'Please allow us access to Notifications on your device.\n\n'
      "You can change permissions any time in your phone's settings under \"Notifications\".",
    );
  }

  Future<void> showContactsDeniedPermissionDialog(BuildContext context) {
    return permissionDialog(
      context,
      'Please allow us to access contact to find friends who are on Rabble, OR you can SKIP this screen\n\n'
      "You can change permissions any time in your phone's settings under \"Contacts\".",
    );
  }

  Future<void> permissionDialog(BuildContext context, String bodyContent) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return RabbleInfoDialog(
          content: RabbleText.subHeaderText(
            text: bodyContent,
            fontSize: 10.sp,
          ),
          actions: [
            RabbleDialogButton(
              label: 'GO TO SETTINGS',
              onPressed: () async {
                await openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}
