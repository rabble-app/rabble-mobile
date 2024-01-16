import 'package:rabble/config/export.dart';

class AuthRepository extends BaseRepository {
  final ApiProvider _apiProvider = ApiProvider();



  @throws
  Future<BaseModel?> login(String number,{required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.login(
        number,
        throwOnError: throwOnError,
        errorCallBack: errorCallBack
    );
    return status;
  }

  @throws
  Future<BaseModel?> connectionPusher(String socketId,{required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.connectionPusher(
        socketId,
        throwOnError: throwOnError,
        errorCallBack: errorCallBack
    );
    return status;
  }
  @throws
  Future<BaseModel?> verifyOtp(String number,String code,String sid,{required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.verifyOtp(
        number,
        code,
        sid,
        throwOnError: throwOnError,
      errorCallBack: errorCallBack
    );
    return status;
  }



  @throws
  Future<BaseModel?> updateUser(String number,{required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.login(
        number,
        throwOnError: throwOnError,
      errorCallBack: errorCallBack
    );
    return status;
  }



  @throws
  Future<InvitationModel?> verifyToken(String token,{required throwOnError, VoidCallback? errorCallBack,Function? retryCallBack}) async {
    InvitationModel? status = await _apiProvider.verifyToken(
        token,
        throwOnError: throwOnError,
      errorCallBack: errorCallBack,
       retryCallBack: retryCallBack,
    );
    return status;
  }

}
