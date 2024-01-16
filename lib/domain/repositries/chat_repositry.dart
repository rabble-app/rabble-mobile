import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/ConversationModel.dart';
import 'package:rabble/domain/entities/TeamDetailChatModel.dart';

class ChatRepository extends BaseRepository {
  final ApiProvider _apiProvider = ApiProvider();

  @throws
  Future<BaseModel?> connectionPusher(String socketId,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.connectionPusher(socketId,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }
  @throws
  Future<ConversationModel?> fetchChatList(
      String teamId, String offset,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    ConversationModel? status = await _apiProvider.chatList(
      teamId,offset,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<TeamChatListModel?> fetchTeamChatList(
      {required throwOnError, VoidCallback? errorCallBack}) async {
    TeamChatListModel? status = await _apiProvider.fetchTeamChatList(
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<TeamDetailChatModel?> fetchTeamDetail(String teamId,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    TeamDetailChatModel? status = await _apiProvider.fetchTeamDetail(teamId,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> sendMessage(
       String teamId, String producerId, String message,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.sendMessage(
        teamId, producerId, message,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }
}
