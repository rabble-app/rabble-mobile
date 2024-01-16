import 'package:rabble/config/export.dart';

class ProductTabCubit extends RabbleBaseCubit {
  ProductTabCubit(this.id, this.data) : super(RabbleBaseState.idle()) {
    fetchProducerDetail(id);
  }

  final currentIndexSubject = BehaviorSubject<int>.seeded(0);
  final seeMoreClickedSubject$ = BehaviorSubject<int>.seeded(0);
  final isProductExistSnapShot = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<ProducerDetail> producerDataSubject$ = BehaviorSubject();

  final String id;
  final Map data;
  final BehaviorSubject<List<ProductData>> productListSubject$ =
      BehaviorSubject<List<ProductData>>();

  Future<void> fetchProducerDetail(String procducerId) async {
    emit(RabbleBaseState.primaryBusy());
    var res =
        await producerRepo.fetchProducerDetail(procducerId, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });

    if (res!.status == 200 && res.data != null) {
      ProducerDetail producerDetail = ProducerDetail.fromJson(res.data);
      producerDataSubject$.sink.add(producerDetail);

      if (data != null && data['type']) {
        TeamData teamData = data['team'];
        fetchProductListForTeam(id, teamData.id.toString());
      } else {
        fetchProductList(id);
      }
    }
 //   emit(RabbleBaseState.idle());
  }

  Future<void> fetchProductListForTeam(
      String procducerId, String teamId) async {
    emit(RabbleBaseState.secondaryBusy());
    var res = await producerRepo.fetchProducerProductListForTeam(
        procducerId, teamId, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });

    if (res!.statusCode == 200 && res.data != null) {
      productListSubject$.sink.add(res.data!);
    }
    emit(RabbleBaseState.idle());
  }

  Future<void> fetchProductList(String id) async {
    emit(RabbleBaseState.secondaryBusy());
    var res =
        await producerRepo.fetchProducerProductList(id, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });

    if (res!.statusCode == 200 && res.data != null) {
      productListSubject$.sink.add(res.data!);
    }
    emit(RabbleBaseState.idle());
  }

  final BehaviorSubject<List<ProductDetail>> productList =
      BehaviorSubject<List<ProductDetail>>.seeded([]);

  Future<void> fetchAllProducts() async {
    List<ProductDetail> products = await dbHelper.getAllProducts();
    print("products size ${products.length}");

    productList.sink.add(products);

    bool res = await dbHelper.checkProducerMatched(id);
    if (res) {
      await calculateSum(products);
    }
  }

  final BehaviorSubject<double> totalSum = BehaviorSubject<double>();
  final BehaviorSubject<int> totalQuantity = BehaviorSubject<int>();

  Future<void> calculateSum(List<ProductDetail> products) async {
    double totalPrice = products.fold(
        0,
        (previous, element) =>
            previous +
            double.parse((element.price! * element.qty!).toString()));
    totalSum.sink.add(totalPrice);

    int tq = products.fold(0,
        (previous, element) => previous + int.parse((element.qty!).toString()));

    print("tq $tq");
    totalQuantity.sink.add(tq);
  }

  Future<String> generateDeepLink(ProducerDetail teamData) async {
    final branchUniversalObject = BranchUniversalObject(
        canonicalIdentifier: teamData.id ?? '',
        title: teamData.businessName ?? '',
        imageUrl: teamData.imageUrl ?? '',
        contentDescription: teamData.description ?? '',
        keywords: ['producer_share']);

    final branchLinkProperties = BranchLinkProperties(
      feature: 'Share Producer',
      channel: 'Rabble app',
      campaign: 'Share producer.',
    );

    final generatedLink = await FlutterBranchSdk.getShortUrl(
        linkProperties: branchLinkProperties, buo: branchUniversalObject);

    print('Generated deep link: ${generatedLink.result.toString()}');

    return generatedLink.result.toString();
  }
}
