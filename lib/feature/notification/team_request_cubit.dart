import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';

class TeamRequestTabCubit extends RabbleBaseCubit {
  TeamRequestTabCubit() : super(RabbleBaseState.idle()) {
    fetchRequest();
  }

  BehaviorSubject<int> selectedTapSubject$ = BehaviorSubject<int>.seeded(0);
  BehaviorSubject<UserModel> currentUserDataSubject$ = BehaviorSubject();
  BehaviorSubject<List<RequestSendData>> requestListSubject$ =
      BehaviorSubject<List<RequestSendData>>.seeded([]);

  Future<void> fetchRequest() async {
    emit(RabbleBaseState.primaryBusy());

    var userData =
        await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    RequestSendModel? res = await userRepo.fetchMyRequest(
        userId: userModel.id,
        throwOnError: true,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (res!.statusCode == 200) {
      if (res.data!.isNotEmpty) {
        requestListSubject$.sink.add(res.data!);
        currentUserDataSubject$.sink.add(userModel);
      }
    }
    emit(RabbleBaseState.idle());
  }

  Future<void> onUpdateTeam(String? teamId, String? id, String status, BuildContext ctx) async {
    showDialog(
      context: ctx,
      barrierDismissible: false,
      // determines if outside tap will close the dialog
      builder: (BuildContext context) {
        Map<String, dynamic> body = {'id': id, 'status': status};
        userRepo
            .updateTeam(
                throwOnError: true,
                body: body,
                errorCallBack: () {
                  emit(RabbleBaseState.idle());
                })
            .then((addTeamRes) {
          Navigator.pop(context);
          if (addTeamRes!.status == 200) {
//            fetchRequest();
            List<RequestSendData> tempList =
                requestListSubject$.hasValue ? requestListSubject$.value : [];

            tempList.removeWhere((element) => element.id == id);

            requestListSubject$.sink.add(tempList);
          }
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          // makes the dialog background transparent
          elevation: 0,
          child: Container(
            color: Colors.transparent,
            // this makes the container inside the dialog transparent
            alignment: Alignment.center,
            // this aligns the logo to the center of the screen
            child: SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(
                color: APPColors.appPrimaryColor,
                backgroundColor: APPColors.appPrimaryColor,
              ),
            ), // your logo asset here
          ),
        );
      },
    );
  }
}
