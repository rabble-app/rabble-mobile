import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/UserBasketModel.dart';
import 'package:rabble/feature/buying_team/setting/quite_team_sheet.dart';
import 'package:rabble/feature/checkout/team_exist_sheet.dart';

class CheckoutCubit extends RabbleBaseCubit {
  CheckoutCubit() : super(RabbleBaseState.idle());

  final BehaviorSubject<List<ProductDetail>> productList =
      BehaviorSubject<List<ProductDetail>>.seeded([]);

  final BehaviorSubject<List<UserBasketData>> myBasketList =
      BehaviorSubject<List<UserBasketData>>.seeded([]);
  final BehaviorSubject<double> totalSum = BehaviorSubject<double>();
  final BehaviorSubject<double> totalSumRRP = BehaviorSubject<double>();
  final BehaviorSubject<double> totalDiscount =
      BehaviorSubject<double>.seeded(0.0);
  final BehaviorSubject<bool> isEmpty = BehaviorSubject<bool>.seeded(false);
  final List<int> originalQty = [];

  Future<void> fetchAllProducts() async {
    emit(RabbleBaseState.primaryBusy());

    List<ProductDetail> products = await dbHelper.getAllProducts();

    productList.sink.add(products);
    globalBloc.cartItemQty.sink.add(products.length);

    if (products.isNotEmpty) {
      var tempData = await RabbleStorage().getinivitationData();

      if (tempData != null) {
        InvitationData invitationData =
            InvitationData.fromJson(json.decode(tempData));
        if (invitationData.producerInfo!.id == products[0].producerId!) {
          isEmpty.sink.add(true);
        }
      }
    }

    await calculateSum(products);
    await calculateSumOfRRP(products);
    await calculateDiscount(products);
    emit(RabbleBaseState.idle());
  }

  Future<void> fetchUserBasket(String teamId) async {
    emit(RabbleBaseState.primaryBusy());

    UserBasketModel? userBasketModel = await userRepo
        .fetchUserBasket(teamId, throwOnError: true, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });

    if (userBasketModel!.statusCode == 200) {
      myBasketList.sink.add(userBasketModel.data!);
      await calculateSum2(userBasketModel.data!);
    }

