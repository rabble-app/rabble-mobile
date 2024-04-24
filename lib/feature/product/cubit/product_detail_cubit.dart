import 'package:rabble/core/config/export.dart';
import 'package:rabble/core/config/local_db_config.dart';
import 'package:rabble/domain/entities/MoreProductModel.dart';
import 'package:rabble/domain/entities/Owner.dart';
import 'package:rabble/domain/entities/PartitionedProductUsersRecordModel.dart';

class ProductDetailCubit extends RabbleBaseCubit {
  ProductDetailCubit() : super(RabbleBaseState.idle());

  BehaviorSubject<ProductDetail> productDetailSubject$ =
      BehaviorSubject<ProductDetail>();

  final BehaviorSubject<List<ProductDetail>> moreProductListSubject$ =
      BehaviorSubject<List<ProductDetail>>();

  final BehaviorSubject<List<TempBoxData>> purchasedUserListSubject$ =
      BehaviorSubject<List<TempBoxData>>();
  final BehaviorSubject<bool> expandedTeamInfoSubject$ =
      BehaviorSubject<bool>();

  Future<void> addProductInCart(
      BuildContext context, ProductDetail product) async {
    await dbHelper.addProductInCart(context, product);

    List<TempBoxData> tempList = purchasedUserListSubject$.hasValue
        ? purchasedUserListSubject$.value
        : [];

    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    tempList.add(TempBoxData('${userModel.firstName} ${userModel.lastName}'));
    purchasedUserListSubject$.sink.add(tempList);
    fetchSingleProductExist(product.id!);
    fetchAllProducts(product.producerId!);
  }

  Future<void> fetchProductDetail(String productId, String? producerId) async {
    emit(RabbleBaseState.primaryBusy());

    dynamic tempData = await RabbleStorage.getinivitationData();
    InvitationData? invitationData;
    if (tempData != null) {
      invitationData = InvitationData.fromJson(json.decode(tempData));
    }

    var res = await producerRepo.fetchProductDetail(productId,
        teamId: invitationData != null &&
                invitationData.producerInfo!.id == producerId
            ? invitationData.teamId
            : '', errorCallBack: () {
      emit(RabbleBaseState.idle());
    });

    if (res!.statusCode == 200 && res.data != null) {
      ProductDetail productDetail = res.data!;
      dynamic d = await dbHelper.fetchSingleProduct(productId);
      if (d is ProductDetail) {
        globalBloc.cartItemQty.sink.add(d.qty!);
        productDetail.qty = d.qty ?? 0;
      }
      productDetailSubject$.sink.add(productDetail);
    }
    fetchSingleProductExist(productId);
    fetchAllProducts(producerId!);

    emit(RabbleBaseState.idle());
    fetchMoreProductList(producerId, productId);
  }

  Future<void> fetchMoreProductList(String id, String productId) async {
    emit(RabbleBaseState.tertiaryBusy());

    var res = await producerRepo.fetchMoreProductList(id, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });

