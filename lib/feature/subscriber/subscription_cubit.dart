import 'package:rabble/config/export.dart';
import 'package:rxdart/rxdart.dart';

class SubscriptionCubit extends RabbleBaseCubit with Validators {
  SubscriptionCubit() : super(RabbleBaseState.idle()) {
    fetchUserData();
  }

  final BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject();
  final BehaviorSubject<bool> skipDeliverySubject$ =
      BehaviorSubject.seeded(false);

  Future<void> fetchUserData() async {
    emit(RabbleBaseState.primaryBusy());
    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));
    userDataSubject$.sink.add(userModel);
    emit(RabbleBaseState.idle());
  }

  Future<void> skipNextDeliver(String id) async {
    emit((RabbleBaseState.secondaryBusy()));
    var skipNextDeliveryRes = await userRepo.skipNextDeliver(
        throwOnError: true,
        id: id,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (skipNextDeliveryRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: skipNextDeliveryRes.message);
      skipDeliverySubject$.sink.add(true);
    }
    emit((RabbleBaseState.idle()));
  }

  Future<void> quiteTeam(String id) async {
    emit((RabbleBaseState.tertiaryBusy()));
    var skipNextDeliveryRes = await userRepo.quiteTeam(
        throwOnError: true,
        id: id,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (skipNextDeliveryRes!.status == 200) {
      NavigatorHelper().navigateAnClearAll('/home');
    }
    emit((RabbleBaseState.idle()));
  }
}
