import 'package:rabble/core/config/export.dart';

class ExploreCubit extends RabbleBaseCubit {
  ExploreCubit() : super(RabbleBaseState.idle());

  final BehaviorSubject<String> postalCodeSubject =
      BehaviorSubject<String>();
  final BehaviorSubject<bool> visibleShareWidgetSubject =
      BehaviorSubject<bool>();
  BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject<UserModel>();

  Future<void> fetchPostalCode() async {
    String status = await RabbleStorage.getLoginStatus() ?? "0";
    if (status != '0') {
      var postalCode = await RabbleStorage.getPostalCode();
      var visibleShare = await RabbleStorage.getStatusShareWidget() ?? '0';
      if (postalCode != null) {
        PostalCodeService().postalCodeGlobalSubject.sink.add(postalCode!);
        postalCodeSubject.sink.add(postalCode!);
      }

      if (visibleShare == '1') {
        visibleShareWidgetSubject.sink.add(false);
      } else {
        visibleShareWidgetSubject.sink.add(true);
      }

      var userData =
          await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
      UserModel userModel = UserModel.fromJson(jsonDecode(userData));
      userDataSubject$.sink.add(userModel);
      if (userModel.postalCode != null && userModel.postalCode!.isNotEmpty) {
        fetchAllBuyingTeamsForPostalCode();
      }
    }else{
      postalCodeSubject.sink.add('');

    }
  }

  BehaviorSubject<List<BuyingTeamDetail>> allTeamListSubject$ =
      BehaviorSubject<List<BuyingTeamDetail>>.seeded([]);

  Future<void> fetchAllBuyingTeams() async {
    emit(RabbleBaseState.primaryBusy());
    BuyingTeamModel? buyingTeamRes =
        await buyingTeamRepo.fetchAllTeams(errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (buyingTeamRes!.statusCode == 200 && buyingTeamRes.data != null) {
      allTeamListSubject$.sink.add(buyingTeamRes.data!);
    }
    emit(RabbleBaseState.idle());
  }

  Future<void> fetchAllBuyingTeamsForPostalCode() async {
    emit(RabbleBaseState.primaryBusy());
    BuyingTeamModel? buyingTeamRes = await buyingTeamRepo
        .fetchAllBuyingTeamsForPostalCode(0, postalCodeSubject.value ?? '',
            errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    PostalCodeService().ispostalCodeChangedGlobalSubject.sink.add(false);
    if (buyingTeamRes!.statusCode == 200 && buyingTeamRes.data != null) {
      allTeamListSubject$.sink.add(buyingTeamRes.data!);
    }
    emit(RabbleBaseState.idle());
  }
}
