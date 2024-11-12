import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/distance_model.dart';
import 'package:rabble/domain/entities/hub/AllPartnerTeamsModel.dart';

class ExploreCubit extends RabbleBaseCubit {
  ExploreCubit() : super(RabbleBaseState.idle());

  final BehaviorSubject<String> postalCodeSubject = BehaviorSubject<String>();
  final BehaviorSubject<bool> visibleShareWidgetSubject =
      BehaviorSubject<bool>();
  BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject<UserModel>();

  Future<void> fetchHomeData() async {
    try {
      final List<List<Object>> results = await Future.wait([
        fetchAllBuyingTeamsForPostalCode(),
        fetchProducerList(),
        fetchPartnersTeam(),
      ]);
      if (results[0].isNotEmpty) {
        allTeamListSubject$.sink.add(results[0] as List<BuyingTeamDetail>);
      }

      if (results[1].isNotEmpty) {
        producerListSubject$.sink.add(results[1] as List<ProducerDetail>);
      }

      if (results[2].isNotEmpty) {
        partnerListSubject$.sink.add(results[2] as List<PartnersTeamData>);
      }
    } finally {
      emit(RabbleBaseState.idle());
    }
  }

  Future<void> fetchHomeDataWithoutTeams() async {
    try {
      final List<List<Object>> results = await Future.wait([
        fetchProducerList(),
        fetchPartnersTeam(),
      ]);

      if (results[0].isNotEmpty) {
        producerListSubject$.sink.add(results[0] as List<ProducerDetail>);
      }

      if (results[1].isNotEmpty) {
        partnerListSubject$.sink.add(results[1] as List<PartnersTeamData>);
      }
    } finally {
      emit(RabbleBaseState.idle());
    }
  }

  Future<void> fetchPostalCode() async {
    emit(RabbleBaseState.primaryBusy());

    String status = await RabbleStorage().getLoginStatus() ?? "0";
    if (status != '0') {
      var postalCode = await RabbleStorage().getPostalCode();
      var visibleShare = await RabbleStorage().getStatusShareWidget() ?? '0';
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
          await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
      UserModel userModel = UserModel.fromJson(jsonDecode(userData));
      userDataSubject$.sink.add(userModel);
      if (userModel.postalCode != null && userModel.postalCode!.isNotEmpty) {
        await fetchHomeData();
      }
    } else {
      await fetchHomeDataWithoutTeams();
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

  Future<List<BuyingTeamDetail>> fetchAllBuyingTeamsForPostalCode() async {
    BuyingTeamModel? buyingTeamRes = await buyingTeamRepo
        .fetchAllBuyingTeamsForPostalCode(0, postalCodeSubject.value ?? '',
            errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    PostalCodeService().ispostalCodeChangedGlobalSubject.sink.add(false);
    if (buyingTeamRes!.statusCode == 200 && buyingTeamRes.data != null) {
      return buyingTeamRes.data!;
    }
    return [];
  }

  BehaviorSubject<List<ProducerDetail>> producerListSubject$ =
      BehaviorSubject<List<ProducerDetail>>();

  BehaviorSubject<List<PartnersTeamData>> partnerListSubject$ =
      BehaviorSubject<List<PartnersTeamData>>();

  Future<List<ProducerDetail>> fetchProducerList() async {
    ProducerModel? producerRes = await producerRepo.fetchProducerList(
        0, PostalCodeService().postalCodeGlobalSubject.value ?? '',
        errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (producerRes!.statusCode == 200) {
      return producerRes.data!;
    }
    return [];
  }

  Future<List<PartnersTeamData>> fetchPartnersTeam() async {
    AllPartnerTeamsModel? partnerRes = await hubRepo.fetchPartnersTeam(
        PostalCodeService().postalCodeGlobalSubject.value ?? '',
        errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (partnerRes!.statusCode == 200) {


      return partnerRes.data!;
    }
    return [];
  }

  Future<void> fetchPartners() async {
    emit(RabbleBaseState.secondaryBusy());

    AllPartnerTeamsModel? partnerRes = await hubRepo.fetchPartnersTeam(
        PostalCodeService().postalCodeGlobalSubject.value ?? '',
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (partnerRes!.statusCode == 200) {
      partnerListSubject$.sink.add(partnerRes.data!);
    }
    emit(RabbleBaseState.idle());

  }

  Map<String, int> cachedDistances = {};
  BehaviorSubject<Map<String, int>> cachedDistancesSubject =
      BehaviorSubject.seeded({});

  Future<void> calculateDistanceFromPostalCode(
      String partnerPostalCode, int index) async {
    // Check if distance for this partner is cached
    if (cachedDistances.containsKey(partnerPostalCode)) {
      return;
    }

    String userPostalCode = await RabbleStorage().getPostalCode();

    DistanceModel? distanceRes = await buyingTeamRepo
        .calculateDistanceFromPostalCode(partnerPostalCode, userPostalCode,
            errorCallBack: () {});

    print(distanceRes?.metres.toString());

    // Update cache and notify subject
    cachedDistances[partnerPostalCode] = distanceRes!.metres!.toInt();
    cachedDistancesSubject.sink.add(cachedDistances);
  }
}
