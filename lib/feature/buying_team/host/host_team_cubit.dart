import 'package:rabble/core/config/export.dart';
import 'package:rxdart/rxdart.dart';

class HostTeamCubit extends RabbleBaseCubit with Validators {
  HostTeamCubit() : super(RabbleBaseState.idle()) {
    fetchHost();
  }

  BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject<UserModel>();



  BehaviorSubject<List<BuyingTeamDetail>> hostTeamListSubject$ =
  BehaviorSubject<List<BuyingTeamDetail>>();

  Future<void> fetchHost() async {
    emit(RabbleBaseState.primaryBusy());
    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    userDataSubject$.sink.add(userModel);
    var buyingTeamRes = await buyingTeamRepo.fetchHostTeam(userModel.id!,errorCallBack: (){
      emit(RabbleBaseState.idle());
    });
    if (buyingTeamRes!.statusCode == 200 && buyingTeamRes.data != null) {
      hostTeamListSubject$.sink.add(buyingTeamRes.data!);
    }
    emit(RabbleBaseState.idle());
  }

  getStatus(List<Members>? members) {
    Members? member = members!.firstWhere(
        (element) => element.userId == userDataSubject$.value.id,
        orElse: () => Members());
    if (member != null && member.id != null) {
      return member.status;
    } else {
      return '';
    }
  }
}
