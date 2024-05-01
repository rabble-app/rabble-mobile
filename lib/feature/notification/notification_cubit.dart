import 'package:rabble/core/config/export.dart';

class NotificationTabCubit extends RabbleBaseCubit {
  NotificationTabCubit() : super(RabbleBaseState.idle());

  BehaviorSubject<int> selectedTapSubject$ = BehaviorSubject<int>.seeded(0);
  BehaviorSubject<List<NotificationData>> notificationsListSubject$ =
      BehaviorSubject<List<NotificationData>>.seeded([]);

  Future<void> fetchNotifications() async {
    emit(RabbleBaseState.primaryBusy());

    var userData =
        await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
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

  Future<void> readNotifications() async {
    globalBloc.isNotifcation.sink.add(false);

    var userData =
        await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    await userRepo.readMyNotifications(
        userId: userModel.id, throwOnError: true, errorCallBack: () {});
  }
}
