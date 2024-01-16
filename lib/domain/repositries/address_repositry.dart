import 'package:rabble/config/export.dart';

class AddressRepository extends BaseRepository {
  final ApiProvider _apiProvider = ApiProvider();

  @throws
  Future<BaseModel?> updatePostalCode(String number, String postalCode,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.updatePostalCode(number, postalCode,
        throwOnError: throwOnError,errorCallBack:errorCallBack );
    return status;
  }
}