    emit(RabbleBaseState.idle());
  }

  Future<void> calculateSum2(List<UserBasketData> products) async {
    print("here");
    double totalPrice = products.fold(
        0,
        (double previous, UserBasketData element) =>
            previous +
            double.parse((element.price! * element.quantity!).toString()));
    totalSum.sink.add(totalPrice);
  }



  Future<void> calculateSum(List<ProductDetail> products) async {
    double totalPrice = products.fold(
        0,
        (double previous, ProductDetail element) =>
            previous +
            double.parse((element.price! * element.qty!).toString()));
    totalSum.sink.add(totalPrice);
  }

  Future<void> calculateSumOfRRP(List<ProductDetail> products) async {
    double totalPrice = products.fold(
        0,
        (double previous, ProductDetail element) =>
            previous +
            double.parse((element.rrp! * element.qty!).toString()));
    totalSumRRP.sink.add(totalPrice);
  }

  Future<void> productQuantity(qty, String? productId) async {
    await dbHelper.updateProductQuantity(productId!, qty);
    fetchAllProducts();
  }

  Future<void> updateThreshold(qty, String? productId) async {
    await dbHelper.updateThreshold(productId!, qty);
  }

  Future<bool> removeProduct(String productId) async {
    bool res = await dbHelper.removeProductFromCart(productId);
    fetchAllProducts();

    return res;
  }

  Future<void> removeFromBasket(
      String productId,
      int remainingDays,
      String deadLine,
      String membershipId,
      BuildContext context,
      String? hostId,
      int count,
      String percentage) async {
    List<UserBasketData> myBasket = myBasketList.value;

    if (myBasket.length == 1 &&
        myBasket.any((UserBasketData element) => element.quantity == 1)) {
      CustomBottomSheet.showQuitBottomModelSheet(
              context,
              QuiteTeam(
                canLeave: int.parse(percentage) < 100 &&
                    remainingDays > 0 &&
                    count == 1,
                subheading: 'Considering Removing an Item?',
                isHost: hostId == userDataSubject$.value.id,
                des:
                    'To remove the item, you must quit the team. By doing so, you\'ll no longer be a part of this team. Ensure you\'re certain about this decision.',
                showHeading: false,
                callBackDelete: () async {
                  emit(RabbleBaseState.tertiaryBusy());
                  BaseModel? skipNextDeliveryRes = await userRepo.quiteTeam(
                      id: membershipId,
                      throwOnError: false,
                      errorCallBack: () {
                        emit(RabbleBaseState.idle());
                      });

                  if (skipNextDeliveryRes!.status == 200) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeView()),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    globalBloc.showSuccessSnackBar(
                        message: skipNextDeliveryRes.message);
                  }
                },
                date: deadLine,
              ),
              true,
              int.parse(percentage) < 100 && remainingDays > 0 && count == 1,
              isRemove: true,
              date: null)
          .then((bool value) {});
    } else {
      emit(RabbleBaseState.tertiaryBusy());

      BaseModel? removeFromBasketRes = await paymentRepo
          .removeFromBasket(productId, throwOnError: true, errorCallBack: () {
        emit(RabbleBaseState.idle());
      });
      if (removeFromBasketRes!.status == 200) {
        UserBasketData data = myBasket
            .singleWhere((UserBasketData element) => element.id == productId);
        myBasket.remove(data);

        myBasketList.sink.add(myBasket);
        await calculateSum2(myBasket);
      }
      emit(RabbleBaseState.idle());
    }
  }

  Future<void> increaseQty(
    qty,
    UserBasketData item,
  ) async {
    emit(RabbleBaseState.secondaryBusy());

    List<UserBasketData> myBasket = myBasketList.value;

    item.quantity = qty;
    item.update = true;
    item.deacreased = true;

    myBasket[myBasket
        .indexWhere((UserBasketData element) => element.id == item.id)] = item;

    myBasketList.sink.add(myBasket);

    emit(RabbleBaseState.idle());
  }

  Future<void> decreaseQty(int qty, UserBasketData item) async {
    emit(RabbleBaseState.secondaryBusy());

    List<UserBasketData> myBasket = myBasketList.value;
    item.quantity = qty;
    item.update = true;
    if (item.product!.type == 'PORTIONED_SINGLE_PRODUCT') {
      int tempThreshold = item.product!.thresholdQuantity!;
      tempThreshold--;

      int tempAccumlator =
          item.product!.partionedProducts!.first.accumulator!.toInt();
      tempAccumlator++;

      item.product!.thresholdQuantity = tempThreshold;
      item.product!.partionedProducts!.first.accumulator = tempAccumlator;
    }

    myBasket[myBasket.indexWhere((UserBasketData element) =>
        element.id == item.id && element.update!)] = item;

    myBasketList.sink.add(myBasket);

    emit(RabbleBaseState.idle());
  }

  Future<bool> updateBasket(String teamId, String orderId, int deadLineCount,
      String userId, List<Payments>? payments, num? totalOrders) async {
    emit(RabbleBaseState.tertiaryBusy());

    double totalAmount = 0;
    myBasketList.value.forEach((UserBasketData e) {
      totalAmount += e.quantity! * e.price!;
    });

    double originalValue = double.parse(calCulateAmountToPay(totalAmount,
        double.parse(getMyPaidPayment(payments, userId).toString())));

    double roundedValue = double.parse(originalValue.toStringAsFixed(2));

    BuyingTeamCreationService().addPaymentData(mamount, roundedValue);

    List<Map<String, dynamic>> bulkBasketItems =
        myBasketList.value.map((UserBasketData productDetail) {
      if (productDetail.product!.type == 'PORTIONED_SINGLE_PRODUCT') {
        return {
          'basketId': productDetail.id,
          'quantity': productDetail.quantity,
          'price': productDetail.price,
          'type': 'PORTIONED_SINGLE_PRODUCT',
          'portionId': productDetail.product!.partionedProducts!.first.id ?? '',
          'newAccumulatorValue':
              productDetail.product!.partionedProducts!.first.accumulator
        };
      } else {
        return {
          'basketId': productDetail.id,
          'quantity': productDetail.quantity,
          'type': productDetail.product!.type,
          'price': productDetail.price,
        };
      }
    }).toList();

    UserBasketData deacreaseData = myBasketList.value.firstWhere(
        (UserBasketData element) => element.deacreased!,
        orElse: () => UserBasketData());

    // commenting this line as we dont find it useful
    //  'deadlineReached': deadLineCount <= 0 && totalOrders != 1

    Map<String, dynamic> dataToUpload = {
      'basket': bulkBasketItems.toList(),
      'deadlineReached': deadLineCount <= 0
          ? true
          : deacreaseData.userId != null
              ? true
              : false,
    };

    if (deadLineCount >= 0) {
      dataToUpload['orderId'] = orderId;
    }

    BulkUploadedModel? bulkUploadTeamRes =
        await buyingTeamRepo.updateBasket(dataToUpload, () {
      emit(RabbleBaseState.idle());
    });

    if (bulkUploadTeamRes!.statusCode == 200) {
      emit(RabbleBaseState.idle());

      BuyingTeamCreationService().myBasketList.sink.add(bulkBasketItems);
      return true;
    }

    emit(RabbleBaseState.idle());
    return false;

    // if (bulkUploadTeamRes!.statusCode == 200) {
    //   globalBloc.showSuccessSnackBar(message: bulkUploadTeamRes.message);
    // } else {
    //   globalBloc.showErrorSnackBar(message: bulkUploadTeamRes.message);
    // }
    // emit(RabbleBaseState.idle());
  }

  getMyPaidPayment(List<Payments>? basket, String myId) {
    print("MYID $myId");
    return basket!.fold(
        '0',
        (previousValue, element) => element.userId == myId
            ? (int.parse(previousValue) + int.parse(element.amount.toString()))
                .toString()
            : previousValue);
  }

  final BehaviorSubject<UserModel> userDataSubject$ = BehaviorSubject();

  Future<void> fetchUserData() async {
    var userData =
        await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));
    userDataSubject$.sink.add(userModel);
  }

  calCulateAmountToPay(double totalAmount, double myPaidPayment) {
    return (totalAmount - myPaidPayment).toString();
  }

  Future<void> checkTeamExist(
    BuildContext context,
    String producerName,
    String producerId,
  ) async {
    emit(RabbleBaseState.secondaryBusy());

    var teamExistRes = await userRepo.checkTeamExist(producerId,
        PostalCodeService().postalCodeGlobalSubject.value.toString(),
        throwOnError: true, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });

    if (teamExistRes!.statusCode == 200) {
      if (teamExistRes.data!.isNotEmpty) {
        CustomBottomSheet.showTeamExistBottomModelSheet(
            context,
            TeamExistSheet(
                producerName,
                PostalCodeService().postalCodeGlobalSubject.value.toString(),
                teamExistRes.data!,
                producerId),
            true,
            true,
            isRemove: true);
      } else {
        BuyingTeamCreationService().isAuthSubject$.add(false);
        NavigatorHelper().navigateTo('/create_group_name_view', producerName);
      }
    }

    emit(RabbleBaseState.idle());
  }

  String calculatePercentage() {
    double discountPercentage = 0;
    for (ProductDetail element in productList.value) {
      if (element.price == null || element.rrp == null || element.rrp == 0) {
        discountPercentage = 0;
      } else {
        discountPercentage =
            ((element.rrp! - element.price!) / element.rrp!) * 100;
      }
    }

    return discountPercentage.toStringAsFixed(1);
  }

  Future<void> calculateDiscount(List<ProductDetail> products) async {
    double discount = 0;
    for (ProductDetail element in products) {
      if (element.price == null || element.rrp == null || element.rrp == 0) {
        discount = 0;
      } else {
        discount = discount +
            (element.rrp! - element.price!).toDouble() * element.qty!;
      }
    }
    totalDiscount.sink.add(double.parse(discount.toStringAsFixed(2)));
  }
}
