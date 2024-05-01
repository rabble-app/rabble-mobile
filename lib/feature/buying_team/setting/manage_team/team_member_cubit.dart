import 'package:rabble/core/config/export.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/entities/RequestSendModel.dart';

class TeamMemberCubit extends RabbleBaseCubit with Validators {
  TeamMemberCubit() : super(RabbleBaseState.idle());

  BehaviorSubject<List<Members>> teamMemberSubject$ =BehaviorSubject<List<Members>>();
  BehaviorSubject<List<RequestSendData>> teamRequestSubject$ =BehaviorSubject<List<RequestSendData>>();
  final BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject();

  Future<void> fetchUserData() async {
    emit(RabbleBaseState.primaryBusy());
    var userData =
    await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));
    userDataSubject$.sink.add(userModel);
    emit(RabbleBaseState.idle());
  }


}
