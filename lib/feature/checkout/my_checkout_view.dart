import 'package:rabble/core/config/export.dart';
import 'package:rabble/core/widgets/empty_state_widget.dart';
import 'package:rabble/domain/entities/UserBasketModel.dart';
import 'package:rabble/feature/checkout/checkout_shimmer.dart';
import 'package:rabble/feature/producer/widget/producer_item_shimmer.dart';

class MyCheckoutView extends StatelessWidget {
  MyCheckoutView({Key? key}) : super(key: key);

  CheckoutCubit checkoutCubit = CheckoutCubit();

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;

    TeamData teamData = data['teamData'];
    CurrentOrderData currentOrderData = data['order'];
    print('currentOrderData ${currentOrderData.toString()}');
    print('currentOrderId ${currentOrderData.id}');
    String myId = data['myId'];
    String memberId = data['memberId'];

    int remainingDays = currentOrderData.deadline != null
        ? DateFormatUtil.remainingDays(currentOrderData.deadline!)
        : 0;

    return CubitProvider<RabbleBaseState, CheckoutCubit>(
        create: (context) => checkoutCubit
          ..fetchUserBasket(teamData.id!)
          ..fetchUserData(),
        builder: (context, state, bloc) {
          return state.primaryBusy
              ? Scaffold(
                  backgroundColor: APPColors.bg_app_primary,
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(8.h),
                      child: RabbleAppbar(
                        backgroundColor: Colors.transparent,
                        backTitle: kBack,
                        leadingWidth: 25.w,
                        title: teamData.count!.order! > 1 ? kYB : KUO,
                      )),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: PagePadding.horizontalSymmetric(4.w),
                          child: ShippingCardCustom(
                            color: Colors.grey.shade300,
                            label: '',
                            value: '',
                            icon: SizedBox(),
                          ),
                        ),
                        ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return const CheckoutShimmer();
                            }),
                      ],
                    ),
                  ),
                )
              : BehaviorSubjectBuilder<List<UserBasketData>>(
                  subject: bloc.myBasketList,
                  builder: (context, productList) {
                    return Scaffold(
                      backgroundColor: APPColors.bg_app_primary,
                      appBar: PreferredSize(
                          preferredSize: Size.fromHeight(8.h),
                          child: RabbleAppbar(
                            backgroundColor: Colors.transparent,
                            backTitle: kBack,
                            leadingWidth: 25.w,
                            title: teamData.count!.order! > 1 ? kYB : KUO,
                          )),
                      body: productList.data!.isEmpty
                          ? Center(
                              child: EmptyStateWidget(
                                  isBasket: true,
                                  heading: kStartShopping,
                                  subHeading: kStartShoppingDetail,
                                  svg: Assets.svgs.basket_empty,
                                  btnHeading: kAddProduct,
                                  callback: () {
                                    NavigatorHelper()
                                        .navigateTo('/producer_list_view', '');
                                  }),
                            )
                          : RabbleFullScreenProgressIndicator(
                              enabled: state.primaryBusy,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Padding(
                                            padding:
                                                PagePadding.horizontalSymmetric(
                                                    4.w),
                                            child: ShippingCardCustom(
                                              isTeamPage: true,
                                              label: '',
                                              value:
                                                  'Next shipping ${currentOrderData.deliveryDate != null ? '${int.parse(DateFormatUtil.countDays(currentOrderData.deliveryDate!)) < 7 ? "in ${DateFormatUtil.countDays(currentOrderData.deliveryDate!)} days" : DateFormatUtil.formatDate(currentOrderData.deliveryDate!, 'dd MMM yyyy')} ' : 'date not yet fixed'}',
                                              icon:
                                                  Assets.svgs.truck_blue.svg(),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                PagePadding.horizontalSymmetric(
                                                    4.w),
                                            child: ListView.builder(
                                                itemCount:
                                                    productList.data!.length,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) {
                                                  UserBasketData item =
                                                      productList.data![index];

                                                  return CartItemWidget(
                                                    isLast: productList
                                                                .data!.length -
                                                            1 ==
                                                        index,
                                                    imageUrl: item.product!.imageUrl,
                                                    itemName:
                                                        item.product!.name!,
                                                    price: DateFormatUtil
                                                        .amountFormatter(
                                                            double.parse(item
                                                                .price
                                                                .toString())),
                                                    producerName: teamData
                                                        .producer!
                                                        .businessName!,
                                                    productType:
                                                        item.product!.type!,
                                                    orderSubUnit: item
                                                        .product!.orderSubUnit,
                                                    unitsPerOrder: item
                                                        .product!.unitsPerOrder,
                                                    thresholdQty: item.product!
                                                        .thresholdQuantity!
                                                        .toInt(),
                                                    unitsOfMeasure: item
                                                        .product!
                                                        .unitsOfMeasure,
                                                    orderUnit:
                                                        item.product!.orderUnit,
                                                    totalThresholdQty: item
                                                        .product!
                                                        .totalThresholdQuantity!
                                                        .toInt(),
                                                    qtyCallBack: state
                                                            .secondaryBusy
                                                        ? () {}
                                                        : (qty) {
                                                            print('qty $qty');
                                                            print(
                                                                'item.quantity ${item.quantity}');
                                                            if (qty <
                                                                item.quantity) {
                                                              if (teamData
                                                                      .count!
                                                                      .order !=
                                                                  1) {
                                                                bloc.increaseQty(
                                                                    qty, item);
                                                              } else {
                                                                globalBloc.showWarningSnackBar(
                                                                    message:
                                                                        'Your order is already processed. You will be able to change your basket for the next order',
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            3000));
                                                              }
                                                            } else {
                                                              bloc.decreaseQty(
                                                                  qty, item);
                                                            }
                                                          },
                                                    removeProduct: () async {
                                                      if (teamData
                                                              .count!.order !=
                                                          1) {
                                                        await bloc.removeFromBasket(
                                                            item.id!,
                                                            remainingDays,
                                                            currentOrderData
                                                                .deadline!,
                                                            memberId,
                                                            context,
                                                            teamData.hostId,
                                                            teamData
                                                                .count!.order!
                                                                .toInt(),
                                                            DateFormatUtil.calculatePercentage(
                                                                int.parse(currentOrderData
                                                                    .accumulatedAmount!
                                                                    .toString()),
                                                                int.parse(currentOrderData
                                                                    .minimumTreshold!
                                                                    .toString())));
                                                      } else {
                                                        globalBloc.showWarningSnackBar(
                                                            message:
                                                                'Your order is already processed. You will be able to change your basket for the next order',
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        3000));
                                                      }
                                                    },
                                                    qty: item.quantity
                                                        .toString(),
                                                  );
                                                }),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  BehaviorSubjectBuilder<UserModel>(
                                      subject: bloc.userDataSubject$,
                                      builder: (context, snapshot) {
                                        return BehaviorSubjectBuilder<double>(
                                            subject: bloc.totalSum,
                                            builder: (context, totalSumSnap) {
                                              return Container(
                                                width: 100.w,
                                                decoration: ContainerDecoration
                                                    .boxDecoration(
                                                        bg: APPColors.appWhite,
                                                        border: APPColors
                                                            .appLightWhite,
                                                        radius: 10,
                                                        width: 1),
                                                child: Padding(
                                                  padding: PagePadding.all(5.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      RabbleText.subHeaderText(
                                                        text: kOrderSummary,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.sp,
                                                        fontFamily: cGosha,
                                                        color:
                                                            APPColors.appBlack4,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          RabbleText
                                                              .subHeaderText(
                                                            text: kSubTotal,
                                                            fontSize: 11.sp,
                                                            fontFamily:
                                                                cPoppins,
                                                            textAlign:
                                                                TextAlign.start,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: APPColors
                                                                .appTextPrimary,
                                                          ),
                                                          RabbleText
                                                              .subHeaderText(
                                                            text: DateFormatUtil.amountFormatter(double.parse(calCulateAmountToPay(
                                                                double.parse(
                                                                    getTotalAmount(
                                                                        productList
                                                                            .data)),
                                                                double.parse(getMyPaidPayment(
                                                                    currentOrderData
                                                                        .payments,
                                                                    snapshot
                                                                        .data!
                                                                        .id!))))),
                                                            fontSize: 11.sp,
                                                            fontFamily:
                                                                cPoppins,
                                                            textAlign:
                                                                TextAlign.start,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: APPColors
                                                                .appTextPrimary,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          RabbleText
                                                              .subHeaderText(
                                                            text: kDeliveryfee,
                                                            fontSize: 11.sp,
                                                            fontFamily:
                                                                cPoppins,
                                                            textAlign:
                                                                TextAlign.start,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: APPColors
                                                                .appTextPrimary,
                                                          ),
                                                          RabbleText
                                                              .subHeaderText(
                                                            text: '£0.00',
                                                            fontSize: 11.sp,
                                                            fontFamily:
                                                                cPoppins,
                                                            textAlign:
                                                                TextAlign.start,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: APPColors
                                                                .appTextPrimary,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              RabbleText
                                                                  .subHeaderText(
                                                                text:
                                                                    kTotalPriceWithVat,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14.sp,
                                                              ),
                                                              RabbleText
                                                                  .subHeaderText(
                                                                text: kvAT,
                                                                height: 1.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 8.sp,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(width: 5.w),
                                                          RabbleText
                                                              .subHeaderText(
                                                            text: DateFormatUtil.amountFormatter(double.parse(calCulateAmountToPay(
                                                                double.parse(
                                                                    getTotalAmount(
                                                                        productList
                                                                            .data)),
                                                                double.parse(getMyPaidPayment(
                                                                    currentOrderData
                                                                        .payments,
                                                                    snapshot
                                                                        .data!
                                                                        .id!))))),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }),
                                ],
                              ),
                            ),
                      bottomNavigationBar: state.tertiaryBusy
                          ? Container(
                              width: 20.w,
                              height: 8.h,
                              padding: PagePadding.horizontalSymmetric(5.w),
                              child: const Center(
                                child: RabbleSecondaryScreenProgressIndicator(
                                  enabled: true,
                                ),
                              ),
                            )
                          : productList.data?.every((element) =>
                                          element.update == null ||
                                          !element.update!) ==
                                      true &&
                                  double.parse(calCulateAmountToPay(
                                          double.parse(
                                              getTotalAmount(productList.data)),
                                          double.parse(getMyPaidPayment(
                                              currentOrderData.payments,
                                              bloc.userDataSubject$.value
                                                  .id!)))) <=
                                      0
                              ? const SizedBox.shrink()
                              : Container(
                                  color: APPColors.appBlack,
                                  padding:
                                      PagePadding.custom(4.w, 4.w, 5.w, 5.w),
                                  child: RabbleButton.tertiaryFilled(
                                    buttonSize: ButtonSize.large,
                                    bgColor: APPColors.appPrimaryColor,
                                    onPressed: () async {
                                      if (remainingDays <= 0) {
                                        await bloc
                                            .updateBasket(
                                                teamData.id!,
                                                currentOrderData.id!,
                                                remainingDays,
                                                myId,
                                                currentOrderData.payments,
                                                teamData.count!.order)
                                            .then((value) {
                                          if (remainingDays > 0) {
                                            if (value) {
                                              if (BuyingTeamCreationService()
                                                      .payDataSubject$
                                                      .value[mamount] >
                                                  0) {
                                                BuyingTeamCreationService().addPaymentData(
                                                    mamount,
                                                    double.parse(calCulateAmountToPay(
                                                        double.parse(
                                                            getTotalAmount(
                                                                productList
                                                                    .data)),
                                                        double.parse(
                                                            getMyPaidPayment(
                                                                currentOrderData
                                                                    .payments,
                                                                bloc
                                                                    .userDataSubject$
                                                                    .value
                                                                    .id!)))));

                                                BuyingTeamCreationService()
                                                    .groupNameSubject$
                                                    .sink
                                                    .add(teamData.name!);

                                                BuyingTeamCreationService()
                                                    .addTeamCreationData(
                                                        mName, teamData.name!);

                                                BuyingTeamCreationService()
                                                    .addTeamCreationData(
                                                        mProducerName,
                                                        teamData.producer!
                                                            .businessName!);

                                                BuyingTeamCreationService()
                                                    .addTeamCreationData(
                                                        mProducerId,
                                                        teamData.producerId);

                                                BuyingTeamCreationService()
                                                    .addTeamCreationData(
                                                        mProducerId,
                                                        teamData.producerId);

                                                BuyingTeamCreationService()
                                                    .addPaymentData(
                                                        mcurrency, "GBP");

                                                BuyingTeamCreationService()
                                                    .addPaymentData(
                                                        'update', true);

                                                BuyingTeamCreationService()
                                                    .addPaymentData(
                                                        'teamId',
                                                        currentOrderData
                                                            .teamId);

                                                BuyingTeamCreationService()
                                                    .orderIdSubject$
                                                    .sink
                                                    .add(currentOrderData.id!);

                                                BuyingTeamCreationService()
                                                    .teamIdSubject$
                                                    .sink
                                                    .add(currentOrderData
                                                        .teamId!);
                                                BuyingTeamCreationService()
                                                    .isAuthSubject$
                                                    .sink
                                                    .add(false);

                                                BuyingTeamCreationService()
                                                    .addTeamCreationData(
                                                        mFrequency,
                                                        teamData.frequency!
                                                            .toInt());

                                                NavigatorHelper().navigateTo(
                                                    '/select_payment_method_view');
                                              } else {
                                                Map map = {
                                                  'teamId':
                                                      currentOrderData.teamId,
                                                  'type': '0'
                                                };
                                                NavigatorHelper()
                                                    .navigateToScreen(
                                                        '/threshold_view',
                                                        arguments: map);
                                              }
                                            }
                                          } else {
                                            if (value) {
                                              Map map = {
                                                'teamId':
                                                    currentOrderData.teamId,
                                                'type': '0'
                                              };
                                              NavigatorHelper()
                                                  .navigateToScreen(
                                                      '/threshold_view',
                                                      arguments: map);
                                            }
                                          }
                                        });
                                      } else {
                                        double originalValue = double.parse(
                                            calCulateAmountToPay(
                                                double.parse(getTotalAmount(
                                                    productList.data)),
                                                double.parse(getMyPaidPayment(
                                                    currentOrderData.payments,
                                                    bloc.userDataSubject$.value
                                                        .id!))));

                                        double roundedValue = double.parse(
                                            originalValue.toStringAsFixed(2));

                                        BuyingTeamCreationService()
                                            .addPaymentData(
                                                mamount, roundedValue);

                                        BuyingTeamCreationService()
                                            .groupNameSubject$
                                            .sink
                                            .add(teamData.name!);

                                        BuyingTeamCreationService()
                                            .addTeamCreationData(
                                                mName, teamData.name!);

                                        BuyingTeamCreationService()
                                            .addTeamCreationData(
                                                mProducerName,
                                                teamData
                                                    .producer!.businessName!);

                                        BuyingTeamCreationService()
                                            .addTeamCreationData(mProducerId,
                                                teamData.producerId);

                                        BuyingTeamCreationService()
                                            .addTeamCreationData(mProducerId,
                                                teamData.producerId);

                                        BuyingTeamCreationService()
                                            .addPaymentData(mcurrency, "GBP");

                                        BuyingTeamCreationService()
                                            .addPaymentData('update', true);

                                        BuyingTeamCreationService()
                                            .addPaymentData('teamId',
                                                currentOrderData.teamId);

                                        BuyingTeamCreationService()
                                            .orderIdSubject$
                                            .sink
                                            .add(currentOrderData.id!);

                                        BuyingTeamCreationService()
                                            .teamIdSubject$
                                            .sink
                                            .add(currentOrderData.teamId!);
                                        BuyingTeamCreationService()
                                            .isAuthSubject$
                                            .sink
                                            .add(false);

                                        BuyingTeamCreationService()
                                            .addTeamCreationData(mFrequency,
                                                teamData.frequency!.toInt());

                                        List<Map<String, dynamic>>
                                            bulkBasketItems =
                                            bloc.myBasketList.value.map(
                                                (UserBasketData productDetail) {
                                          print(
                                              "productDetail.product!.type ${productDetail.product!.type}");

                                          if (productDetail.product!.type ==
                                              'PORTIONED_SINGLE_PRODUCT') {
                                            return {
                                              'basketId': productDetail.id,
                                              'quantity':
                                                  productDetail.quantity,
                                              'price': productDetail.price,
                                              'type':
                                                  'PORTIONED_SINGLE_PRODUCT',
                                              'portionId': productDetail
                                                      .product!
                                                      .partionedProducts!
                                                      .first
                                                      .id ??
                                                  '',
                                              'newAccumulatorValue':
                                                  productDetail
                                                      .product!
                                                      .partionedProducts!
                                                      .first
                                                      .accumulator
                                            };
                                          } else {
                                            return {
                                              'basketId': productDetail.id,
                                              'quantity':
                                                  productDetail.quantity,
                                              'type':
                                                  productDetail.product!.type,
                                              'price': productDetail.price,
                                            };
                                          }
                                        }).toList();

                                        BuyingTeamCreationService()
                                            .myBasketList
                                            .add(bulkBasketItems);

                                        NavigatorHelper().navigateTo(
                                            '/select_payment_method_view');
                                      }
                                    },
                                    child: state.secondaryBusy
                                        ? const RabbleSecondaryScreenProgressIndicator(
                                            enabled: true,
                                          )
                                        : RabbleText.subHeaderText(
                                            text: 'Update Basket',
                                            fontSize: 13.sp,
                                            fontFamily: cGosha,
                                            color: APPColors.appBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                  ),
                                ),
                    );
                  });
        });
  }

  getTotalAmount(List<UserBasketData>? basket) {
    print(
        'Total Amount ${basket!.fold('0', (previousValue, element) => (double.parse(previousValue) + double.parse(element.price.toString()) * element.quantity!).toString())}');

    return basket.fold(
        '0',
        (previousValue, element) => (double.parse(previousValue) +
                double.parse(element.price.toString()) * element.quantity!)
            .toString());
  }

  getMyPaidPayment(List<Payments>? basket, String myId) {
    print(
        'Paid Amount ${basket!.fold('0', (previousValue, element) => element.userId == myId ? (double.parse(previousValue) + double.parse(element.amount.toString())).toString() : previousValue)}');
    return basket.fold(
        '0',
        (previousValue, element) => element.userId == myId
            ? (double.parse(previousValue) +
                    double.parse(element.amount.toString()))
                .toString()
            : previousValue);
  }

  calCulateAmountToPay(double totalAmount, double myPaidPayment) {
    return (totalAmount - myPaidPayment).toString();
  }
}
