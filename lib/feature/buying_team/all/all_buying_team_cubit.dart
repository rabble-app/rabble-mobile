import 'package:rabble/core/config/export.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/MySubscriptionModel.dart';

class AllBuyingTeamsCubit extends RabbleBaseCubit with Validators {
  AllBuyingTeamsCubit() : super(RabbleBaseState.idle()) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (!isEmpty) {
            offset = offset + 10;
            fetchAllBuyingTeamsForPostalCode();
          }
        }
      }
    });
  }

  BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject<UserModel>();

  BehaviorSubject<List<BuyingTeamDetail>> allTeamListSubject$ =
      BehaviorSubject<List<BuyingTeamDetail>>();

  BehaviorSubject<List<MySubscriptionData>> mySubscriptionListSubject$ =
      BehaviorSubject<List<MySubscriptionData>>();

  Future<void> fetchAllBuyingTeams() async {
    emit(RabbleBaseState.primaryBusy());
    var buyingTeamRes = await buyingTeamRepo.fetchAllTeams(errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (buyingTeamRes!.statusCode == 200 && buyingTeamRes.data != null) {
      allTeamListSubject$.sink.add(buyingTeamRes.data!);
    }
    emit(RabbleBaseState.idle());
  }

  Future<void> fetchAllBuyingTeamsForPostalCode() async {
    if (offset == 0) {
      emit(RabbleBaseState.primaryBusy());
    } else {
      emit(RabbleBaseState.tertiaryBusy());
    }
    var buyingTeamRes = await buyingTeamRepo.fetchAllBuyingTeamsForPostalCode(
        offset, PostalCodeService().postalCodeGlobalSubject.value ?? '',
        errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (buyingTeamRes!.statusCode == 200) {
      List<BuyingTeamDetail> tempList =
          allTeamListSubject$.hasValue ? allTeamListSubject$.value : [];

      if (buyingTeamRes.data!.isEmpty) {
        isEmpty = true;
      } else {
        tempList.addAll(buyingTeamRes.data!);
        allTeamListSubject$.sink.add(tempList);
      }
    }
    emit(RabbleBaseState.idle());
  }

  Future<void> fetchAllYourBuyingTeams(String id) async {
    if (id.isNotEmpty) {
      emit(RabbleBaseState.primaryBusy());
      var buyingTeamRes =
          await buyingTeamRepo.fetchAllMyTeams(id, errorCallBack: () {
        emit(RabbleBaseState.idle());
      });
      if (buyingTeamRes!.statusCode == 200 && buyingTeamRes.data != null) {
        allTeamListSubject$.sink.add(buyingTeamRes.data!);
      }
      emit(RabbleBaseState.idle());
    } else {
      fetchAllBuyingTeamsForPostalCode();
    }
  }

  Future<void> checkTeamExist(
    BuildContext context,
    String producerName,
    String producerId,
  ) async {
    emit(RabbleBaseState.primaryBusy());

    var teamExistRes = await userRepo.checkTeamExist(producerId,
        PostalCodeService().postalCodeGlobalSubject.value.toString(),
        throwOnError: true, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });

    if (teamExistRes!.statusCode == 200) {
      if (teamExistRes.data!.isNotEmpty) {
        allTeamListSubject$.sink.add(teamExistRes.data!);
      }
    }

    emit(RabbleBaseState.idle());
  }

  Future<void> fetchUserData() async {
    String status = await RabbleStorage
        .getLoginStatus() ??
        "0";
    if (status != '0') {
      var userData =
      await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
      UserModel userModel = UserModel.fromJson(jsonDecode(userData));

      userDataSubject$.sink.add(userModel);
    }
  }

  Future<void> fetchMuSubscribtion() async {
    emit(RabbleBaseState.primaryBusy());
    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    var buyingTeamRes = await buyingTeamRepo
        .fetchMySubscribtion(userModel.id.toString(), errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (buyingTeamRes!.statusCode == 200 && buyingTeamRes.data != null) {
      mySubscriptionListSubject$.sink.add(buyingTeamRes.data!);
    }
    emit(RabbleBaseState.idle());
  }

  ScrollController scrollController = ScrollController();
  int offset = 0;
  bool isEmpty = false;
}
