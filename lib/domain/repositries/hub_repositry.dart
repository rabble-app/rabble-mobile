import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/BulkUploadedModel.dart';
import 'package:rabble/domain/entities/TeamCreationModel.dart';
import 'package:rabble/domain/entities/TeamModel.dart';
import 'package:rabble/domain/entities/UserTeamModel.dart';
import 'package:rabble/domain/entities/distance_model.dart';
import 'package:rabble/domain/entities/hub/AllPartnerTeamsModel.dart';

import '../entities/MySubscriptionModel.dart';

class HubRepository extends BaseRepository {
  final ApiProvider _apiProvider = ApiProvider();

  @throws
  Future<AllPartnerTeamsModel?> fetchPartnersTeam(String postalCode,
      {VoidCallback? errorCallBack}) async {
    AllPartnerTeamsModel? status = await _apiProvider.fetchPartnersTeam(postalCode,
        throwOnError: true, errorCallBack: errorCallBack);
    return status;
  }
  @throws
  Future<TeamModel?> fetchPartnerTeamDetail(String teamId,
      {VoidCallback? errorCallBack}) async {
    TeamModel? status = await _apiProvider.fetchPartnerTeamDetail(teamId,
        throwOnError: true, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<OrderModel?> fetchCurrentOrderDetail(String teamId,
      {VoidCallback? errorCallBack}) async {
    OrderModel? status = await _apiProvider.fetchCurrentOrderDetail(teamId,
        throwOnError: true, errorCallBack: errorCallBack);
    return status;
  }



}
