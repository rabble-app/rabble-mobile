import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/ApplyPayModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

class CardCubit extends RabbleBaseCubit with Validators {
  CardCubit() : super(RabbleBaseState.idle());

  BehaviorSubject<List<CardData>> myCardListSubject$ =
      BehaviorSubject<List<CardData>>();

  BehaviorSubject<CardData> paymentMethodSelectedSubject$ =
      BehaviorSubject<CardData>();

  BehaviorSubject<Map> messageSubject$ = BehaviorSubject<Map>.seeded({});

  final BehaviorSubject<String> cardNumberSubject$ = BehaviorSubject<String>();
  final BehaviorSubject<bool> isExpandedSubject$ = BehaviorSubject<bool>();
  final BehaviorSubject<String> primaryCardSubject$ = BehaviorSubject<String>();

  Function(String) get cardNumberC => cardNumberSubject$.sink.add;

  Stream<String> get cardNumberStream =>
      cardNumberSubject$.transform(validateCardNumber);

  final BehaviorSubject<String> cvvSubject$ = BehaviorSubject<String>();

  Function(String) get cvvC => cvvSubject$.sink.add;

  Stream<String> get cvvStream => cvvSubject$.transform(validateCVV);

  final BehaviorSubject<String> expirySubject$ = BehaviorSubject<String>();

  Function(String) get expiryC => expirySubject$.sink.add;

  Stream<String> get expiryStream => expirySubject$.transform(validateExpiry);

  Stream<bool> get validateCardFields => Rx.combineLatest3(
      cardNumberStream,
      cvvStream,
      expiryStream,
      (
        String a,
        String b,
        String c,
      ) =>
          true).onErrorReturn(false);

