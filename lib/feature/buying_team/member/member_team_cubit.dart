import 'package:rabble/core/config/export.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rabble/domain/entities/UserTeamModel.dart' as team;

class MemberTeamCubit extends RabbleBaseCubit with Validators {
  MemberTeamCubit() : super(RabbleBaseState.idle()) {
    fetchUserData();
    fetchMemberTeams();
  }




  BehaviorSubject<List<team.HostTeamData>> memberTeamListSubject$ =
  BehaviorSubject<List<team.HostTeamData>>();
  BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject<UserModel>();

  Future<void> fetchMemberTeams() async {
    emit(RabbleBaseState.primaryBusy());
    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    var buyingTeamRes = await buyingTeamRepo.fetchMembersTeam(userModel.id!,errorCallBack: (){
      emit(RabbleBaseState.idle());
    });
    if (buyingTeamRes!.statusCode == 200 && buyingTeamRes.data != null) {
      memberTeamListSubject$.sink.add(buyingTeamRes.data!);
    }
    emit(RabbleBaseState.idle());
  }

  Future<void> fetchUserData() async {
    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));
    userDataSubject$.sink.add(userModel);
  }

  getStatus(List<team.Members>? members) {
    UserModel userModel = userDataSubject$.value;
    team.Members? member =
    members!.firstWhere((element) => element.userId == userModel.id, orElse: () => team.Members());
    if (member != null && member.id!=null) {

      return member.status;
    } else {
      return '';
    }
  }
}
