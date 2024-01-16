import 'package:rabble/config/export.dart';

class SearchRepository extends BaseRepository {
  final ApiProvider _apiProvider = ApiProvider();

  @throws
  Future<SearchProductModel?> searchProduct(String query,String type,
      {required throwOnError,VoidCallback? errorCallBack}) async {
    SearchProductModel? status =
        await _apiProvider.searchProduct(query, type,throwOnError: throwOnError,errorCallBack: errorCallBack);
    return status;
  }


  @throws
  Future<PopularSearchModel?> popularSearch(
      {required throwOnError,VoidCallback? errorCallBack}) async {
    PopularSearchModel? status =
    await _apiProvider.popularSearch(throwOnError: throwOnError,errorCallBack: errorCallBack);
    return status;
  }
  @throws
  Future<RecentSearchModel?> recentSearch(
      {required throwOnError,VoidCallback? errorCallBack}) async {
    RecentSearchModel? status =
    await _apiProvider.recentSearch(throwOnError: throwOnError,errorCallBack: errorCallBack);
    return status;
  }

  Future<void> cancelRequest() async {
    _apiProvider.cancelRequest();
  }
}
