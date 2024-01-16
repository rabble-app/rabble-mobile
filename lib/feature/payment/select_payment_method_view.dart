import 'package:pay/pay.dart';
import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/CardModel.dart';
import 'package:shimmer/shimmer.dart';

class SelectPaymentMethodView extends StatefulWidget {
  const SelectPaymentMethodView({Key? key}) : super(key: key);

  @override
  State<SelectPaymentMethodView> createState() =>
      _SelectPaymentMethodViewState();
}

class _SelectPaymentMethodViewState extends State<SelectPaymentMethodView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, PaymentCubit>(
        create: (context) => PaymentCubit(fetchMyCard: true),
        builder: (context, state, bloc) {
          if (state.tertiaryBusy) {
            return BehaviorSubjectBuilder<Map>(
                subject: bloc.messageSubject$,
                builder: (context, snapshot) {
                  return RabblePerformanceLoader(
                    enabled: state.tertiaryBusy,
                    map: snapshot.data!,
                    tryAgainCallBack: (Map data) {
                      //Call charge payment API

                      if (snapshot.hasData) {
                        if (data['isUpdate'] == '1') {
                          if (data['api'] == '2') {
                            bloc.chargeCardPaymentforApplePayUpdate(
                                BuyingTeamCreationService()
                                    .apiDataSubject$
                                    .value,
                                true,
                                applePaymentResult: BuyingTeamCreationService()
                                    .appleDataSubject$
                                    .value);
                          } else {}
                        } else {
                          if (data['api'] == '2') {
                            bloc.chargeCardPayment(
                                BuyingTeamCreationService()
                                    .apiDataSubject$
                                    .value,
                                false,
                                applePaymentResult: BuyingTeamCreationService()
                                    .appleDataSubject$
                                    .value);
                          } else if (data['api'] == '3') {
                            bloc.createTeam(BuyingTeamCreationService()
                                .appleDataSubject$
                                .value);
                          } else {
                            bloc.uploadBasket(
                                TeamCreationModel.fromJson(data['team']));
                          }
                        }
                      }
                    },
                    controller: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 10000),
                    ),
                    child: Scaffold(
                      backgroundColor: APPColors.bgColor,
                      body: Column(
                        children: [
                          BehaviorSubjectBuilder<String>(
                              subject:
                                  BuyingTeamCreationService().groupNameSubject$,
                              builder: (context, snapshot) {
                                return CreationTeamAppbar(
                                  backTitle: kBackToBasket,
                                  title: snapshot.data,
                                  barPercentage: 4,
                                );
                              }),
                          Expanded(
                            child: Padding(
                              padding: PagePadding.all(4.w),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    RabbleText.subHeaderText(
                                      text: kSelectPaymentMethod,
                                      color: APPColors.appBlack4,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Center(
                                      child: ApplePayButton(
                                          width: context.allWidth,
                                          height: context.allHeight * 0.065,
                                          paymentConfiguration:
                                              PaymentConfiguration
                                                  .fromJsonString('''{
                                                                "provider": "apple_pay",
                                                                "data": {
                                                                  "merchantIdentifier": "merchant.com.postcodecollective",
                                                                  "displayName": "Postcode Collective",
                                                                  "merchantCapabilities": ["3DS", "debit", "credit"],
                                                                  "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
                                                                  "countryCode": "GB",
                                                                  "currencyCode": "GBP",
                                                                  "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"],
                                                                  "requiredShippingContactFields": [],
                                                                  "shippingMethods": [
                                                                    {
                                                                      "amount": "${BuyingTeamCreationService().payDataSubject$.value[mamount]}",
                                                                      "detail": "Available within an hour",
                                                                      "identifier": "in_store_pickup",
                                                                      "label": "In-Store Pickup"
                                                                    }
                                                                  ]
                                                                }
                                                              }'''),
                                          onError: (Object? val) {},
                                          onPaymentResult: (result) {
                                            BuyingTeamCreationService()
                                                .appleDataSubject$
                                                .sink
                                                .add(result);

                                            if (BuyingTeamCreationService()
                                                    .payDataSubject$
                                                    .value
                                                    .containsKey('update') &&
                                                BuyingTeamCreationService()
                                                    .payDataSubject$
                                                    .value['update']) {
                                              bloc.onUpdateApplePayment(result);
                                            } else {
                                              bloc.onApplePayment(result);
                                            }
                                          },
                                          paymentItems: [
                                            PaymentItem(
                                              label: 'Total',
                                              amount:
                                                  '${BuyingTeamCreationService().payDataSubject$.value[mamount]}',
                                              status:
                                                  PaymentItemStatus.final_price,
                                            ),
                                            PaymentItem(
                                              label: 'Postcode Collective',
                                              amount:
                                                  '${BuyingTeamCreationService().payDataSubject$.value[mamount]}',
                                              status:
                                                  PaymentItemStatus.final_price,
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 25.w,
                                          height: 1,
                                          margin: PagePadding.onlyRight(2.w),
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                APPColors.appWhite,
                                                APPColors.appBlue,
                                              ],
                                            ),
                                          ),
                                        ),
                                        RabbleText.subHeaderText(
                                          text: kOrPayByCardBelow,
                                          color: APPColors.appTextPrimary,
                                          fontSize: 10.sp,
                                          fontFamily: cPoppins,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        Container(
                                          width: 25.w,
                                          height: 1,
                                          margin: PagePadding.onlyLeft(2.w),
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                APPColors.appBlue,
                                                APPColors.appWhite,
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    state.primaryBusy
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.white,
                                            highlightColor: Colors.black,
                                            enabled: true,
                                            child: Center(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.08,
                                                width: context.allWidth,
                                                decoration: ContainerDecoration
                                                    .boxDecoration(
                                                        bg: Colors.transparent,
                                                        border:
                                                            APPColors.bg_grey25,
                                                        width: 1,
                                                        radius: 8),
                                                child: Padding(
                                                  padding: PagePadding.custom(
                                                      2.w, 2.w, 5.w, 5.w),
                                                ),
                                              ),
                                            ),
                                          )
                                        : BehaviorSubjectBuilder<
                                                List<CardData>>(
                                            subject: bloc.myCardListSubject$,
                                            builder: (context, myCardDataSnap) {
                                              return Container(
                                                height: myCardDataSnap
                                                            .data!.length ==
                                                        1
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.17
                                                    : myCardDataSnap
                                                                .data!.length ==
                                                            0
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.08
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.27,
                                                width: context.allWidth,
                                                decoration: ContainerDecoration
                                                    .boxDecoration(
                                                        bg: Colors.transparent,
                                                        border:
                                                            APPColors.bg_grey25,
                                                        width: 1,
                                                        radius: 8),
                                                child: Column(
                                                  children: [
                                                    myCardDataSnap
                                                            .data!.isNotEmpty
                                                        ? Expanded(
                                                            child: ListView
                                                                .builder(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    physics: myCardDataSnap.data!.length ==
                                                                            1
                                                                        ? const NeverScrollableScrollPhysics()
                                                                        : const ClampingScrollPhysics(),
                                                                    itemCount:
                                                                        myCardDataSnap
                                                                            .data!
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      CardData
                                                                          cardDetail =
                                                                          myCardDataSnap
                                                                              .data![index];

                                                                      return Column(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              bloc.onCardSelection(cardDetail, index);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              padding: PagePadding.custom(4.w, 4.w, 3.w, 3.w),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Icon(
                                                                                    cardDetail.isSelected! ? Icons.circle : Icons.circle_outlined,
                                                                                    color: cardDetail.isSelected! ? APPColors.appPrimaryColor : APPColors.bg_grey27,
                                                                                    size: 20.sp,
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: 2.w,
                                                                                          ),
                                                                                          RabbleText.subHeaderText(
                                                                                            text: kEnding,
                                                                                            textAlign: TextAlign.start,
                                                                                            color: APPColors.appBlack,
                                                                                            fontSize: 12.sp,
                                                                                            fontFamily: cPoppins,
                                                                                            fontWeight: FontWeight.w400,
                                                                                          ),
                                                                                          RabbleText.subHeaderText(
                                                                                            text: cardDetail.card!.last4,
                                                                                            fontFamily: cPoppins,
                                                                                            fontSize: 12.sp,
                                                                                            color: APPColors.appTextPrimary,
                                                                                            fontWeight: FontWeight.w700,
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 0.4.h,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  const Spacer(),
                                                                                  Container(
                                                                                    height: context.allHeight * 0.05,
                                                                                    width: context.allHeight * 0.08,
                                                                                    decoration: ContainerDecoration.boxDecoration(bg: Colors.transparent, border: APPColors.bg_grey25, width: 1, radius: 8),
                                                                                    child: bloc.getIconOfCard(cardDetail.card!.brand!).svg(width: 12.w, height: 4.h, fit: BoxFit.scaleDown),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Divider(
                                                                            thickness:
                                                                                1,
                                                                            height:
                                                                                1,
                                                                            color:
                                                                                APPColors.bg_grey25,
                                                                          ),
                                                                        ],
                                                                      );
                                                                    }),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                    myCardDataSnap
                                                            .data!.isNotEmpty
                                                        ? const Divider(
                                                            thickness: 1,
                                                            height: 1,
                                                            color: APPColors
                                                                .bg_grey25,
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ],
                                                ),
                                              );
                                            }),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      bottomNavigationBar: BehaviorSubjectBuilder<CardData>(
                          subject: bloc.paymentMethodSelectedSubject$,
                          builder: (context, snapshot) {
                            return Container(
                              margin: PagePadding.all(4.w),
                              child: RabbleButton.tertiaryFilled(
                                bgColor: snapshot.hasData
                                    ? APPColors.appPrimaryColor
                                    : APPColors.bg_grey25,
                                onPressed: () {
                                  BuyingTeamCreationService().addPaymentData(
                                      mpaymentMethodId,
                                      snapshot.data!.id.toString());

                                  NavigatorHelper()
                                      .navigateTo('/review_payment_view');
                                },
                                child: RabbleText.subHeaderText(
                                  text: kContinue,
                                  fontSize: 14.sp,
                                  fontFamily: 'Gosha',
                                  color: snapshot.hasData
                                      ? APPColors.appBlack
                                      : APPColors.bg_grey27,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                });
          } else {
            return Scaffold(
                backgroundColor: APPColors.bgColor,
                body: Column(
                  children: [
                    BehaviorSubjectBuilder<String>(
                        subject: BuyingTeamCreationService().groupNameSubject$,
                        builder: (context, snapshot) {
                          return CreationTeamAppbar(
                            backTitle: kBackToBasket,
                            title: snapshot.data,
                            barPercentage: 4,
                          );
                        }),
                    Expanded(
                      child: Padding(
                        padding: PagePadding.all(4.w),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 1.5.h,
                              ),
                              RabbleText.subHeaderText(
                                text: kSelectPaymentMethod,
                                color: APPColors.appBlack4,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Center(
                                child: ApplePayButton(
                                    width: context.allWidth,
                                    height: context.allHeight * 0.065,
                                    paymentConfiguration:
                                        PaymentConfiguration.fromJsonString('''{
                                                                "provider": "apple_pay",
                                                                "data": {
                                                                  "merchantIdentifier": "merchant.com.postcodecollective",
                                                                  "displayName": "Postcode Collective",
                                                                  "merchantCapabilities": ["3DS", "debit", "credit"],
                                                                  "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
                                                                  "countryCode": "GB",
                                                                  "currencyCode": "GBP",
                                                                  "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"],
                                                                  "requiredShippingContactFields": [],
                                                                  "shippingMethods": [
                                                                    {
                                                                      "amount": "${BuyingTeamCreationService().payDataSubject$.value[mamount]}",
                                                                      "detail": "Available within an hour",
                                                                      "identifier": "in_store_pickup",
                                                                      "label": "In-Store Pickup"
                                                                    }
                                                                  ]
                                                                }
                                                              }'''),
                                    onError: (Object? val) {},
                                    onPaymentResult: (result) {
                                      BuyingTeamCreationService()
                                          .appleDataSubject$
                                          .sink
                                          .add(result);

                                      if (BuyingTeamCreationService()
                                              .payDataSubject$
                                              .value
                                              .containsKey('update') &&
                                          BuyingTeamCreationService()
                                              .payDataSubject$
                                              .value['update']) {
                                        bloc.onUpdateApplePayment(result);
                                      } else {
                                        bloc.onApplePayment(result);
                                      }
                                    },
                                    paymentItems: [
                                      PaymentItem(
                                        label: 'Total',
                                        amount:
                                            '${BuyingTeamCreationService().payDataSubject$.value[mamount]}',
                                        status: PaymentItemStatus.final_price,
                                      ),
                                      PaymentItem(
                                        label: 'Postcode Collective',
                                        amount:
                                            '${BuyingTeamCreationService().payDataSubject$.value[mamount]}',
                                        status: PaymentItemStatus.final_price,
                                      )
                                    ]),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 25.w,
                                    height: 1,
                                    margin: PagePadding.onlyRight(2.w),
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          APPColors.appWhite,
                                          APPColors.appBlue,
                                        ],
                                      ),
                                    ),
                                  ),
                                  RabbleText.subHeaderText(
                                    text: kOrPayByCardBelow,
                                    color: APPColors.appTextPrimary,
                                    fontSize: 10.sp,
                                    fontFamily: cPoppins,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Container(
                                    width: 25.w,
                                    height: 1,
                                    margin: PagePadding.onlyLeft(2.w),
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          APPColors.appBlue,
                                          APPColors.appWhite,
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              state.primaryBusy
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.white,
                                      highlightColor: Colors.black,
                                      enabled: true,
                                      child: Center(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          width: context.allWidth,
                                          decoration:
                                              ContainerDecoration.boxDecoration(
                                                  bg: Colors.transparent,
                                                  border: APPColors.bg_grey25,
                                                  width: 1,
                                                  radius: 8),
                                          child: Padding(
                                            padding: PagePadding.custom(
                                                2.w, 2.w, 5.w, 5.w),
                                          ),
                                        ),
                                      ),
                                    )
                                  : BehaviorSubjectBuilder<List<CardData>>(
                                      subject: bloc.myCardListSubject$,
                                      builder: (context, myCardDataSnap) {
                                        return Container(
                                          height: myCardDataSnap.data!.length ==
                                                  1
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.17
                                              : myCardDataSnap.data!.length == 0
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.08
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.27,
                                          width: context.allWidth,
                                          decoration:
                                              ContainerDecoration.boxDecoration(
                                                  bg: Colors.transparent,
                                                  border: APPColors.bg_grey25,
                                                  width: 1,
                                                  radius: 8),
                                          child: Column(
                                            children: [
                                              myCardDataSnap.data!.isNotEmpty
                                                  ? Expanded(
                                                      child: ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          physics: myCardDataSnap
                                                                      .data!
                                                                      .length ==
                                                                  1
                                                              ? const NeverScrollableScrollPhysics()
                                                              : const ClampingScrollPhysics(),
                                                          itemCount:
                                                              myCardDataSnap
                                                                  .data!.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            CardData
                                                                cardDetail =
                                                                myCardDataSnap
                                                                        .data![
                                                                    index];

                                                            return Column(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    bloc.onCardSelection(
                                                                        cardDetail,
                                                                        index);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: PagePadding
                                                                        .custom(
                                                                            4.w,
                                                                            4.w,
                                                                            3.w,
                                                                            3.w),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Icon(
                                                                          cardDetail.isSelected!
                                                                              ? Icons.circle
                                                                              : Icons.circle_outlined,
                                                                          color: cardDetail.isSelected!
                                                                              ? APPColors.appPrimaryColor
                                                                              : APPColors.bg_grey27,
                                                                          size:
                                                                              20.sp,
                                                                        ),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 2.w,
                                                                                ),
                                                                                RabbleText.subHeaderText(
                                                                                  text: kEnding,
                                                                                  textAlign: TextAlign.start,
                                                                                  color: APPColors.appBlack,
                                                                                  fontSize: 12.sp,
                                                                                  fontFamily: cPoppins,
                                                                                  fontWeight: FontWeight.w400,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 1.w,
                                                                                ),
                                                                                RabbleText.subHeaderText(
                                                                                  text: cardDetail.card!.last4,
                                                                                  fontFamily: cPoppins,
                                                                                  fontSize: 12.sp,
                                                                                  color: APPColors.appTextPrimary,
                                                                                  fontWeight: FontWeight.w700,
                                                                                )
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 0.4.h,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const Spacer(),
                                                                        Container(
                                                                          height:
                                                                              context.allHeight * 0.05,
                                                                          width:
                                                                              context.allHeight * 0.08,
                                                                          decoration: ContainerDecoration.boxDecoration(
                                                                              bg: Colors.transparent,
                                                                              border: APPColors.bg_grey25,
                                                                              width: 1,
                                                                              radius: 8),
                                                                          child: bloc.getIconOfCard(cardDetail.card!.brand!).svg(
                                                                              width: 12.w,
                                                                              height: 4.h,
                                                                              fit: BoxFit.scaleDown),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Divider(
                                                                  thickness: 1,
                                                                  height: 1,
                                                                  color: APPColors
                                                                      .bg_grey25,
                                                                ),
                                                              ],
                                                            );
                                                          }),
                                                    )
                                                  : const SizedBox.shrink(),
                                              myCardDataSnap.data!.isNotEmpty
                                                  ? const Divider(
                                                      thickness: 1,
                                                      height: 1,
                                                      color:
                                                          APPColors.bg_grey25,
                                                    )
                                                  : const SizedBox.shrink(),
                                              InkWell(
                                                onTap: () {
                                                  NavigatorHelper()
                                                      .navigateTo(
                                                          '/add_payment_view')
                                                      .then((value) {
                                                    bloc.fetchMyCards();
                                                  });
                                                },
                                                child: Padding(
                                                  padding: PagePadding.custom(
                                                      2.w, 2.w, 5.w, 5.w),
                                                  child:
                                                      RabbleText.subHeaderText(
                                                    text: kAddANewCard,
                                                    color: APPColors.appBlack,
                                                    fontSize: 14.sp,
                                                    fontFamily: cGosha,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                              BehaviorSubjectBuilder<int>(
                                  subject: bloc.deadlineCountSubject$,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const SizedBox.shrink();
                                    }
                                    if (snapshot.data! > 0) {
                                      return const SizedBox.shrink();
                                    }
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Container(
                                          decoration: ContainerDecoration.boxDecoration(
                                            border: APPColors.appBlue,
                                            bg: APPColors.bg_grey34,
                                            width: 1,
                                            radius: 8
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.info,
                                                  color: APPColors.appBlue,
                                                  size: 24,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: context.allWidth*0.79,
                                                  child: RabbleText.subHeaderText(
                                                    text: bloc.getNextOrderDate(BuyingTeamCreationService()
                                                        .creationDataSubject$
                                                        .value[mFrequency] !=
                                                        null
                                                        ? BuyingTeamCreationService()
                                                        .creationDataSubject$
                                                        .value[mFrequency] ??
                                                        ''
                                                        : 0),
                                                    textAlign: TextAlign.start,
                                                    fontFamily: cPoppins,
                                                    fontWeight: FontWeight.w500,
                                                    color: APPColors.appBlue,
                                                    fontSize: 8.5.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              SizedBox(
                                height: 1.h,
                              ),
                              RabbleText.subHeaderText(
                                text:
                                    '${bloc.getPeriond(BuyingTeamCreationService().creationDataSubject$.value[mFrequency] != null ? BuyingTeamCreationService().creationDataSubject$.value[mFrequency] ?? '' : 0)}',
                                fontSize: 9.sp,
                                fontFamily: cPoppins,
                                height: 1.3,
                                textAlign: TextAlign.start,
                                color: APPColors.bg_grey27,
                                fontWeight: FontWeight.normal,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: bloc.deadlineCountSubject$.hasValue &&
                        bloc.deadlineCountSubject$.value <= 0
                    ? BehaviorSubjectBuilder<CardData>(
                        subject: bloc.paymentMethodSelectedSubject$,
                        builder: (context, snapshot) {
                          return bloc.state.secondaryBusy
                              ? Container(
                                  width: 20.w,
                                  height: 15.h,
                                  padding: PagePadding.horizontalSymmetric(5.w),
                                  child: const Center(
                                    child:
                                        RabbleSecondaryScreenProgressIndicator(
                                      enabled: true,
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: PagePadding.all(4.w),
                                  child: RabbleButton.tertiaryFilled(
                                    bgColor: snapshot.hasData
                                        ? APPColors.appPrimaryColor
                                        : APPColors.bg_grey25,
                                    onPressed: () {
                                      if (bloc.deadlineCountSubject$.value <=
                                          0) {
                                        bloc.uploadBasketForNewUser();
                                      }
                                    },
                                    child: RabbleText.subHeaderText(
                                      text: kContinue,
                                      fontSize: 14.sp,
                                      fontFamily: 'Gosha',
                                      color: snapshot.hasData
                                          ? APPColors.appBlack
                                          : APPColors.bg_grey27,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                        })
                    : BehaviorSubjectBuilder<CardData>(
                        subject: bloc.paymentMethodSelectedSubject$,
                        builder: (context, snapshot) {
                          return Container(
                            margin: PagePadding.all(4.w),
                            child: RabbleButton.tertiaryFilled(
                              bgColor: snapshot.hasData
                                  ? APPColors.appPrimaryColor
                                  : APPColors.bg_grey25,
                              onPressed: () {
                                BuyingTeamCreationService().addPaymentData(
                                    mpaymentMethodId,
                                    snapshot.data!.id.toString());

                                NavigatorHelper()
                                    .navigateTo('/review_payment_view');
                              },
                              child: RabbleText.subHeaderText(
                                text: kContinue,
                                fontSize: 14.sp,
                                fontFamily: 'Gosha',
                                color: snapshot.hasData
                                    ? APPColors.appBlack
                                    : APPColors.bg_grey27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }));
          }
        });
  }
}
