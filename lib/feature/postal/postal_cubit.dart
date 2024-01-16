import 'package:rabble/config/export.dart';
import 'package:rabble/feature/branch/welcome_to_team_sheet.dart';
import 'package:rxdart/rxdart.dart';

class PostalCubit extends RabbleBaseCubit with Validators {
  PostalCubit() : super(RabbleBaseState.idle()) {
    fetchPostalCode();
  }

  BehaviorSubject<bool> focus$ = BehaviorSubject<bool>.seeded(false);

  final TextEditingController postalController = TextEditingController();

  final BehaviorSubject<String> postalCodeSubject = BehaviorSubject();

  Function(String) get postalCodeC => postalCodeSubject.sink.add;

  Stream<String> get postalCodeStream =>
      postalCodeSubject.transform(validateEmpty);

  Stream<bool> get validPostalCodeField =>
      Rx.combineLatest([postalCodeStream], (p) => true).onErrorReturn(false);

  BehaviorSubject<UserModel> userModelSubject$ = BehaviorSubject<UserModel>();

  Future<void> fetchPostalCode() async {
    var data = await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    Map<String, dynamic> response = json.decode(data.toString().trim());

    UserModel userData = UserModel.fromJson(response);
    if (userData.postalCode != null) {
      PostalCodeService()
          .postalCodeGlobalSubject
          .sink
          .add(userData.postalCode!);
    }
    userModelSubject$.sink.add(userData);
  }

  Future<void> updatePostalCode() async {
    String postalCode = postalCodeSubject.value;
    String number = userModelSubject$.value.phone!;
    emit(RabbleBaseState.secondaryBusy());
    var addressRes = await addressRepo
        .updatePostalCode(number, postalCode.trim(), throwOnError: true,
            errorCallBack: () {
      emit(RabbleBaseState.idle());
    });

    if (addressRes!.status == 200) {
      UserModel userData = UserModel.fromJson(addressRes.data);
      await RabbleStorage.storePostalCode(userData.postalCode!);
      PostalCodeService()
          .postalCodeGlobalSubject
          .sink
          .add(userData.postalCode!);
      emit(RabbleBaseState.changePostalCode());

      await RabbleStorage.storeDynamicValue(
          RabbleStorage.userKey, jsonEncode(userData));
      PostalCodeService().ispostalCodeChangedGlobalSubject.sink.add(true);

      globalBloc.postalCodeChanged.sink.add(true);
      NavigatorHelper().pop();
    }
    globalBloc.showSuccessSnackBar(message: addressRes.message);
    emit(RabbleBaseState.idle());
  }

  Future<void> addPostalCode(BuildContext context, InvitationData? data) async {
    String postalCode = postalCodeSubject.value;
    String number = userModelSubject$.value.phone!;
    emit(RabbleBaseState.secondaryBusy());
    var addressRes = await addressRepo
        .updatePostalCode(number, postalCode.trim(), throwOnError: true,
            errorCallBack: () {
      emit(RabbleBaseState.idle());
    });

    if (addressRes!.status == 200) {
      UserModel userData = UserModel.fromJson(addressRes.data);
      await RabbleStorage.storePostalCode(userData.postalCode!);
      PostalCodeService()
          .postalCodeGlobalSubject
          .sink
          .add(userData.postalCode!);

      await RabbleStorage.storeDynamicValue(
          RabbleStorage.userKey, jsonEncode(userData));

      Map<String, dynamic> body = {
        'userId': userData.id,
        'teamId': data!.teamId,
        'status': 'APPROVED'
      };

      var addTeamRes = await userRepo.addMember(
          throwOnError: true,
          body: body,
          errorCallBack: () {
            emit(RabbleBaseState.idle());
          });

      if (addTeamRes!.statusCode == 200) {
        globalBloc.showSuccessSnackBar(message: addressRes.message);

        CustomBottomSheet.showAccountBottomModelSheet(
            context, WelcomeToTeamSheet(data), false,
            isRemove: false);
      }
    } else {
      globalBloc.showSuccessSnackBar(message: addressRes.message);
      emit(RabbleBaseState.idle());
    }
  }
}
