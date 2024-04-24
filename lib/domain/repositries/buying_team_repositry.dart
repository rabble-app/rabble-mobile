import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/BulkUploadedModel.dart';
import 'package:rabble/domain/entities/TeamCreationModel.dart';
import 'package:rabble/domain/entities/TeamModel.dart';
import 'package:rabble/domain/entities/UserTeamModel.dart';

import '../entities/MySubscriptionModel.dart';

class BuyingTeamRepository extends BaseRepository {
  final ApiProvider _apiProvider = ApiProvider();

  @throws
  Future<BuyingTeamModel?> fetchBuyingTeamList(String postalCode,{ VoidCallback? errorCallBack}) async {
    BuyingTeamModel? status =
        await _apiProvider.fetchBuyingTeamList(postalCode,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<UserTeamModel?> fetchMembersTeam(String id,{ VoidCallback? errorCallBack}) async {
    UserTeamModel? status =
    await _apiProvider.fetchMembersTeam(id,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BuyingTeamModel?> fetchHostTeam(String id,{ VoidCallback? errorCallBack}) async {
    BuyingTeamModel? status =
    await _apiProvider.fetchHostTeam(id,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }


  @throws
  Future<TeamCreationModel?> createTeam(Map<String, dynamic> body,VoidCallback? errorCallBack,) async {
    TeamCreationModel? status =
    await _apiProvider.createTeam(body,throwOnError: true,errorCallBack: (){
      errorCallBack!.call();
    });
    return status;
  }



  @throws
  Future<BulkUploadedModel?> uploadProducts(Map<String, dynamic> body,VoidCallback? errorCallBack,) async {
    BulkUploadedModel? status =
    await _apiProvider.uploadProducts(body,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }


  @throws
  Future<BulkUploadedModel?> updateBasket(Map<String, dynamic> body,VoidCallback? errorCallBack,) async {
    BulkUploadedModel? status =
    await _apiProvider.updateBasket(body,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }


  @throws
  Future<TeamModel?> fetchBuyingTeamDetail(String teamId,{ VoidCallback? errorCallBack}) async {
    TeamModel? status =
    await _apiProvider.fetchBuyingTeamDetail(teamId,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }
  @throws
  Future<OrderModel?> fetchCurrentOrderDetail(String teamId,{ VoidCallback? errorCallBack}) async {
    OrderModel? status =
    await _apiProvider.fetchCurrentOrderDetail(teamId,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BuyingTeamModel?> fetchAllTeams({ VoidCallback? errorCallBack}) async {
    BuyingTeamModel? status =
    await _apiProvider.fetchAllTeams(throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BuyingTeamModel?> fetchAllBuyingTeamsForPostalCode(int offset,String postalCode,{ VoidCallback? errorCallBack}) async {
    BuyingTeamModel? status =
    await _apiProvider.fetchAllBuyingTeamsForPostalCode(offset,postalCode,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BuyingTeamModel?> fetchAllMyTeams(String id,{VoidCallback? errorCallBack}) async {
    BuyingTeamModel? status =
    await _apiProvider.fetchAllMyTeams(id,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<MySubscriptionModel?> fetchMySubscribtion(String id,{VoidCallback? errorCallBack}) async {
    MySubscriptionModel? status =
    await _apiProvider.fetchMySubscribtion(id,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }


}
