import 'package:rabble/config/export.dart';
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
                  backgroundColor: APPColors.bg_app_primary,
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
                                  child: Column(
                                    children: [
                                      Container(
                                        color: APPColors.appYellow,
                                        height: 7.h,
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
                                        height: 2.h,
                                      ),
                                      Container(
                                        margin: PagePadding.horizontalSymmetric(
                                            4.w),
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
                                      child: Padding(
                                        padding: PagePadding.all(5.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            RabbleText.subHeaderText(
                                              text: kOrderSummary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp,
                                              fontFamily: cGosha,
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
                                                  fontSize: 11.sp,
                                                  fontFamily: cPoppins,
                                                  textAlign: TextAlign.start,
                                                  fontWeight: FontWeight.normal,
                                                  color:
                                                      APPColors.appTextPrimary,
                                                ),
                                                RabbleText.subHeaderText(
                                                  text:
                                                      '${DateFormatUtil.amountFormatter(double.parse(totalSumSnap.data.toString()))}',
                                                  fontSize: 11.sp,
                                                  fontFamily: cPoppins,
                                                  textAlign: TextAlign.start,
                                                  fontWeight: FontWeight.normal,
                                                  color:
                                                      APPColors.appTextPrimary,
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
                                                RabbleText.subHeaderText(
                                                  text: kDeliveryfee,
                                                  fontSize: 11.sp,
                                                  fontFamily: cPoppins,
                                                  textAlign: TextAlign.start,
                                                  fontWeight: FontWeight.normal,
                                                  color:
                                                      APPColors.appTextPrimary,
                                                ),
                                                RabbleText.subHeaderText(
                                                  text: '£0.00',
                                                  fontSize: 11.sp,
                                                  fontFamily: cPoppins,
                                                  textAlign: TextAlign.start,
                                                  fontWeight: FontWeight.normal,
                                                  color:
                                                      APPColors.appTextPrimary,
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
                                                    RabbleText.subHeaderText(
                                                      text: kTotalPriceWithVat,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp,
                                                    ),
                                                    RabbleText.subHeaderText(
                                                      text: kvAT,
                                                      height: 1.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 8.sp,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 5.w),
                                                RabbleText.subHeaderText(
                                                  text:
                                                      '${DateFormatUtil.amountFormatter(double.parse(totalSumSnap.data.toString()))}',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                  bottomNavigationBar: productList.data!.isEmpty
                      ? const SizedBox.shrink()
                      : bloc.state.secondaryBusy
                          ? Container(
                              width: 20.w,
                              height: 15.h,
                              padding: PagePadding.horizontalSymmetric(5.w),
                              child: const Center(
                                child: RabbleSecondaryScreenProgressIndicator(
                                  enabled: true,
                                ),
                              ),
                            )
                          : Container(
                              color: APPColors.appBlack,
                              padding: PagePadding.custom(4.w, 4.w, 5.w, 5.w),
                              child: RabbleButton.tertiaryFilled(
                                buttonSize: ButtonSize.large,
                                bgColor: APPColors.appPrimaryColor,
                                onPressed: () async {
                                  BuyingTeamCreationService()
                                      .addTeamCreationData(mProducerId,
                                          productList.data!.first.producerId);

                                  BuyingTeamCreationService().addPaymentData(
                                      mamount, bloc.totalSum.value);
                                  BuyingTeamCreationService()
                                      .addPaymentData(mcurrency, "GBP");

                                  BuyingTeamCreationService()
                                      .addTeamCreationData(mProducerName,
                                          productList.data!.first.producerName);

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
                                child: RabbleText.subHeaderText(
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
