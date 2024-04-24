import 'package:rabble/core/config/export.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/RequestSendModel.dart';

class RequestToJoinCubit extends RabbleBaseCubit with Validators {
  RequestToJoinCubit() : super(RabbleBaseState.idle());

  final BehaviorSubject<List<RequestSendData>> myRequestListSubject$ =
      BehaviorSubject<List<RequestSendData>>.seeded([]);

  final BehaviorSubject<String> introduceSubject$ = BehaviorSubject();

  Function(String) get introduceC => introduceSubject$.sink.add;

  Stream<String> get groupNameStream =>
      introduceSubject$.transform(validateGroupName);

  Stream<bool> get validGroupNameField =>
      Rx.combineLatest([groupNameStream], (p) => true).onErrorReturn(false);

  Future<void> requestToJoin(String teamId) async {
    emit(RabbleBaseState.secondaryBusy());
    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    Map<String, dynamic> body = {
      'userId': userModel.id,
      'teamId': teamId,
      'introduction': introduceSubject$.value
    };
    var requestRes =
        await userRepo.requestToJoinTeam(body: body, throwOnError: true,errorCallBack: (){
          emit(RabbleBaseState.idle());
        });

    if (requestRes!.status == 201) {
      globalBloc.showSuccessSnackBar(message: requestRes.message);
      NavigatorHelper().pop(result: true);
    }

    emit(RabbleBaseState.idle());
  }

  BehaviorSubject<List<RequestData>> requestListSubject$ =
      BehaviorSubject<List<RequestData>>.seeded([]);



  Future<bool> onUpdateTeam(String? teamId, String? id, String status) async {
    emit((RabbleBaseState.secondaryBusy()));

    Map<String, dynamic> body = {'id': id, 'status': status};
    var addTeamRes = await userRepo.updateTeam(throwOnError: true, body: body,errorCallBack: (){
      emit(RabbleBaseState.idle());
    });
    if (addTeamRes!.status == 201) {
      globalBloc.showSuccessSnackBar(message: addTeamRes.message);
      return true;
    }
    emit((RabbleBaseState.idle()));
    return false;
  }


}