    if (res!.statusCode == 200 && res.data != null) {
      if (res.data!.isNotEmpty) {
        int index = res.data!.indexWhere((element) => element.id == productId);
        print('res.data! ${res.data!.length}');
        print('index ${index}');

        if (index != -1) {
          res.data!.removeAt(index);
        }
        moreProductListSubject$.sink.add(res.data!);
      } else {
        print('res.data! ${res.data!.length}');
        moreProductListSubject$.sink.add(res.data!);
      }
    }
    emit(RabbleBaseState.idle());
  }

  Future<void> productQuantity(
      qty, String? productId, String producerId) async {
    await dbHelper.updateProductQuantity(productId!, qty);
    globalBloc.cartItemQty.sink.add(qty);
    ProductDetail productDetail = productDetailSubject$.value;
    print("qty 2 $qty");
    productDetail.qty = qty;
    productDetailSubject$.sink.add(productDetail);
    fetchAllProducts(producerId);
  }

  Future<void> fetchSingleProductExist(String productId) async {
    dynamic res = await dbHelper.fetchSingleProduct(productId);
    if (res is ProductDetail) {
      print('res.qty! A ${res.qty!}');
      globalBloc.cartItemQty.sink.add(res.qty!);
      if (productDetailSubject$.hasValue) {
        ProductDetail productDetail = productDetailSubject$.value;
        productDetail.qty = res.qty!;

        List<TempBasketData> tempBasktList = [];
        List<TempBoxData> tempList = [];
        for (int j = 0; j < res.qty!; j++) {
          if (userDataSubject$.hasValue) {
            tempList.add(TempBoxData(
                '${userDataSubject$.value.firstName} ${userDataSubject$.value.lastName}'));
          }
        }

        if (productDetail.partionedProducts != null &&
            productDetail.partionedProducts!.isNotEmpty) {
          productDetail.partionedProducts!.first.partitionedProductUsersRecord!
              .forEach((element) {
            for (int j = 0; j < element.quantity!; j++) {
              tempList.add(TempBoxData(
                  '${element.owner!.firstName} ${element.owner!.lastName}'));
            }
          });
        }
        purchasedUserListSubject$.sink.add(tempList);

        productDetailSubject$.sink.add(productDetail);
      } else {
        productDetailSubject$.sink.add(res);
      }
    } else {
      if (productDetailSubject$.hasValue) {
        List<TempBoxData> tempList = [];
        if (productDetailSubject$.value.partionedProducts != null &&
            productDetailSubject$.value.partionedProducts!.isNotEmpty) {
          productDetailSubject$
              .value.partionedProducts!.first.partitionedProductUsersRecord!
              .forEach((element) {
            for (int j = 0; j < element.quantity!; j++) {
              tempList.add(TempBoxData(
                  '${element.owner!.firstName} ${element.owner!.lastName}'));
            }
          });

          purchasedUserListSubject$.sink.add(tempList);
        }
      }

      if (productDetailSubject$.hasValue) {
        ProductDetail productDetail = productDetailSubject$.value;
        productDetail.qty = 0;
        productDetailSubject$.sink.add(productDetail);
      } else {
        if (res is ProductDetail) {
          productDetailSubject$.sink.add(res);
        }
      }

      globalBloc.cartItemQty.sink.add(0);
    }
  }

  Future<void> fetchSingleProductExist2(ProductDetail detail,String productId) async {
     print("PRODUCT ID ${productId}");

    dynamic res = await dbHelper.fetchSingleProduct(productId);
    if (res is ProductDetail && res.id == productId) {

      globalBloc.cartItemQty.sink.add(res.qty!);
      if (productDetailSubject$.hasValue && productDetailSubject$.value.id == productId) {
        ProductDetail productDetail = productDetailSubject$.value;
        productDetail.qty = res.qty!;

        List<TempBoxData> tempList = [];
        for (int j = 0; j < res.qty!; j++) {
          if (userDataSubject$.hasValue) {
            tempList.add(TempBoxData(
                '${userDataSubject$.value.firstName} ${userDataSubject$.value.lastName}'));
          }
        }

        if (productDetail.partionedProducts != null &&
            productDetail.partionedProducts!.isNotEmpty) {
          productDetail.partionedProducts!.first.partitionedProductUsersRecord!
              .forEach((element) {
            for (int j = 0; j < element.quantity!; j++) {
              tempList.add(TempBoxData(
                  '${element.owner!.firstName} ${element.owner!.lastName}'));
            }
          });
        }
        purchasedUserListSubject$.sink.add(tempList);

        productDetailSubject$.sink.add(productDetail);
      }
      else {
        print("res ${res.qty}");
        productDetailSubject$.sink.add(res);
      }
    }
    else {
      if (productDetailSubject$.hasValue) {
        print("A");
        List<TempBoxData> tempList = [];
        if (productDetailSubject$.value.partionedProducts != null &&
            productDetailSubject$.value.partionedProducts!.isNotEmpty) {
          productDetailSubject$
              .value.partionedProducts!.first.partitionedProductUsersRecord!
              .forEach((element) {
            for (int j = 0; j < element.quantity!; j++) {
              tempList.add(TempBoxData(
                  '${element.owner!.firstName} ${element.owner!.lastName}'));
            }
          });

          purchasedUserListSubject$.sink.add(tempList);
        }
      }

      if (productDetailSubject$.hasValue) {
        print("B");

        ProductDetail productDetail = productDetailSubject$.value;
        productDetail.qty = 0;
        productDetailSubject$.sink.add(productDetail);
      } else {
        if (res is ProductDetail) {
          productDetailSubject$.sink.add(res);
        }
      }

      print("D");

      productDetailSubject$.sink.add(detail);
      globalBloc.cartItemQty.sink.add(0);
    }
  }


  Future<bool> removeProduct(String productId) async {
    bool res = await dbHelper.removeProductFromCart(productId);
    fetchSingleProductExist(productId);
    return res;
  }

  Future<void> fetchAllProducts(String id) async {
    List<ProductDetail> products = await dbHelper.getAllProducts();

    bool res = await dbHelper.checkProducerMatched(id);
    print('res $res');
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
    totalQuantity.sink.add(tq);
  }

  BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject<UserModel>();

  Future<void> fetchUserData() async {
    String status = await RabbleStorage.getLoginStatus() ?? "0";
    if (status != '0') {
      var userData =
          await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
      UserModel userModel = UserModel.fromJson(jsonDecode(userData));

      userDataSubject$.sink.add(userModel);
    }
  }

  String calculatePercentage(num? price, num? rrp) {
    if (price == null || rrp == null || rrp == 0) {
      return '0';
    }

    double discountPercentage = ((rrp - price) / rrp) * 100;
    return discountPercentage.toStringAsFixed(1);
  }

  String calculateSaving(num? price, num? rrp) {
    if (price == null || rrp == null || rrp == 0) {
      return '0';
    }

    return '£${rrp - price > 0 ? (rrp - price).toStringAsFixed(2) : '0'}';
  }

  Future<String> generateDeepLink(ProductDetail productDetail) async {
    final branchUniversalObject = BranchUniversalObject(
        canonicalIdentifier: productDetail.id ?? '',
        canonicalUrl: productDetail.producerId ?? '',
        title: productDetail.name ?? '',
        imageUrl: productDetail.imageUrl ?? '',
        contentDescription: productDetail.description ?? '',
        keywords: ['product_share']);

    final branchLinkProperties = BranchLinkProperties(
      feature: 'Share Product',
      channel: 'Rabble app',
      campaign: 'Share Product.',
    );

    final generatedLink = await FlutterBranchSdk.getShortUrl(
        linkProperties: branchLinkProperties, buo: branchUniversalObject);

    print('Generated deep link: ${generatedLink.result.toString()}');

    return generatedLink.result.toString();
  }

}

class TempBoxData {
  final String? userName;

  TempBoxData(this.userName);
}

class TempBasketData {
  final int? totalItems;
  final List<TempBoxData>? tempBoxList;

  TempBasketData(this.totalItems, this.tempBoxList);
}
