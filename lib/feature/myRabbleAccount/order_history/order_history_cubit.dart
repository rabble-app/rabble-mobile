import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/OrderHistoryModel.dart';
import 'package:rxdart/rxdart.dart';

class OrderHistoryCubit extends RabbleBaseCubit with Validators {
  OrderHistoryCubit() : super(RabbleBaseState.idle()) {
    fetchUserData();
  }

  BehaviorSubject<List<OrderHistoryData>> orderHistoryListSubject$ =
      BehaviorSubject<List<OrderHistoryData>>();
  BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject<UserModel>();

  Future<void> fetchUserData() async {
    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    userDataSubject$.sink.add(userModel);
    fetchOrderHistory(userModel.id);
  }

  Future<void> fetchOrderHistory(String? id) async {
    emit(RabbleBaseState.primaryBusy());
    var hsitoryTeamRes =
        await userRepo.fetchOrderHistory(userId: id!, throwOnError: true,errorCallBack: (){
          emit(RabbleBaseState.idle());
        });
    if (hsitoryTeamRes!.statusCode == 200 && hsitoryTeamRes.data != null) {
      orderHistoryListSubject$.sink.add(hsitoryTeamRes.data!);
    }
    emit(RabbleBaseState.idle());
  }
}
