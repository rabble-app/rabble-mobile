import 'package:rabble/config/export.dart';
import 'package:rabble/feature/producer/widget/producer_item_shimmer.dart';
import 'package:rabble/feature/producer/widget/producer_view_shimmer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class ProducerView extends StatelessWidget {
  const ProducerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)!.settings.arguments as Map;

    bool isEmpty = data['type'] ?? false;

    final String id = data['id'];

    Size size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2.1;

    return CubitProvider<RabbleBaseState, ProductTabCubit>(
        create: (BuildContext context) =>
            ProductTabCubit(id, data)..fetchAllProducts(),
        builder: (BuildContext context, RabbleBaseState state,
            ProductTabCubit bloc) {
          return ToucheDetector(
            child: state.primaryBusy
                ? const Center(child: ProducerViewShimmer())
                : BehaviorSubjectBuilder<ProducerDetail>(
                    subject: bloc.producerDataSubject$,
                    builder: (context, producerDetailSnapshot) {
                      ProducerDetail producerDetail =
                          producerDetailSnapshot.hasData
                              ? producerDetailSnapshot.data!
                              : ProducerDetail();

                      return Scaffold(
                        backgroundColor: APPColors.bgColor,
                        appBar: PreferredSize(
                            preferredSize: Size.fromHeight(8.h),
                            child: RabbleAppbar(
                              leadingWidth: 26.w,
                              title: producerDetail.businessName,
                              action: [
                                Padding(
                                  padding: PagePadding.onlyRight(1.w),
                                  child: CustomShareWidget(
                                    title: kShare,
                                    onTap: () async {
                                      var link = await bloc
                                          .generateDeepLink(producerDetail);
                                      Share.share(
                                        'Check out this producer on Rabble! ${producerDetail.businessName} $link',
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )),
                        body: BehaviorSubjectBuilder<int>(
                            subject: bloc.currentIndexSubject,
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              return SafeArea(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: APPColors.appYellow,
                                        height: 6.h,
                                        child: Center(
                                          child: RabbleText.subHeaderText(
                                            text:
                                                '$kChooseyourItemsfrom ${producerDetail.businessName}',
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: APPColors.appBlack,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: context.allHeight * 0.23,
                                        width: context.allWidth,
                                        child: RabbleImageLoader(
                                          imageUrl: producerDetail.imageUrl,
                                          fit: BoxFit.cover,
                                          isRound: false,
                                        ),
                                      ),
                                      Container(
                                        color: APPColors.appBlack,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Container(
                                              padding: PagePadding.custom(
                                                  0, 3.w, 3.w, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RabbleText.subHeaderText(
                                                    text: producerDetail
                                                        .businessName,
                                                    textAlign: TextAlign.start,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: cGosha,
                                                    color: APPColors.bg_grey26,
                                                    fontSize: 14.sp,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Assets.svgs.category.svg(
                                                          width: 4.w,
                                                          height: 2.5.h,
                                                          color: APPColors
                                                              .appPrimaryColor),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      RabbleText.subHeaderText(
                                                        text: producerDetail
                                                                        .categories !=
                                                                    null &&
                                                                producerDetail
                                                                    .categories!
                                                                    .isNotEmpty &&
                                                                producerDetail
                                                                        .categories!
                                                                        .first
                                                                        .category! !=
                                                                    null
                                                            ? producerDetail
                                                                .categories!
                                                                .first
                                                                .category!
                                                                .name
                                                            : '',
                                                        textAlign:
                                                            TextAlign.start,
                                                        fontFamily: cPoppins,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            APPColors.bg_grey25,
                                                        fontSize: 10.sp,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            BehaviorSubjectBuilder<int>(
                                                subject:
                                                    bloc.seeMoreClickedSubject$,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<int>
                                                        seeMoreSnapshot) {
                                                  return seeMoreSnapshot.data ==
                                                          0
                                                      ? Container(
                                                          padding: PagePadding
                                                              .custom(
                                                                  0, 3.w, 0, 0),
                                                          margin: PagePadding
                                                              .custom(
                                                                  4.w, 0, 0, 0),
                                                          child: RabbleText
                                                              .subHeaderText(
                                                            text: producerDetail
                                                                    .description ??
                                                                '',
                                                            textAlign:
                                                                TextAlign.start,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontFamily:
                                                                cPoppins,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            height: 1.5,
                                                            color: APPColors
                                                                .bg_grey25,
                                                            fontSize: 11.sp,
                                                          ),
                                                        )
                                                      : Container(
                                                          padding: PagePadding
                                                              .custom(
                                                                  0, 3.w, 0, 0),
                                                          margin: PagePadding
                                                              .custom(
                                                                  4.w, 0, 0, 0),
                                                          child: RabbleText
                                                              .subHeaderText(
                                                            text: producerDetail
                                                                    .description ??
                                                                '',
                                                            textAlign:
                                                                TextAlign.start,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontFamily:
                                                                cPoppins,
                                                            height: 1.5,
                                                            color: APPColors
                                                                .bg_grey25,
                                                            fontSize: 11.sp,
                                                          ),
                                                        );
                                                }),
                                            producerDetail.description !=
                                                        null &&
                                                    producerDetail.description
                                                            .toString()
                                                            .length >
                                                        80
                                                ? BehaviorSubjectBuilder<int>(
                                                    subject: bloc
                                                        .seeMoreClickedSubject$,
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<int>
                                                            seeMoreSnapshot) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          bloc.seeMoreClickedSubject$
                                                              .sink
                                                              .add(seeMoreSnapshot
                                                                          .data ==
                                                                      0
                                                                  ? 1
                                                                  : 0);
                                                        },
                                                        child: Container(
                                                          padding: PagePadding
                                                              .custom(
                                                                  0, 3.w, 0, 0),
                                                          child: RabbleText
                                                              .subHeaderText(
                                                            text: seeMoreSnapshot
                                                                        .data ==
                                                                    0
                                                                ? kSeeMore
                                                                : kSeeLess,
                                                            fontFamily: cGosha,
                                                            color: APPColors
                                                                .appPrimaryColor,
                                                            fontSize: 13.sp,
                                                          ),
                                                        ),
                                                      );
                                                    })
                                                : const SizedBox.shrink(),
                                            producerDetail.description != null
                                                ? SizedBox(
                                                    height: 3.h,
                                                  )
                                                : const SizedBox.shrink(),
                                            producerDetail.website != null
                                                ? Container(
                                                    padding: PagePadding.custom(
                                                        0, 3.w, 0, 0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Map data = {
                                                              'url': producerDetail
                                                                      .website ??
                                                                  '',
                                                              'title':
                                                                  producerDetail
                                                                          .businessName ??
                                                                      '',
                                                            };

                                                            NavigatorHelper()
                                                                .navigateToWebScreen(
                                                                    producerDetail
                                                                            .website ??
                                                                        '',
                                                                    producerDetail
                                                                            .businessName ??
                                                                        '');
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Assets.svgs.global
                                                                  .svg(
                                                                      width:
                                                                          4.w,
                                                                      height:
                                                                          2.5.h),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              RabbleText
                                                                  .subHeaderText(
                                                                text: producerDetail
                                                                        .website ??
                                                                    '',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                fontFamily:
                                                                    cPoppins,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: APPColors
                                                                    .appPrimaryColor,
                                                                fontSize: 10.sp,
                                                              ),
                                                              SizedBox(
                                                                width: 4.w,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        producerDetail.count !=
                                                                null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  Map data = {
                                                                    'id':
                                                                        producerDetail
                                                                            .id,
                                                                    'name': producerDetail
                                                                        .businessName
                                                                  };
                                                                  NavigatorHelper().navigateToScreen(
                                                                      '/all_buying_teams_view',
                                                                      arguments:
                                                                          data);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Assets.svgs.multi_profileuser.svg(
                                                                        color: APPColors
                                                                            .appPrimaryColor,
                                                                        width:
                                                                            4.w,
                                                                        height:
                                                                            2.5.h),
                                                                    SizedBox(
                                                                      width:
                                                                          1.5.w,
                                                                    ),
                                                                    RabbleText
                                                                        .subHeaderText(
                                                                      text: producerDetail.count !=
                                                                              null
                                                                          ? '${producerDetail.count!.buyingteams.toString()} ${producerDetail.count!.buyingteams==1? 'team':'teams'} '
                                                                          : '0',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      fontFamily:
                                                                          cPoppins,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: APPColors
                                                                          .appPrimaryColor,
                                                                      fontSize:
                                                                          10.sp,
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            BehaviorSubjectBuilder<
                                                    List<ProductData>>(
                                                subject:
                                                    bloc.productListSubject$,
                                                builder:
                                                    (context, productSnapshot) {
                                                  if (!productSnapshot.hasData)
                                                    return const Empty();
                                                  return productSnapshot
                                                          .data!.isNotEmpty
                                                      ? Container(
                                                          color: APPColors
                                                              .appBlack,
                                                          height: context
                                                                  .allHeight /
                                                              21.5,
                                                          child:
                                                              ListView.builder(
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount:
                                                                      productSnapshot
                                                                          .data!
                                                                          .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        bloc.currentIndexSubject
                                                                            .sink
                                                                            .add(index);
                                                                      },
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: PagePadding.custom(
                                                                                4.w,
                                                                                4.w,
                                                                                2.w,
                                                                                2.w),
                                                                            child:
                                                                                RabbleText.subHeaderText(
                                                                              text: productSnapshot.data![index].name,
                                                                              color: index == snapshot.data ? APPColors.bg_grey26 : APPColors.bg_grey25,
                                                                              fontFamily: cGosha,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: context.allWidth * 0.045,
                                                                            ),
                                                                          ),
                                                                          index == snapshot.data
                                                                              ? Container(
                                                                                  width: context.allWidth * 0.25 * productSnapshot.data![index].name!.length / 6,
                                                                                  color: APPColors.appPrimaryColor,
                                                                                  height: 0.3.h,
                                                                                )
                                                                              : const SizedBox.shrink()
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                        )
                                                      : SizedBox.shrink();
                                                }),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      state.secondaryBusy
                                          ? Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                                  Colors.grey.shade100,
                                              child: GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: 4,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        childAspectRatio:
                                                            9 / 10),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    height: 30,
                                                    margin: PagePadding.custom(
                                                        2.w, 2.w, 1.w, 2.w),
                                                    child: Container(
                                                      width: 50.w,
                                                      height:
                                                          context.allHeight *
                                                              0.22,
                                                      decoration:
                                                          ContainerDecoration
                                                              .boxDecoration(
                                                        bg: APPColors.appWhite,
                                                        border:
                                                            APPColors.appYellow,
                                                        radius: 12,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : BehaviorSubjectBuilder<
                                                  List<ProductData>>(
                                              subject: bloc.productListSubject$,
                                              builder:
                                                  (context, productSnapshot) {
                                                if (!productSnapshot.hasData)
                                                  return const Empty();

                                                return Column(
                                                  children: [
                                                    productSnapshot
                                                            .data!.isNotEmpty
                                                        ? Padding(
                                                            padding: PagePadding
                                                                .custom(0, 3.w,
                                                                    0, 3.w),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: RabbleText
                                                                  .subHeaderText(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                text: productSnapshot
                                                                    .data![snapshot
                                                                        .data!]
                                                                    .name,
                                                                color: APPColors
                                                                    .appBlack,
                                                                fontFamily:
                                                                    cGosha,
                                                                fontSize: context
                                                                        .allWidth *
                                                                    0.050,
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox.shrink(),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    productSnapshot
                                                            .data!.isNotEmpty
                                                        ? Container(
                                                            color: APPColors
                                                                .bgColor,
                                                            child: GridView
                                                                .builder(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  productSnapshot
                                                                      .data![snapshot
                                                                          .data!]
                                                                      .products!
                                                                      .length,
                                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      2,
                                                                  childAspectRatio:
                                                                      (itemWidth /
                                                                          itemHeight)),
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return ProductItemWidget(
                                                                  productSnapshot
                                                                      .data![snapshot
                                                                          .data!]
                                                                      .products![index],
                                                                  businessDetail:
                                                                      producerDetail,
                                                                  isHorizontal:
                                                                      false,
                                                                  voidCallBack:
                                                                      () {
                                                                    bloc.fetchAllProducts();
                                                                  },
                                                                  isEmpty: data,
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        : SizedBox.shrink()
                                                  ],
                                                );
                                              }),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        bottomNavigationBar: BehaviorSubjectBuilder<double>(
                            subject: bloc.totalSum,
                            builder: (BuildContext context,
                                AsyncSnapshot<double> isProductExistSnapShot) {
                              print(isProductExistSnapShot.data);
                              return GestureDetector(
                                onTap: () {
                                  if (isProductExistSnapShot.hasData &&
                                      isProductExistSnapShot.data! != null &&
                                      isProductExistSnapShot.data != 0.0) {
                                    NavigatorHelper()
                                        .navigateTo("/checkout", data)
                                        .then((value) {
                                      bloc.fetchAllProducts();

                                      if (isEmpty) {
                                        TeamData teamData = data['team'];
                                        bloc.fetchProductListForTeam(
                                            producerDetail.id!,
                                            teamData.id.toString());
                                      } else {
                                        bloc.fetchProductList(
                                            producerDetail.id!);
                                      }
                                    });
                                  }
                                },
                                child: isProductExistSnapShot.hasData &&
                                        isProductExistSnapShot.data != null &&
                                        isProductExistSnapShot.data != 0.0
                                    ? Container(
                                        margin: PagePadding.custom(
                                            3.w, 3.w, 3.w, 6.w),
                                        padding: PagePadding.custom(
                                            3.w, 3.w, 1.5.w, 1.5.w),
                                        decoration:
                                            ContainerDecoration.boxDecoration(
                                                bg: APPColors.appPrimaryColor,
                                                border:
                                                    APPColors.appPrimaryColor,
                                                radius: 8),
                                        child: BehaviorSubjectBuilder<int>(
                                            subject: bloc.totalQuantity,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<int> snapshot) {
                                              print(
                                                  "snapshot ${snapshot.data}");
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      NavigatorHelper().pop();
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      width: 7.w,
                                                      height: 5.h,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            APPColors.appBlack,
                                                        child: RabbleText
                                                            .subHeaderText(
                                                          text: snapshot.data!
                                                              .toString(),
                                                          fontSize: 9.sp,
                                                          fontFamily: cGosha,
                                                          color: APPColors
                                                              .appPrimaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  RabbleText.subHeaderText(
                                                    text: kViewYourBasket,
                                                    fontSize: 14.sp,
                                                    fontFamily: cGosha,
                                                    color: APPColors.appBlack,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 5.h,
                                                        child: RabbleText
                                                            .subHeaderText(
                                                          text: DateFormatUtil
                                                              .amountFormatter(
                                                                  double.parse(
                                                                      isProductExistSnapShot
                                                                          .data!
                                                                          .toString())),
                                                          fontSize: 13.sp,
                                                          fontFamily: cGosha,
                                                          color: APPColors
                                                              .appBlack,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )),
                                                ],
                                              );
                                            }),
                                      )
                                    : const SizedBox.shrink(),
                              );
                            }),
                      );
                    }),
          );
        });
  }
}