  Future<void> fetchMyCards() async {
    emit(RabbleBaseState.primaryBusy());
    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    CardModel? myCardRes = await paymentRepo
        .fetchMyCard(userModel.stripeCustomerId!, throwOnError: true,
            errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (myCardRes!.statusCode == 200) {

      if(myCardRes.data!.isNotEmpty) {
        for (int i = 0; i < myCardRes.data!.length; i++) {
          if (myCardRes.data![i].id != userModel.stripeDefaultPaymentMethodId!)
            continue;
          CardData tempData = myCardRes.data![i];
          tempData.isSelected = true;
          myCardRes.data![i] = tempData;
          break;
        }

        myCardListSubject$.sink.add(myCardRes.data!);

        primaryCardSubject$.sink.add(userModel.stripeDefaultPaymentMethodId!);
      }
    }

    emit(RabbleBaseState.idle());
  }

  Future<void> addMyCard(String paymentMethodId) async {
    emit(RabbleBaseState.secondaryBusy());

    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    Map<String, dynamic> body = {
      'paymentMethodId': paymentMethodId,
      mStripeCustomerId: userModel.stripeCustomerId.toString()
    };
    BaseModel? addMyCardRes = await paymentRepo
        .addMyCard(body, throwOnError: true, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (addMyCardRes!.status == 201) {
      NavigatorHelper().pop();
    } else {
      globalBloc.showSuccessSnackBar(message: addMyCardRes.message);
    }

    emit(RabbleBaseState.idle());
  }

  Future<void> markCardDefault(String paymentMethodId) async {
    emit(RabbleBaseState.secondaryBusy());

    String last4Digits =
        cardNumberSubject$.value.substring(cardNumberSubject$.value.length - 4);

    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    Map<String, dynamic> defaultCardBody = {
      'paymentMethodId': paymentMethodId,
      'lastFourDigits': last4Digits,
      mStripeCustomerId: userModel.stripeCustomerId.toString()
    };
    var primaryCardRes = await paymentRepo.markCardPrimary(defaultCardBody,
        throwOnError: true, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (primaryCardRes!.status == 200) {
      UserModel userData = UserModel.fromJson(primaryCardRes.data);

      await RabbleStorage.storeDynamicValue(
          RabbleStorage.userKey, jsonEncode(userData));
    }

    emit(RabbleBaseState.idle());
  }

  Future<void> removeCard(String paymentMethodId) async {
    emit(RabbleBaseState.secondaryBusy());

    Map<String, dynamic> removeCardBody = {
      'paymentMethodId': paymentMethodId,
    };
    var removeCardRes = await paymentRepo
        .removeCard(removeCardBody, throwOnError: true, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (removeCardRes!.status == 200) {
      List<CardData> myCardList = myCardListSubject$.value;
      myCardList.removeWhere((element) => element.id == paymentMethodId);
      myCardListSubject$.sink.add(myCardList);
    }

    emit(RabbleBaseState.idle());
  }

  SvgGenImage getIconOfCard(String type) {
    print("type $type");
    if (type == 'visa') {
      return Assets.svgs.visa;
    }

    if (type == 'mastercard') {
      return Assets.svgs.master;
    }

    if (type == 'jcb') {
      return Assets.svgs.jcbCard;
    }
    if (type == 'jcb') {
      return Assets.svgs.jcbCard;
    }
    if (type == 'amex') {
      return Assets.svgs.ae;
    }
    if (type == 'discover') {
      return Assets.svgs.discover;
    }

    return Assets.svgs.visa;
  }

  void onCardSelection(CardData cardDetail, int index) {
    List<CardData> myCardList = myCardListSubject$.value;

    for (int i = 0; i < myCardList.length; i++) {
      CardData cardDetail =
          myCardList[i]; // Create a unique instance for each iteration
      if (i == index) {
        cardDetail.isSelected = true;
        myCardList[i].isSelected = true;
        paymentMethodSelectedSubject$.sink.add(cardDetail);
        BuyingTeamCreationService()
            .addPaymentData(mPaymentType, cardDetail.card!.brand);
      } else {
        cardDetail.isSelected = false;
        myCardList[i].isSelected = false;
        paymentMethodSelectedSubject$.sink.add(cardDetail);
      }
    }

    myCardListSubject$.sink.add(myCardList);
  }

  Future<void> chargeCardPayment(
    Map<String, dynamic> chargeData,
    bool isUpdate, {
    Map<String, dynamic>? applePaymentResult,
  }) async {
    emit(RabbleBaseState.tertiaryBusy());
    messageSubject$.sink.add({
      'json': 'assets/json/loader1.json',
      'msg': kPaymentChargeMessage,
      'type': '1',
      'isUpdate': '0'
    });

    bool? isAuth = BuyingTeamCreationService().isAuthSubject$.value;
    print("isAuth ${isAuth}");
    if (isAuth) {
      chargeData['teamId'] = BuyingTeamCreationService().teamIdSubject$.value;
    }
    ChargeModel? chargeRes = await paymentRepo
        .chargeUser(chargeData, throwOnError: false, errorCallBack: () {
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'type': '0',
        'api': '2',
        'isUpdate': isUpdate ? '1' : '0',
      });
      BuyingTeamCreationService().apiDataSubject$.sink.add(chargeData);
    });
    if (chargeRes!.statusCode == 200) {
      if (chargeRes.data!.status!.isNotEmpty &&
          chargeRes.data!.status! == 'requires_action') {
        stripe.PaymentIntent res = await confirmPayment3DSecure(
            chargeRes.data!.clientSecret!,
            chargeRes.data!.paymentIntentId!,
            isUpdate,
            chargeData);
        if (res.status == stripe.PaymentIntentsStatus.RequiresCapture) {
          chargeData['paymentIntentId'] = res.id;
          chargeCardPayment(chargeData, isUpdate,
              applePaymentResult: applePaymentResult);
        } else {
          messageSubject$.sink.add({
            'json': 'assets/json/loader2.json',
            'msg': 'There was an error processing your payment',
            'type': '0',
            'api': '2',
            'isUpdate': isUpdate ? '1' : '0',
          });
          BuyingTeamCreationService().apiDataSubject$.sink.add(chargeData);
        }
      } else {
        if (isAuth) {
          await uploadBasket(TeamCreationModel(
              data: TeamCreationData(
                  id: BuyingTeamCreationService().teamIdSubject$.value,
                  orderId: chargeRes.data!.orderId)));
        } else {
          if (isUpdate) {
            Map map = {
              'teamId': BuyingTeamCreationService().teamIdSubject$.value,
              'type': '0'
            };
            BuyingTeamCreationService().payDataSubject$.sink.add({});

            NavigatorHelper()
                .navigateToScreen('/threshold_view', arguments: map);
          } else {
            BuyingTeamCreationService().addTeamCreationData(
                mPaymentIntentId, chargeRes.data!.paymentIntentId!);

            BuyingTeamCreationService().addTeamCreationData(mIsPublic, true);

            await createTeam(applePaymentResult ?? {});
          }
        }
      }
    } else {
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'type': '0',
        'api': '2',
        'isUpdate': isUpdate ? '1' : '0',
      });
      BuyingTeamCreationService().apiDataSubject$.sink.add(chargeData);
    }
  }

