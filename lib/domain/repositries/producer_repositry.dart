import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/MoreProductModel.dart';

class ProducerRepository extends BaseRepository {
  final ApiProvider _apiProvider = ApiProvider();

  @throws
  Future<ProducerModel?> fetchProducerList(int offset, {VoidCallback? errorCallBack}) async {
    ProducerModel? status =
        await _apiProvider.fetchProducerList(offset,throwOnError: true,errorCallBack:  errorCallBack);
    return status;
  }
  @throws
  Future<ProducerModel?> fetchMyProducerList(String id,{VoidCallback? errorCallBack}) async {
    ProducerModel? status =
        await _apiProvider.fetchMyProducerList(id,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<ProductModel?> fetchProducerProductList(String id,{VoidCallback? errorCallBack}) async {
    ProductModel? status =
        await _apiProvider.fetchProducerProductList(id,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }
  @throws
  Future<ProductModel?> fetchProducerProductListForTeam(String producerId, String teamId,{VoidCallback? errorCallBack}) async {
    ProductModel? status =
        await _apiProvider.fetchProducerProductListForTeam(producerId,teamId,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }
  @throws
  Future<BaseModel?> fetchProducerDetail(String producerId,{VoidCallback? errorCallBack}) async {
    BaseModel? status =
        await _apiProvider.fetchProducerDetail(producerId,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }
  @throws
  Future<MoreProductModel?> fetchMoreProductList(String id,{VoidCallback? errorCallBack}) async {
    MoreProductModel? status =
        await _apiProvider.fetchMoreProductList(id,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }
  @throws
  Future<ProductDetailModel?> fetchProductDetail(String id,{VoidCallback? errorCallBack, String? teamId}) async {
    ProductDetailModel? status =
        await _apiProvider.fetchProductDetail(id,teamId:teamId,throwOnError: true,errorCallBack: errorCallBack);
    return status;
  }
}
