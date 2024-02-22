import 'package:rabble/config/export.dart';

class HomeCubit extends RabbleBaseCubit {
  HomeCubit() : super(RabbleBaseState.idle());
  BehaviorSubject<int> selectedIndex$ = BehaviorSubject.seeded(0);

  BehaviorSubject<List<NotificationData>> notificationsListSubject$ =
      BehaviorSubject<List<NotificationData>>.seeded([]);

  Future<void> fetchNotifications() async {
    String status = await RabbleStorage.getLoginStatus() ?? "0";
    if (status != '0') {
      emit(RabbleBaseState.primaryBusy());
      globalBloc.isNotifcation.sink.add(false);

      var userData =
          await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
      UserModel userModel = UserModel.fromJson(jsonDecode(userData));

      NotificationModel? res = await userRepo.fetchMyNotifications(
          userId: userModel.id,
          throwOnError: true,
          errorCallBack: () {
            emit(RabbleBaseState.idle());
          });
      if (res!.statusCode == 200) {
        if (res.data!.isNotEmpty) {
          notificationsListSubject$.sink.add(res.data!);
        }
      }
      emit(RabbleBaseState.idle());
    }
  }

  getTitle(int? index) {
    if (index == 0) {
      return 'Explore';
    }

    if (index == 1) {
      return 'Teams';
    }

    if (index == 2) {
      return 'Messages';
    }

    return 'My Rabble';
  }
}
