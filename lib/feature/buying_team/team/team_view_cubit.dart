import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/TeamModel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/RequestSendModel.dart';

class TeamViewCubit extends RabbleBaseCubit with Validators {
  TeamViewCubit({required this.teamId}) : super(RabbleBaseState.idle()) {
    if(teamId.isNotEmpty) {
      fetchTeamDetail();
    }
  }

  BehaviorSubject<TeamData> teamDataSubject$ = BehaviorSubject<TeamData>();
  BehaviorSubject<CurrentOrderData> currentOrderSubject$ =
      BehaviorSubject<CurrentOrderData>();
  BehaviorSubject<UserModel> currentUserDataSubject$ =
      BehaviorSubject<UserModel>();

  BehaviorSubject<Members> isMyTeam = BehaviorSubject<Members>();

  BehaviorSubject<RequestSendData> isMyRequest =
      BehaviorSubject<RequestSendData>();


  BehaviorSubject<bool> isUpdate = BehaviorSubject<bool>.seeded(false);

  BehaviorSubject<List<List<TempBoxData>>> allTempBoxList =
      BehaviorSubject<List<List<TempBoxData>>>.seeded([]);
  final String teamId;

  Future<void> fetchTeamDetail() async {
    emit(RabbleBaseState.primaryBusy());
    TeamModel? fetchTeamRes =
        await buyingTeamRepo.fetchBuyingTeamDetail(teamId, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (fetchTeamRes!.statusCode == 200 && fetchTeamRes.data != null) {
      var userData =
          await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
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
      fetchCurrentOrderData();
    } else {
      emit(RabbleBaseState.idle());
    }
  }

  final BehaviorSubject<List<TempBoxData>> purchasedUserListSubject$ =
      BehaviorSubject<List<TempBoxData>>();

  Future<void> fetchCurrentOrderData() async {
    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = userData != null
        ? UserModel.fromJson(jsonDecode(userData))
        : UserModel(id: '-1');
    currentUserDataSubject$.sink.add(userModel);
    OrderModel? fetchTeamRes =
        await buyingTeamRepo.fetchCurrentOrderDetail(teamId, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (fetchTeamRes!.statusCode == 200) {
      currentOrderSubject$.sink.add(fetchTeamRes.data!);

      if (fetchTeamRes.data!.partionedProducts != null &&
          fetchTeamRes.data!.partionedProducts!.isNotEmpty) {
        for (int i = 0; i < fetchTeamRes.data!.partionedProducts!.length; i++) {
          List<TempBoxData> tempList = [];

          var partionedProduct = fetchTeamRes.data!.partionedProducts![i];

          for (int j = 0;
              j < partionedProduct.partitionedProductUsersRecord!.length;
              j++) {
            var userRecord = partionedProduct.partitionedProductUsersRecord![j];
            var quantity = userRecord.quantity!;

            for (int k = 0; k < quantity; k++) {
              tempList.add(TempBoxData(
                  '${userRecord.owner!.firstName != null ? userRecord.owner!.firstName!.trim() : ''} ${userRecord.owner!.lastName != null ? userRecord.owner!.lastName!.trim() : ''}'));
            }
          }
          var t = allTempBoxList.value;

          t.add(tempList);
          allTempBoxList.sink.add(t);
        }

      }
    }
    emit(RabbleBaseState.idle());
  }

  Future<String> generateDeepLink(TeamData teamData) async {
    final branchUniversalObject = BranchUniversalObject(
        canonicalIdentifier: teamData.id ?? '',
        title: teamData.name ?? '',
        imageUrl: teamData.imageUrl ?? '',
        contentDescription: teamData.description ?? '',
        keywords: ['team_share']);

    final branchLinkProperties = BranchLinkProperties(
      feature: 'Share',
      channel: 'Rabble app',
      campaign: 'Invitation for team.',
    );

    final generatedLink = await FlutterBranchSdk.getShortUrl(
        linkProperties: branchLinkProperties, buo: branchUniversalObject);

    print('Generated deep link: ${generatedLink.result.toString()}');

    return generatedLink.result.toString();
  }

  Future<String> generateDeepLinkForProducer(ProducerDetail teamData) async {
    final branchUniversalObject = BranchUniversalObject(
        canonicalIdentifier: teamData.id ?? '',
        title: teamData.businessName ?? '',
        imageUrl: teamData.imageUrl ?? '',
        contentDescription: teamData.description ?? '',
        keywords: ['producer_share']);

    final branchLinkProperties = BranchLinkProperties(
      feature: 'Share Producer',
      channel: 'Rabble app',
      campaign: 'Share producer.',
    );

    final generatedLink = await FlutterBranchSdk.getShortUrl(
        linkProperties: branchLinkProperties, buo: branchUniversalObject);

    print('Generated deep link: ${generatedLink.result.toString()}');

    return generatedLink.result.toString();
  }

  final BehaviorSubject<String> _groupName = BehaviorSubject();
  final BehaviorSubject<bool> privateGroupStream = BehaviorSubject<bool>();

  Function(String) get groupNameC => _groupName.sink.add;

  Stream<String> get groupNameStream => _groupName.transform(validateGroupName);

  Stream<bool> get validGroupNameField =>
      Rx.combineLatest([groupNameStream], (p) => true).onErrorReturn(false);

  final BehaviorSubject<String> groupNameSubject$ =
      BehaviorSubject<String>.seeded('');

  Future<bool> updateTeamData(String teamId, Map<String, dynamic> body) async {
    emit((RabbleBaseState.primaryBusy()));

    var addTeamRes = await userRepo.updateTeamData(teamId,
        throwOnError: true, body: body, errorCallBack: () {
      emit((RabbleBaseState.idle()));
    });
    if (addTeamRes!.status == 200) {
      TeamData teamData = teamData$.value;
      teamData.isPublic = body['isPublic'];
      teamData$.sink.add(teamData);
      globalBloc.showSuccessSnackBar(message: addTeamRes.message);
      emit((RabbleBaseState.idle()));
      return true;
    }
    emit((RabbleBaseState.idle()));
    return false;
  }

  Future<void> nudgeTeam(String teamId) async {
    emit((RabbleBaseState.secondaryBusy()));
    var skipNextDeliveryRes = await userRepo.nudgeTeam(
        throwOnError: true,
        teamId: teamId,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (skipNextDeliveryRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: skipNextDeliveryRes.message);
    }
    emit((RabbleBaseState.idle()));
  }

  BehaviorSubject<TeamData> teamData$ = BehaviorSubject<TeamData>();

  Future<void> quiteTeam(String id) async {
    emit((RabbleBaseState.tertiaryBusy()));
    var skipNextDeliveryRes = await userRepo.quiteTeam(
        throwOnError: true,
        id: id,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (skipNextDeliveryRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: skipNextDeliveryRes.message);
      NavigatorHelper().navigateAnClearAll('/home');
    }
    emit((RabbleBaseState.idle()));
  }

  Future<void> updateTeam() async {}

  final BehaviorSubject<List<RequestSendData>> myRequestListSubject$ =
      BehaviorSubject<List<RequestSendData>>.seeded([]);

  Future<bool> onUpdateTeam(String? teamId, String? id, String status) async {
    emit((RabbleBaseState.secondaryBusy()));

    Map<String, dynamic> body = {'id': id, 'status': status};
    var addTeamRes = await userRepo.updateTeam(
        throwOnError: true,
        body: body,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (addTeamRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: addTeamRes.message);
      return true;
    }
    emit((RabbleBaseState.idle()));
    return false;
  }

  bool showMembers(TeamData teamData) {

    return teamData.members!.isNotEmpty &&
        teamData.members!.any((Members element) => element.userId == teamData.hostId);
  }

  getMyOrder(List<Basket> list, String? id) {
    return list.where((element) => element.userId == id).toList();
  }

  bool getQuantity(List<Basket> list, String? userId) {
    return list
        .any((element) => element.quantity! > 0 && userId == element.userId);
  }}
