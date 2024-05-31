import 'package:pay/pay.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/CardModel.dart';
import 'package:rabble/feature/card/card_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rabble/core/widgets/expansion.dart' as custom;

class AllCardView extends StatefulWidget {
  const AllCardView({Key? key}) : super(key: key);

  @override
  State<AllCardView> createState() => _AllCardViewState();
}

class _AllCardViewState extends State<AllCardView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, CardCubit>(
        create: (context) => CardCubit()..fetchMyCards(),
        builder: (context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bgColor,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(8.h),
                child: RabbleAppbar(
                  canGoBack: !state.secondaryBusy,
                  leadingWidth: 25.w,
                  title: kManageYourCard,
                )),
            body: state.primaryBusy
                ? ListView.builder(
                    itemCount: 10,
                    padding: PagePadding.all(2.w),
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.black,
                        enabled: true,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: context.allWidth,
                          margin: PagePadding.all(2.w),
                          decoration: ContainerDecoration.boxDecoration(
                              bg: Colors.transparent,
                              border: APPColors.bg_grey25,
                              width: 1,
                              radius: 8),
                          child: Padding(
                            padding: PagePadding.custom(2.w, 2.w, 5.w, 5.w),
                          ),
                        ),
                      );
                    })
                : Padding(
                    padding: PagePadding.all(4.w),
                    child: BehaviorSubjectBuilder<List<CardData>>(
                        subject: bloc.myCardListSubject$,
                        builder: (context, myCardDataSnap) {
                          if (!myCardDataSnap.hasData) {
                            return Center(
                              child: EmptyStateWidget(
                                  isBasket: true,
                                  heading: kGetControlCard,
                                  subHeading: kGetControlCard2,
                                  svg: Assets.svgs.basket_empty,
                                  btnHeading: '',
                                  callback: () {}),
                            );
                          }

                          if (myCardDataSnap.data!.isEmpty) {
                            return Center(
                              child: EmptyStateWidget(
                                  isBasket: true,
                                  heading: kGetControlCard,
                                  subHeading: kGetControlCard2,
                                  svg: Assets.svgs.basket_empty,
                                  btnHeading: kAddANewCard,
                                  callback: () {}),
                            );
                          }

                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: myCardDataSnap.data!.length == 1
                                  ? const NeverScrollableScrollPhysics()
                                  : const ClampingScrollPhysics(),
                              itemCount: myCardDataSnap.data!.length,
                              itemBuilder: (context, index) {
                                CardData cardDetail =
                                    myCardDataSnap.data![index];

                                return Container(
                                  padding: PagePadding.verticalSymmetric(1.w),
                                  margin: PagePadding.custom(0, 0, 2.w, 2.w),
                                  decoration: ContainerDecoration.boxDecoration(
                                      bg: APPColors.appWhite,
                                      border: APPColors.appWhite,
                                      radius: 8,
                                      width: 1,
                                      showShadow: true),
                                  child: BehaviorSubjectBuilder<bool>(
                                      subject: bloc.isExpandedSubject$,
                                      initialData: false,
                                      builder: (context, expandedSnapshot) {
                                        return BehaviorSubjectBuilder<String>(
                                            subject: bloc.primaryCardSubject$,
                                            builder:
                                                (context, primaryCardSnapshot) {
                                              return Theme(
                                                data: Theme.of(context)
                                                    .copyWith(
                                                        dividerColor:
                                                            Colors.transparent),
                                                child: custom.ExpansionTile(
                                                  backgroundColor:
                                                      APPColors.appWhite,
                                                  headerBackgroundColor:
                                                      Colors.white,
                                                  title: Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 4.2.h,
                                                            width: 8.h,
                                                            decoration: ContainerDecoration
                                                                .boxDecoration(
                                                                    bg: APPColors
                                                                        .bgColor,
                                                                    border: APPColors
                                                                        .bg_grey25,
                                                                    width: 1,
                                                                    radius: 8),
                                                            child: bloc
                                                                .getIconOfCard(
                                                                    cardDetail
                                                                        .card!
                                                                        .brand!)
                                                                .svg(
                                                                    width: 6.h,
                                                                    height:
                                                                        6.h,fit: BoxFit.scaleDown),
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          RabbleText
                                                              .subHeaderText(
                                                            text: kEnding,
                                                            textAlign:
                                                                TextAlign.start,
                                                            color: APPColors
                                                                .appBlack,
                                                            fontSize: 12.sp,
                                                            fontFamily:
                                                                cPoppins,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          SizedBox(
                                                            width: 1.w,
                                                          ),
                                                          RabbleText
                                                              .subHeaderText(
                                                            text: cardDetail
                                                                .card!.last4,
                                                            fontFamily:
                                                                cPoppins,
                                                            fontSize: 12.sp,
                                                            color: APPColors
                                                                .appTextPrimary,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          Spacer(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              if (cardDetail
                                                                  .isSelected!)
                                                                Container(
                                                                  width: 15.w,
                                                                  height: 3.h,
                                                                  decoration:
                                                                      ContainerDecoration
                                                                          .boxDecoration(
                                                                    bg: APPColors
                                                                        .appBlack,
                                                                    border: APPColors
                                                                        .appBlack,
                                                                    radius: 30,
                                                                  ),
                                                                  child: Center(
                                                                    child: RabbleText
                                                                        .subHeaderText(
                                                                      text:
                                                                          'Primary',
                                                                      color: APPColors
                                                                          .appPrimaryColor,
                                                                      fontFamily:
                                                                          cPoppins,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          7.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              !expandedSnapshot
                                                                      .data!
                                                                  ? const Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_outlined,
                                                                      color: APPColors
                                                                          .appBlue,
                                                                      size: 20,
                                                                    )
                                                                  : const Icon(
                                                                      Icons
                                                                          .keyboard_arrow_up_outlined,
                                                                      color: APPColors
                                                                          .appBlue,
                                                                      size: 20,
                                                                    )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 1.w,
                                                      ),
                                                      if (expandedSnapshot
                                                          .data!)
                                                        const Divider(
                                                          color: APPColors
                                                              .bg_grey25,
                                                          thickness: 0.7,
                                                        ),
                                                    ],
                                                  ),
                                                  iconColor:
                                                      APPColors.appPrimaryColor,
                                                  initiallyExpanded: false,
                                                  onExpansionChanged: (b) {
                                                    bloc.isExpandedSubject$.sink
                                                        .add(b);
                                                  },
                                                  children: [
                                                    Container(
                                                      margin:
                                                          PagePadding.custom(
                                                              1.w, 4.w, 0, 0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              RabbleText
                                                                  .subHeaderText(
                                                                text:
                                                                    'Set as primary payment method',
                                                                height: 1.3,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                color: APPColors
                                                                    .appBlack4,
                                                                fontSize: 11.sp,
                                                                fontFamily:
                                                                    cPoppins,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              SizedBox(
                                                                width: 1.w,
                                                              ),
                                                              RabbleText
                                                                  .subHeaderText(
                                                                text:
                                                                    'We will use this payment method for all your orders',
                                                                fontFamily:
                                                                    cPoppins,
                                                                fontSize:
                                                                    8.3.sp,
                                                                color: APPColors
                                                                    .bg_grey27,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ],
                                                          ),
                                                          Theme(
                                                            data: ThemeData(
                                                              unselectedWidgetColor:
                                                                  APPColors
                                                                      .appBorder,
                                                            ),
                                                            child:
                                                                Transform.scale(
                                                              scale: 1.2,
                                                              child: Checkbox(
                                                                value: cardDetail
                                                                    .isSelected,
                                                                onChanged: (bool?
                                                                    newValue) async {
                                                                  if (newValue!) {
                                                                    bloc.cardNumberSubject$
                                                                        .sink
                                                                        .add(cardDetail
                                                                            .card!
                                                                            .last4!);

                                                                    await bloc.markCardDefault(
                                                                        cardDetail
                                                                            .id!);

                                                                    bloc.onCardSelection(
                                                                        cardDetail,
                                                                        index);
                                                                  }
                                                                },
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4),
                                                                  side:
                                                                      const BorderSide(
                                                                    color: APPColors
                                                                        .bg_grey25,
                                                                  ),
                                                                ),

                                                                checkColor:
                                                                    APPColors
                                                                        .appPrimaryColor,
                                                                activeColor:
                                                                    APPColors
                                                                        .appBlack,
                                                                fillColor: MaterialStateProperty.all<
                                                                    Color>(cardDetail
                                                                        .isSelected!
                                                                    ? APPColors
                                                                        .appBlack
                                                                    : APPColors
                                                                        .bg_grey25),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    if (!cardDetail.isSelected!)
                                                      Container(
                                                        margin:
                                                            PagePadding.custom(
                                                                4.w, 4.w, 0, 0),
                                                        child: Column(
                                                          children: [
                                                            const Divider(
                                                              color: APPColors
                                                                  .bg_grey25,
                                                              thickness: 0.7,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                bloc.removeCard(
                                                                    cardDetail
                                                                        .id!);
                                                              },
                                                              child: RabbleText
                                                                  .subHeaderText(
                                                                text:
                                                                    'Remove Card',
                                                                fontSize: 12.sp,
                                                                height: 1.4,
                                                                fontFamily:
                                                                    cGosha,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: APPColors
                                                                    .appRedLight,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              );
                                            });
                                      }),
                                );
                              });
                        }),
                  ),
            bottomNavigationBar: Container(
              margin: PagePadding.custom(4.w, 4.w, 0, 8.w),
              height: 6.5.h,
              child: RabbleButton.tertiaryFilled(
                buttonSize: ButtonSize.large,
                bgColor: APPColors.appPrimaryColor,
                onPressed: state.secondaryBusy? null : () async {
                  NavigatorHelper()
                      .navigateTo('/add_payment_view')
                      .then((value) {
                    bloc.fetchMyCards();
                  });
                },
                child: state.secondaryBusy
                    ? const Center(
                        child: RabbleSecondaryScreenProgressIndicator(
                          enabled: true,
                        ),
                      )
                    : RabbleText.subHeaderText(
                        text: kAddANewCard,
                        fontSize: 14.sp,
                        fontFamily: 'Gosha',
                        color: APPColors.appBlack,
                        fontWeight: FontWeight.bold,
                      ),
              ),
            ),
          );
        });
  }
}
