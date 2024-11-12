import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';
import 'package:rabble/domain/entities/distance_model.dart';
import 'package:rabble/domain/entities/hub/AllPartnerTeamsModel.dart';
import 'package:rabble/domain/entities/mock/mock_hub_model.dart';

class HubCubit extends RabbleBaseCubit {
  HubCubit() : super(RabbleBaseState.idle());

  final BehaviorSubject<String> postalCodeSubject = BehaviorSubject<String>();
  final BehaviorSubject<bool> visibleShareWidgetSubject =
      BehaviorSubject<bool>();
  BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject<UserModel>();

  Future<void> fetchPostalCode() async {
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
      if (userModel.postalCode != null && userModel.postalCode!.isNotEmpty) {}
    } else {
      postalCodeSubject.sink.add('');
    }
  }

  BehaviorSubject<List<PartnersTeamData>> partnerListSubject$ =
      BehaviorSubject<List<PartnersTeamData>>();

  Future<void> fetchPartnersTeam() async {
    emit(RabbleBaseState.secondaryBusy());

    AllPartnerTeamsModel? partnerRes = await hubRepo.fetchPartnersTeam(
        PostalCodeService().postalCodeGlobalSubject.value ?? '',
        errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (partnerRes!.statusCode == 200 && partnerRes.data != null) {
      partnerListSubject$.sink.add(partnerRes.data!);
    }
    emit(RabbleBaseState.idle());
  }

  Map<String, int> cachedDistances = {};
  BehaviorSubject<Map<String, int>> cachedDistancesSubject =
      BehaviorSubject.seeded({});

  BehaviorSubject<DistanceModel> distanceSubject = BehaviorSubject();

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

    distanceSubject.sink.add(distanceRes!);

    cachedDistances[partnerPostalCode] = distanceRes.metres!=null? distanceRes.metres!.toInt() : 0;
    cachedDistancesSubject.sink.add(cachedDistances);
  }

  BehaviorSubject<TeamData> teamDataSubject$ = BehaviorSubject<TeamData>();

  BehaviorSubject<Members> isMyTeam = BehaviorSubject<Members>();

  BehaviorSubject<RequestSendData> isMyRequest =
      BehaviorSubject<RequestSendData>();

  Future<void> fetchTeamDetail(String partnerId) async {
    emit(RabbleBaseState.primaryBusy());
    TeamModel? fetchTeamRes =
        await hubRepo.fetchPartnerTeamDetail(partnerId, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (fetchTeamRes!.statusCode == 200 && fetchTeamRes.data != null) {
      var userData =
          await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
      UserModel userModel = userData != null
          ? UserModel.fromJson(jsonDecode(userData))
          : UserModel(id: '-1');

      teamDataSubject$.sink.add(fetchTeamRes.data!);

      var isMy = fetchTeamRes.data!.members!
          .any((element) => element.userId == userModel.id);

      var isMyReq = fetchTeamRes.data!.requests!
          .any((element) => element.userId == userModel.id);

      if (isMy) {
        isMyTeam.sink.add(fetchTeamRes.data!.members!
            .firstWhere((element) => element.userId == userModel.id));
      }

      if (isMyReq) {
        isMyRequest.sink.add(fetchTeamRes.data!.requests!
            .firstWhere((element) => element.userId == userModel.id));
      }

      await fetchCurrentOrderData(partnerId);
    } else {
      emit(RabbleBaseState.idle());
    }
  }

  BehaviorSubject<CurrentOrderData> currentOrderSubject$ =
      BehaviorSubject<CurrentOrderData>();


  BehaviorSubject<UserModel> currentUserDataSubject$ =
      BehaviorSubject<UserModel>();

  Future<void> fetchCurrentOrderData(String partnerId) async {
    var userData =
        await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    UserModel userModel = userData != null
        ? UserModel.fromJson(jsonDecode(userData))
        : UserModel(id: '-1');
    currentUserDataSubject$.sink.add(userModel);
    OrderModel? fetchTeamRes =
        await hubRepo.fetchCurrentOrderDetail(partnerId, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (fetchTeamRes!.statusCode == 200 && fetchTeamRes.data != null) {
      currentOrderSubject$.sink.add(fetchTeamRes.data!);
    }
    emit(RabbleBaseState.idle());
  }

  getMyOrder(List<Basket> list, String? id) {
    return list.where((element) => element.userId == id).toList();
  }

  bool getQuantity(List<Basket> list, String? userId) {
    return list
        .any((element) => element.quantity! > 0 && userId == element.userId);
  }



  isMember(List<Members>? members,String userId) {
    if (members!.isEmpty) {
      return false;
    }


    Members? member = members.firstWhere(
        (element) =>
            element.userId == userId,
        orElse: () => Members());

    if (member != null && member.id != null) {
      return true;
    }

    return false;
  }

  Future<String> generateDeepLink(TeamData teamData) async {
    final branchUniversalObject = BranchUniversalObject(
        canonicalIdentifier: teamData.id ?? '',
        title: teamData.name ?? '',
        imageUrl: teamData.imageUrl ?? '',
        contentDescription: teamData.description ?? '',
        keywords: ['partner_share']);

    final branchLinkProperties = BranchLinkProperties(
      feature: 'Partner Share',
      channel: 'Rabble app',
      campaign: 'Invitation for partner team.',
    );

    final generatedLink = await FlutterBranchSdk.getShortUrl(
        linkProperties: branchLinkProperties, buo: branchUniversalObject);

    print('Generated deep link: ${generatedLink.result.toString()}');

    return generatedLink.result.toString();
  }

}
