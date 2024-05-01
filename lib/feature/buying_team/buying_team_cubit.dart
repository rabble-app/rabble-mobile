import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/UserTeamModel.dart';
import 'package:rxdart/rxdart.dart';

class BuyingTeamCubit extends RabbleBaseCubit with Validators {
  BuyingTeamCubit({this.fetchBuyingTeam}) : super(RabbleBaseState.idle()) {
    if (fetchBuyingTeam != null && fetchBuyingTeam!) fetchPostalCode();
  }

  bool? fetchBuyingTeam = false;

  BehaviorSubject<List<BuyingTeamDetail>> buyingTeamListSubject$ =
      BehaviorSubject<List<BuyingTeamDetail>>();

  BehaviorSubject<List<HostTeamData>> hostTeamListSubject$ =
      BehaviorSubject<List<HostTeamData>>();

  final postalCodeSubject = BehaviorSubject<String>.seeded('');

  Future<void> fetchPostalCode() async {
    var postalCode = await RabbleStorage().getPostalCode();
    if (postalCode != null) {
      PostalCodeService().postalCodeGlobalSubject.sink.add(postalCode!);
      postalCodeSubject.sink.add(postalCode!);
    }
    fetchBuyingTeamList();
  }

  Future<void> fetchBuyingTeamList() async {
    emit(RabbleBaseState.secondaryBusy());
    var buyingTeamRes =
        await buyingTeamRepo.fetchBuyingTeamList(postalCodeSubject.value,errorCallBack: (){
          emit(RabbleBaseState.idle());
        });
    if (buyingTeamRes!.statusCode == 200 && buyingTeamRes.data != null) {
      buyingTeamListSubject$.sink.add(buyingTeamRes.data!);
    }
    emit(RabbleBaseState.idle());
  }

  BehaviorSubject<String> selectedCountryImage$ = BehaviorSubject<String>();
  BehaviorSubject<String> selectedCountryCode$ =
      BehaviorSubject<String>.seeded('44');

  final BehaviorSubject<String> _phoneC = BehaviorSubject();

  Function(String) get phoneC => _phoneC.sink.add;

  Stream<String> get phoneStream => _phoneC.transform(validatePhone);

  ///Login
  Stream<bool> get validFPField => Rx.combineLatest([phoneStream], (p) => true);

  final BehaviorSubject<String> groupNameSubject$ =
      BehaviorSubject<String>.seeded('');

  BehaviorSubject<bool> focus$ = BehaviorSubject<bool>.seeded(false);

  Future<bool> onAddTeam(String? teamId, String? id, String status) async {
    emit((RabbleBaseState.secondaryBusy()));

    Map<String, dynamic> body = {'userId': id, 'teamId': teamId};
    var addTeamRes = await userRepo.addToTeam(throwOnError: true, body: body,errorCallBack: (){
      emit(RabbleBaseState.idle());
    });
    if (addTeamRes!.status == 201) {
      globalBloc.showSuccessSnackBar(message: addTeamRes.message);
      return true;
    }
    emit((RabbleBaseState.idle()));
    return false;
  }

  Future<void> removeFromTeam(String teamId,{bool? moveHome}) async {
    emit((RabbleBaseState.tertiaryBusy()));
    var skipNextDeliveryRes =
        await userRepo.quiteTeam(throwOnError: true, id: teamId,errorCallBack: (){
          emit(RabbleBaseState.idle());
        });
    if (skipNextDeliveryRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: skipNextDeliveryRes.message);
      if(moveHome!=null && moveHome){
        NavigatorHelper().navigateAnClearAll('/home');
      }
    }
    emit((RabbleBaseState.idle()));
  }

  Future<void> nudgeTeamMember(String teamName, String memberNumber,String orderId) async {
    emit((RabbleBaseState.secondaryBusy()));
    Map<String, dynamic> body = {
      'teamName': teamName,
      'orderId': orderId,
      'memberPhone': memberNumber
    };

    var skipNextDeliveryRes =
        await userRepo.nudgeTeamMember(throwOnError: true, body: body,errorCallBack: (){
          emit(RabbleBaseState.idle());
        });
    if (skipNextDeliveryRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: skipNextDeliveryRes.message);
      NavigatorHelper().pop();
    }
    emit((RabbleBaseState.idle()));
  }
}
