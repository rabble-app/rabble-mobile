import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/ProfilePictureModel.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';
import 'package:rabble/domain/entities/UserBasketModel.dart';

class UserRepository extends BaseRepository {
  final ApiProvider _apiProvider = ApiProvider();

  @throws
  Future<BaseModel?> updateProfileData(
      {Map<String, String>? body,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.updateProfileData(
        body: body, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<ProfilePictureModel?> updateProfilePhoto(
      {FormData? body,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    ProfilePictureModel? status = await _apiProvider.updateProfilePhoto(
        body: body, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> addNewAddress(
      {Map<String, String>? body,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.addNewAddress(
        body: body, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<CheckModel?> checkTeamNameExist(String name,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    CheckModel? status = await _apiProvider.checkTeamNameExist(name,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BuyingTeamModel?> checkTeamExist(String producerId, String postalCode,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    BuyingTeamModel? status = await _apiProvider.checkTeamExist(
        producerId, postalCode,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> updateAddress(
      {Map<String, String>? body,
      String? userId,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.updateAddress(
        body: body,
        userId: userId,
        throwOnError: throwOnError,
        errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<CustomerAddress?> fetchMyAddress(
      {String? userId,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    CustomerAddress? status = await _apiProvider.fetchMyAddress(userId!,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<List<String>> fetchNearBY(String postalCode,
      {VoidCallback? errorCallBack}) async {
    List<String>? status = await _apiProvider.fetchNearByLocation(postalCode,
        errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<NotificationModel?> fetchMyNotifications(
      {String? userId,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    NotificationModel? status = await _apiProvider.fetchMyNotifications(userId!,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> readMyNotifications(
      {String? userId,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.readMyNotifications(userId!,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<RequestSendModel?> fetchMyRequest(
      {String? userId,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    RequestSendModel? status = await _apiProvider.fetchMyRequest(userId!,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> addToTeam(
      {Map<String, dynamic>? body,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.addToTeam(
        body: body, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<AddTeamMemberModel?> addMember(
      {Map<String, dynamic>? body,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    AddTeamMemberModel? status = await _apiProvider.addMemeber(
        body: body, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> updateTeam(
      {Map<String, dynamic>? body,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.updateTeam(
        body: body, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> updateTeamData(String id,
      {Map<String, dynamic>? body,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.updateTeamData(id,
        body: body, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> skipNextDeliver(
      {String? id, required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.skipNextDeliver(
        id: id, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> nudgeTeamMember(
      {Map<String, dynamic>? body,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.nudgeTeamMember(
        body: body, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> nudgeTeam(
      {String? teamId,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.nudgeTeam(
        teamId: teamId,
        throwOnError: throwOnError,
        errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> quiteTeam(
      {String? id, required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.quiteTeam(
        id: id, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> deleteMyAccount(
      {String? id, required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.deleteMyAccount(
        id: id, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> inviteContacts(
      {Map<String, dynamic>? body,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.inviteContacts(
        body: body, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> requestToJoinTeam(
      {Map<String, dynamic>? body,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.requestToJoinTeam(
        body: body, throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<OrderHistoryModel?> fetchOrderHistory(
      {String? userId,
      required throwOnError,
      VoidCallback? errorCallBack}) async {
    OrderHistoryModel? status = await _apiProvider.fetchMyOrderHistory(userId!,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<UserBasketModel?> fetchUserBasket(String teamId,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    UserBasketModel? status = await _apiProvider.fetchUserBasket(teamId,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }
}
