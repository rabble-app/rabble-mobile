import 'package:rabble/core/config/export.dart';
import 'package:rabble/core/widgets/empty_state_widget.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;

    return CubitProvider<RabbleBaseState, CheckoutCubit>(
        create: (context) => CheckoutCubit()..fetchAllProducts(),
        builder: (context, state, bloc) {
          return BehaviorSubjectBuilder<List<ProductDetail>>(
              subject: bloc.productList,
              builder: (context, productList) {
                return Scaffold(
                  backgroundColor: APPColors.bgColor,
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(8.h),
                      child: const RabbleAppbar(
                        backgroundColor: Colors.transparent,
                        backTitle: kBack,
                        title: kBasket,
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
                                  physics: const ClampingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Container(
                                        color: APPColors.appYellow,
                                        height: 5.h,
                                        child: Center(
                                          child: RabbleText.subHeaderText(
                                            text: kConfirmYourOrder,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: cGosha,
                                            color: APPColors.appBlack,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Container(
                                        margin: PagePadding.horizontalSymmetric(
                                            3.5.w),
                                        child: CartWidget(
                                          checkoutCubit: bloc,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              BehaviorSubjectBuilder<double>(
                                  subject: bloc.totalSum,
                                  builder: (context, totalSumSnap) {
                                    return Container(
                                      width: 100.w,
                                      decoration:
                                          ContainerDecoration.boxDecoration(
                                              bg: APPColors.appWhite,
                                              border: APPColors.appLightWhite,
                                              radius: 10,
                                              width: 1),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: PagePadding
                                                .customHorizontalVerticalSymmetric(
                                                    3.5.w, 4.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                RabbleText.subHeaderText(
                                                  text: kOrderSummary,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10.sp,
                                                  fontFamily: cPoppins,
                                                  color: APPColors.appBlack4,
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    RabbleText.subHeaderText(
                                                      text: kSubTotal,
                                                      fontSize: 9.sp,
                                                      fontFamily: cPoppins,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textAlign:
                                                          TextAlign.start,
                                                      color: APPColors
                                                          .appTextPrimary,
                                                    ),
                                                    RabbleText.subHeaderText(
                                                      text: DateFormatUtil
                                                          .amountFormatter(double
                                                              .parse(totalSumSnap
                                                                  .data
                                                                  .toString())),
                                                      fontSize: 9.sp,
                                                      fontFamily: cPoppins,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textAlign:
                                                          TextAlign.start,
                                                      color: APPColors
                                                          .appTextPrimary,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    RabbleText.subHeaderText(
                                                      text: kDeliveryfee,
                                                      fontSize: 9.sp,
                                                      fontFamily: cPoppins,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textAlign:
                                                          TextAlign.start,
                                                      color: APPColors
                                                          .appTextPrimary,
                                                    ),
                                                    RabbleText.subHeaderText(
                                                      text: '£0.00',
                                                      textAlign:
                                                          TextAlign.start,
                                                      fontSize: 9.sp,
                                                      fontFamily: cPoppins,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: APPColors
                                                          .appTextPrimary,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                BehaviorSubjectBuilder<double>(
                                                    subject: bloc.totalDiscount,
                                                    initialData: 0.0,
                                                    builder:
                                                        (context, snapshot) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          RabbleText
                                                              .subHeaderText(
                                                            text: kDiscount,
                                                            fontSize: 9.sp,
                                                            fontFamily:
                                                                cPoppins,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            textAlign:
                                                                TextAlign.start,
                                                            color: APPColors
                                                                .appBlue,
                                                          ),
                                                          RabbleText
                                                              .subHeaderText(
                                                            text:
                                                                '-£${snapshot.data}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            fontSize: 9.sp,
                                                            fontFamily:
                                                                cPoppins,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: APPColors
                                                                .appBlue,
                                                          ),
                                                        ],
                                                      );
                                                    }),
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
                                                              FontWeight.w600,
                                                          fontSize: 13.sp,
                                                          color: APPColors
                                                              .appBlack,
                                                          fontFamily: cPoppins,
                                                        ),
                                                        RabbleText
                                                            .subHeaderText(
                                                          text: kvAT,
                                                          height: 1.5,
                                                          fontFamily: cPoppins,
                                                          color: APPColors
                                                              .appTextPrimary,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 8.sp,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    BehaviorSubjectBuilder<
                                                            double>(
                                                        subject:
                                                            bloc.totalDiscount,
                                                        initialData: 0.0,
                                                        builder: (context,
                                                            snapshot) {
                                                          return Row(
                                                            children: [
                                                              BehaviorSubjectBuilder<
                                                                      double>(
                                                                  subject: bloc
                                                                      .totalSumRRP,
                                                                  builder: (context,
                                                                      rrpSnap) {
                                                                    return RabbleText
                                                                        .subHeaderText(
                                                                      text: DateFormatUtil.amountFormatter(double.parse(rrpSnap
                                                                          .data
                                                                          .toString())),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontFamily:
                                                                          cPoppins,
                                                                      textDecoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                      color: APPColors
                                                                          .bg_grey27,
                                                                    );
                                                                  }),
                                                              SizedBox(
                                                                  width: 3.w),
                                                              RabbleText
                                                                  .subHeaderText(
                                                                text:
                                                                    '${DateFormatUtil.amountFormatter(double.parse(totalSumSnap.data.toString()))}',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 13.sp,
                                                                fontFamily:
                                                                    cPoppins,
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: APPColors.appPrimaryColor2,
                                            padding: PagePadding
                                                .customHorizontalVerticalSymmetric(
                                                    2.h, 1.3.h),
                                            child: Row(
                                              children: [
                                                Assets.svgs.save.svg(),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                                RabbleText.subHeaderText(
                                                  text: 'Saving',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10.sp,
                                                  color: APPColors.appBlack4,
                                                  fontFamily: cPoppins,
                                                ),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                                BehaviorSubjectBuilder<double>(
                                                    subject: bloc.totalDiscount,
                                                    initialData: 0.0,
                                                    builder:
                                                        (context, snapshot) {
                                                      return RabbleText
                                                          .subHeaderText(
                                                        text:
                                                            '£${snapshot.data}',
                                                        fontSize: 10.sp,
                                                        fontFamily: cPoppins,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textAlign:
                                                            TextAlign.start,
                                                        color:
                                                            APPColors.appGreen4,
                                                      );
                                                    }),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                                RabbleText.subHeaderText(
                                                  text: 'with Rabble',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10.sp,
                                                  color: APPColors.appBlack4,
                                                  fontFamily: cPoppins,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                  bottomNavigationBar: productList.data!.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                          color: APPColors.appBlack,
                          padding: PagePadding.custom(4.w, 4.w, 5.w, 5.w),
                          child: RabbleButton.tertiaryFilled(
                            buttonSize: ButtonSize.large,
                            bgColor: APPColors.appPrimaryColor,
                            onPressed: state.secondaryBusy
                                ? null
                                : () async {
                                    BuyingTeamCreationService()
                                        .addTeamCreationData(mProducerId,
                                            productList.data!.first.producerId);

                                    BuyingTeamCreationService().addPaymentData(
                                        mamount, bloc.totalSum.value);
                                    BuyingTeamCreationService()
                                        .addPaymentData(mcurrency, "GBP");

                                    BuyingTeamCreationService()
                                        .addTeamCreationData(
                                            mProducerName,
                                            productList
                                                .data!.first.producerName);

                                    if (bloc.isEmpty.value) {
                                      var tempData = await RabbleStorage
                                          .getinivitationData();

                                      if (tempData != null) {
                                        InvitationData invitationData =
                                            InvitationData.fromJson(
                                                json.decode(tempData));
                                        BuyingTeamCreationService()
                                            .addTeamCreationData(
                                                mName, invitationData.teamName);

                                        BuyingTeamCreationService()
                                            .groupNameSubject$
                                            .sink
                                            .add(invitationData.teamName!);

                                        BuyingTeamCreationService()
                                            .isAuthSubject$
                                            .add(true);

                                        BuyingTeamCreationService()
                                            .teamIdSubject$
                                            .sink
                                            .add(invitationData.teamId!);
                                      }

                                      NavigatorHelper().navigateTo(
                                          '/select_payment_method_view');
                                    } else {
                                      bloc.checkTeamExist(
                                          context,
                                          bloc.productList.value.first
                                              .producerName!,
                                          bloc.productList.value.first
                                              .producerId!);
                                    }
                                  },
                            child: state.secondaryBusy
                                ? const Center(
                                    child:
                                        RabbleSecondaryScreenProgressIndicator(
                                      enabled: true,
                                    ),
                                  )
                                : RabbleText.subHeaderText(
                                    text: bloc.isEmpty.value
                                        ? 'Proceed to Payment'
                                        : kProceedCreateTeam,
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
}
