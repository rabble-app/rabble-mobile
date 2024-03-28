import 'package:rabble/core/config/export.dart';

class AddressRepository extends BaseRepository {
  ApiProvider apiProvider;

  AddressRepository(this.apiProvider);


  @throws
  Future<BaseModel?> updatePostalCode(String number, String postalCode,
      {required throwOnError, VoidCallback? errorCallBack}) async {
    BaseModel? status = await apiProvider.updatePostalCode(number, postalCode,
        throwOnError: throwOnError, errorCallBack: errorCallBack);
    return status;
  }
}
