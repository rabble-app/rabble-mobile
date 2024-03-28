import 'package:rabble/core/config/export.dart';

class AuthRepository extends BaseRepository {
  ApiProvider apiProvider;

  AuthRepository(this.apiProvider);

  @throws
  Future<BaseModel?> login(String number,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await apiProvider.login(number,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> connectionPusher(String socketId,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await apiProvider.connectionPusher(socketId,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> verifyOtp(String number, String code, String sid,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await apiProvider.verifyOtp(number, code, sid,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> updateUser(String number,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await apiProvider.login(number,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<InvitationModel?> verifyToken(String token,
      {required throwOnError,
      VoidCallback? errorCallBack,
      Function? retryCallBack}) async {
    InvitationModel? status = await apiProvider.verifyToken(
      token,
      throwOnError: throwOnError,
      errorCallBack: errorCallBack,
      retryCallBack: retryCallBack,
    );
    return status;
  }
}
