import 'package:rabble/core/config/export.dart';

class SearchCubit extends RabbleBaseCubit with Validators {
  SearchCubit() : super(RabbleBaseState.idle());

  BehaviorSubject<List<dynamic>> dynamicListSubject$ =
      BehaviorSubject<List<dynamic>>();

  BehaviorSubject<List<PopularSearchData>> popularSearchListSubject$ =
      BehaviorSubject<List<PopularSearchData>>();

  BehaviorSubject<List<RecentSearchData>> recentSearchListSubject$ =
      BehaviorSubject<List<RecentSearchData>>();
  TextEditingController controller = TextEditingController();

  BehaviorSubject<int> currentIndex = BehaviorSubject<int>.seeded(0);
  BehaviorSubject<bool> searchStarted = BehaviorSubject<bool>.seeded(false);

  Future<void> searchProduct(int? currentIndex) async {

    searchRepo.cancelRequest();

    dynamicListSubject$.sink.add([]);
    String query = controller.text;
    if (query.isNotEmpty) {
      emit(RabbleBaseState.primaryBusy());
      searchStarted.sink.add(true);
      SearchProductModel? producerRes = await searchRepo.searchProduct(
          query, getCurrentCategoryType(currentIndex),
          throwOnError: true,errorCallBack: (){
        emit(RabbleBaseState.idle());
      });
      if (producerRes!.statusCode == 200) {
        dynamicListSubject$.sink.add(producerRes.data!);
      }
      emit(RabbleBaseState.idle());
    }
  }

  void clearController() {
    emit(RabbleBaseState.idle());
    searchRepo.cancelRequest();
    controller.clear();
  }

  Future<void> removeSearch(int id, int index) async {
    emit(RabbleBaseState.secondaryBusy());
    await dbHelper.deleteSearch(id);
    List<RecentSearchData> data =
        recentSearchListSubject$.hasValue ? recentSearchListSubject$.value : [];
    if (data.isNotEmpty) {
      data.removeAt(index);
    }
    recentSearchListSubject$.sink.add(data);
    emit(RabbleBaseState.idle());
  }

  Future<void> clearRecentSearch() async {
    emit(RabbleBaseState.secondaryBusy());
    await dbHelper.clearSearch();
    List<RecentSearchData> data =
        recentSearchListSubject$.hasValue ? recentSearchListSubject$.value : [];
    data.clear();
    recentSearchListSubject$.sink.add(data);
    emit(RabbleBaseState.idle());
  }

  fetchRecentSearch() async {
    emit(RabbleBaseState.primaryBusy());
    List<Map<String, dynamic>> queries = await dbHelper.queryAllRows();

    List<RecentSearchData> data =
        queries.map((e) => RecentSearchData.fromJson(e)).toList();
    recentSearchListSubject$.sink.add(data);

    emit(RabbleBaseState.idle());
  }

  fetchPopularSearch() async {
    emit(RabbleBaseState.primaryBusy());
    PopularSearchModel? producerRes =
        await searchRepo.popularSearch(throwOnError: true,errorCallBack: (){
          emit(RabbleBaseState.idle());
        });
    if (producerRes!.statusCode == 200) {
      popularSearchListSubject$.sink.add(producerRes.data!);
    }
    emit(RabbleBaseState.idle());
  }

  getCurrentCategoryType(int? currentIndex) {
    if (currentIndex == 0) return 'SUPPLIER';
    if (currentIndex == 1) return 'PRODUCT';
    if (currentIndex == 2) return 'TEAM';

    return 'SUPPLIER';
  }
}