  Future<void> onApplePayment(Map<String, dynamic> paymentResult) async {
    emit(RabbleBaseState.tertiaryBusy());

    messageSubject$.sink.add({
      'json': 'assets/json/loader1.json',
      'msg': kPaymentChargeMessage,
      'type': '1',
      'isUpdate': '0',
    });

    String paymentIntentId = await stripePaymentIntent(paymentResult, '0');

    if (paymentIntentId.isNotEmpty) {
      Map<String, dynamic> chargeData =
          BuyingTeamCreationService().payDataSubject$.value;

      chargeData['paymentIntentId'] = paymentIntentId;
      chargeData['isApplePay'] = true;

      await chargeCardPayment(
        chargeData,
        false,
      );
    }
  }

  Future<String> stripePaymentIntent(
      Map<String, dynamic> paymentResult, String type) async {
    final stripe.TokenData token =
        await stripe.Stripe.instance.createApplePayToken(paymentResult);

    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    Map<String, dynamic> body = {
      'amount': BuyingTeamCreationService().payDataSubject$.value[mamount],
      'currency': 'gbp',
      'customerId': userModel.stripeCustomerId.toString(),
    };
    PaymentIntentModel? paymentIntentRes = await paymentRepo
        .paymentIntent(body, throwOnError: true, errorCallBack: () {
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'type': type,
      });
    });

    if (paymentIntentRes!.statusCode == 200) {
      String clientSecret = paymentIntentRes.data!.clientSecret!;

      BuyingTeamCreationService()
          .addPaymentData(mpaymentMethodId, token.id.toString());

      final stripe.PaymentMethodParams params =
          stripe.PaymentMethodParams.cardFromToken(
        paymentMethodData: stripe.PaymentMethodDataCardFromToken(
          token: token.id,
        ),
      );

      await stripe.Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: params,
      );

      return paymentIntentRes.data!.paymentIntentId.toString();
    }
    return '';
  }

  Future<void> createTeam(Map<String, dynamic> applePaymentResult) async {
    messageSubject$.sink.add({
      'json': 'assets/json/loader3.json',
      'msg': kSettingUpTeam,
      'type': '1',
    });

    Map<String, dynamic> data =
        BuyingTeamCreationService().creationDataSubject$.value;
    data.remove(mProducerName);

    TeamCreationModel? createBuyingTeamRes =
        await buyingTeamRepo.createTeam(data, () {
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'type': '0',
        'api': '3',
        'isUpdate': '0',
      });

      BuyingTeamCreationService().apiDataSubject$.sink.add(data);
    });

    if (createBuyingTeamRes!.statusCode == 201) {
      await uploadBasket(createBuyingTeamRes);
    } else {
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'type': '0',
        'api': '3',
        'isUpdate': '0',
      });

      BuyingTeamCreationService().apiDataSubject$.sink.add(data);
    }
  }

  Future<void> uploadBasket(TeamCreationModel createBuyingTeamRes) async {
    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));

    List<ProductDetail> bulkBasketItems =
        await dbHelper.getAllProductsWithOrderId(
      createBuyingTeamRes.data!.orderId!,
      userModel.id!,
    );

    List<Map<String, dynamic>> basketList =
        bulkBasketItems.map((ProductDetail productDetail) {
      return {
        'orderId': createBuyingTeamRes.data!.orderId!,
        'userId': userModel.id!,
        'productId': productDetail.id,
        'quantity': productDetail.qty,
        'price': productDetail.price,
        'type': productDetail.type,
      };
    }).toList();

    Map<String, dynamic> dataToUpload = {
      'basket': basketList,
      'teamId': createBuyingTeamRes.data!.id.toString(),
    };

    RabbleStorage.deleteKey(RabbleStorage.inivitationData);

    BulkUploadedModel? bulkUploadTeamRes =
        await buyingTeamRepo.uploadProducts(dataToUpload, () {
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'api': '4',
        'type': '0',
        'team': createBuyingTeamRes,
        'isUpdate': '0',
      });

      BuyingTeamCreationService().apiDataSubject$.sink.add(dataToUpload);
    });

    if (bulkUploadTeamRes!.statusCode == 201) {
      messageSubject$.sink.add({
        'json': 'assets/json/loader3.json',
        'msg': kCongratulationProductUpladoed,
        'type': '1'
      });
      dbHelper.truncateCartItems();

      Map map = {'teamId': createBuyingTeamRes.data!.id, 'type': '0'};
      BuyingTeamCreationService().payDataSubject$.sink.add({});
      BuyingTeamCreationService().groupNameSubject$.sink.add('');

      NavigatorHelper().navigateToScreen('/threshold_view', arguments: map);
    } else {
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'api': '4',
        'type': '0',
        'team': createBuyingTeamRes,
        'isUpdate': '0',
      });

      BuyingTeamCreationService().apiDataSubject$.sink.add(dataToUpload);
    }
  }

  Future<void> onUpdatePayment(Map map) async {
    emit(RabbleBaseState.tertiaryBusy());
    messageSubject$.sink.add({
      'json': 'assets/json/loader1.json',
      'msg': kPaymentChargeMessage,
      'type': '1',
      'isUpdate': '1'
    });

    List<Map<String, dynamic>> bulkBasketItems =
        BuyingTeamCreationService().myBasketList.value;

    int amount = 0;

    bulkBasketItems.forEach((element) {
      amount = element['price'] * element['quantity'];
    });

    Map<String, dynamic> chargeData = {
      'isApplePay': false,
      'amount': amount,
      'customerId':
          BuyingTeamCreationService().payDataSubject$.value['customerId'],
      'paymentIntentId':
          BuyingTeamCreationService().payDataSubject$.value['paymentIntentId'],
      'paymentMethodId':
          BuyingTeamCreationService().payDataSubject$.value['paymentMethodId'],
      'userId': BuyingTeamCreationService().payDataSubject$.value['userId'],
      'currency': BuyingTeamCreationService().payDataSubject$.value['currency'],
      'teamId': BuyingTeamCreationService().payDataSubject$.value['teamId'],
    };

    await chargeCardPayment(chargeData, true);
  }

  Future<void> updateBasket() async {
    emit(RabbleBaseState.tertiaryBusy());
    messageSubject$.sink.add({
      'json': 'assets/json/loader1.json',
      'msg': kPaymentChargeMessage,
      'type': '1',
      'isUpdate': '1'
    });
    List<Map<String, dynamic>> bulkBasketItems =
        BuyingTeamCreationService().myBasketList.value;

    Map<String, dynamic> dataToUpload = {
      'basket': bulkBasketItems.toList(),
    };

    print("dataToUpload ${dataToUpload.toString()}");
    BulkUploadedModel? bulkUploadTeamRes =
        await buyingTeamRepo.updateBasket(dataToUpload, () {
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'type': '1',
        'isUpdate': '1',
        'api': '4'
      });

      BuyingTeamCreationService().apiDataSubject$.sink.add(dataToUpload);
    });

    if (bulkUploadTeamRes!.statusCode == 200) {
      Map map = {
        'teamId': BuyingTeamCreationService().teamIdSubject$.value,
        'type': '0'
      };

      await onUpdatePayment(map);
    } else {
      print("jeree");
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'type': '0',
        'isUpdate': '1',
        'api': '4'
      });

      BuyingTeamCreationService().apiDataSubject$.sink.add(dataToUpload);
    }
  }

  Future<void> onUpdateApplePayment(Map<String, dynamic> paymentResult) async {
    emit(RabbleBaseState.tertiaryBusy());
    messageSubject$.sink.add({
      'json': 'assets/json/loader1.json',
      'msg': kPaymentChargeMessage,
      'type': '1',
      'isUpdate': '1',
    });

    String paymentIntentId = await stripePaymentIntent(paymentResult, '1');

    if (paymentIntentId.isNotEmpty) {
      Map<String, dynamic> chargeData =
          BuyingTeamCreationService().payDataSubject$.value;
      chargeData['paymentIntentId'] = paymentIntentId;
      chargeData['isApplePay'] = true;

      chargeCardPaymentforApplePayUpdate(chargeData, true);
    }
  }

  Future<void> chargeCardPaymentforApplePayUpdate(
      Map<String, dynamic> chargeData, bool isUpdate,
      {Map<String, dynamic>? applePaymentResult}) async {
    emit(RabbleBaseState.tertiaryBusy());
    messageSubject$.sink.add({
      'json': 'assets/json/loader1.json',
      'msg': kPaymentChargeMessage,
      'type': '1',
      'isUpdate': '1',
    });

    ChargeModel? chargeRes = await paymentRepo
        .chargeUser(chargeData, throwOnError: false, errorCallBack: () {
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'type': '0',
        'api': '2',
        'isUpdate': isUpdate ? '1' : '0',
      });
      BuyingTeamCreationService().apiDataSubject$.sink.add(chargeData);
    });
    if (chargeRes!.statusCode == 200) {
      Map map = {
        'teamId': BuyingTeamCreationService().teamIdSubject$.value,
        'type': '0'
      };
      BuyingTeamCreationService().payDataSubject$.sink.add({});

      NavigatorHelper().navigateToScreen('/threshold_view', arguments: map);
    } else {
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'type': '0',
        'api': '2',
        'isUpdate': isUpdate ? '1' : '0',
      });
      BuyingTeamCreationService().apiDataSubject$.sink.add(chargeData);
    }
  }

  getPeriond(int frequency) {
    String result = 'This is a subscription that will run ';

    if (frequency != 0) {
      int value = DateFormatUtil().epochToTotalWeeks(frequency);

      if (value == 1) {
        result += 'weekly';
      } else if (value >= 4) {
        int months =
            value ~/ 4; // Integer division to get the number of full months.
        int remainingWeeks =
            value % 4; // Remaining weeks after extracting full months.

        if (months > 0) {
          result += (months == 1)
              ? '${remainingWeeks > 0 ? '$months month' : 'monthly'}'
              : 'every $months months';
        }

        if (remainingWeeks > 0) {
          if (months > 0) {
            result += ' and ';
          }
          result += '$remainingWeeks week${remainingWeeks > 1 ? 's' : ''}';
        }
      } else {
        result += 'every $value weeks';
      }
    }
    return result +=
        ' until you cancel. You can cancel at anytime in the My Rabble section by quitting the team.';
  }

  Future<stripe.PaymentIntent> confirmPayment3DSecure(
      String clientSecret,
      String paymentMethodId,
      bool isUpdate,
      Map<String, dynamic> chargeData) async {
    stripe.PaymentIntent? paymentIntentRes_3dSecure;
    try {
      await stripe.Stripe.instance
          .confirmPayment(paymentIntentClientSecret: clientSecret);

      paymentIntentRes_3dSecure =
          await stripe.Stripe.instance.retrievePaymentIntent(clientSecret);

      print(
          "paymentIntentRes_3dSecure: ${paymentIntentRes_3dSecure.paymentMethodId}");
    } catch (e) {
      messageSubject$.sink.add({
        'json': 'assets/json/loader2.json',
        'msg': 'There was an error processing your payment',
        'type': '0',
        'api': '2',
        'isUpdate': isUpdate ? '1' : '0',
      });
      BuyingTeamCreationService().apiDataSubject$.sink.add(chargeData);
    }

    print('paymentIntentRes_3dSecure ${paymentIntentRes_3dSecure!.id}');
    return paymentIntentRes_3dSecure;
  }
}
