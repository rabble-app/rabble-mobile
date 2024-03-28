import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/MoreProductModel.dart';
import 'package:rabble/feature/auth/login/login_modal_view.dart';
import 'package:rabble/feature/product/portioned_product_list_widget.dart';
import 'package:rabble/feature/product/portioned_product_widget.dart';
import 'package:rabble/feature/product/widget/single_product_item_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../producer/widget/producer_view_shimmer.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2.1;
    var data = ModalRoute.of(context)!.settings.arguments as Map;

    String productId = data['productId'] ?? '';
    String producerId = data['producerId'] ?? '';

    return CubitProvider<RabbleBaseState, ProductDetailCubit>(
        create: (context) => ProductDetailCubit()
          ..fetchProductDetail(productId, producerId)
          ..fetchUserData(),
        builder: (context, state, bloc) {
          return state.primaryBusy
              ? const Center(child: ProducerViewShimmer())
              : BehaviorSubjectBuilder<ProductDetail>(
                  subject: bloc.productDetailSubject$,
                  builder: (context, productDetailSnapShot) {
                    if (!productDetailSnapShot.hasData) {
                      return const Center(child: ProducerViewShimmer());
                    }
                    ProductDetail productDetail = productDetailSnapShot.data!;
                    return Scaffold(
                      backgroundColor:
                          productDetail.type == 'PORTIONED_SINGLE_PRODUCT'
                              ? APPColors.bgColor
                              : Colors.transparent,
                      appBar: PreferredSize(
                          preferredSize: Size.fromHeight(8.h),
                          child: RabbleAppbar(
                            leadingWidth: 10.w,
                            centerTitle: false,
                            titleWidget:RabbleText.subHeaderText(
                              text: kProductDetail,
                              overflow: TextOverflow.ellipsis,
                              color: APPColors.appPrimaryColor,
                              fontWeight: FontWeight.w600,
                              wordSpacing: 2,
                              letterSpacing: 0.5,
                              fontFamily: cPoppins,
                              fontSize: 12.sp,
                            ),
                            leading: InkWell(
                              onTap: () {
                                if(NavigatorHelper().canPop()) {
                                  NavigatorHelper().pop();
                                }else{
                                  NavigatorHelper().navigateTo('/home');
                                }
                              },
                              child: Container(
                                height: 5.h,
                                padding: PagePadding.onlyLeft(1.w),
                                child: CircleAvatar(
                                  backgroundColor: APPColors.appPrimaryColor,
                                  child: const Icon(
                                    Icons.close,
                                    color: APPColors.appBlack4,
                                  ),
                                ),
                              ),
                            ),
                            title: kProductDetail,
                            action: [
                              Padding(
                                padding: PagePadding.onlyRight(1.w),
                                child: CustomShareWidget(
                                  title: kShare,
                                  onTap: () async {
                                    var link = await bloc.generateDeepLink(
                                        productDetailSnapShot.data!);
                                    Share.share(
                                      'Check out this Product on Rabble! ${productDetailSnapShot.data!.name} $link',
                                    );
                                  },
                                ),
                              ),
                            ],
                          )),
                      body: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: BehaviorSubjectBuilder<bool>(
                                  subject: bloc.expandedTeamInfoSubject$,
                                  initialData: false,
                                  builder: (context, expandedTeamInfoSnapshot) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          color: APPColors.appYellow,
                                          height: 4.h,
                                          child: Center(
                                            child: RabbleText.subHeaderText(
                                              text: kChooseyouritems,
                                              fontSize: 12.sp,
                                              fontFamily: cGosha,
                                              fontWeight: FontWeight.bold,
                                              color: APPColors.appBlack,
                                            ),
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            InstaImageViewer(
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.5,
                                                  child: productDetail.thresholdQuantity! -
                                                                  productDetailSnapShot
                                                                      .data!
                                                                      .qty! <=
                                                              0 &&
                                                          productDetail.type ==
                                                              'PORTIONED_SINGLE_PRODUCT'
                                                      ? ColorFiltered(
                                                          colorFilter:
                                                              const ColorFilter
                                                                  .mode(
                                                            Colors.grey,
                                                            // Grayscale filter color
                                                            BlendMode
                                                                .saturation,
                                                          ),
                                                          child: Image.network(
                                                            productDetail
                                                                    .imageUrl ??
                                                                '',
                                                            fit: BoxFit.cover,
                                                            color: Colors.black,
                                                            // Adjust the opacity here (0.5 in this example)
                                                            colorBlendMode:
                                                                BlendMode
                                                                    .softLight,
                                                          ),
                                                        )
                                                      : RabbleImageLoader(
                                                          imageUrl: productDetail
                                                                  .imageUrl ??
                                                              '',
                                                          fit: BoxFit.cover,
                                                          isRound: false)),
                                            ),
                                            if (productDetail.type ==
                                                    'PORTIONED_SINGLE_PRODUCT' &&
                                                productDetail
                                                            .thresholdQuantity! -
                                                        productDetailSnapShot
                                                            .data!.qty! <=
                                                    0)
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                left: 0,
                                                child: Center(
                                                  child:
                                                      RabbleText.subHeaderText(
                                                    text:
                                                        'You got the last\n${productDetail.orderSubUnit!.toLowerCase()}!',
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 33.sp,
                                                    fontFamily: cGosha,
                                                    color: APPColors
                                                        .appPrimaryColor,
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                        const Divider(
                                          color: APPColors.bg_grey26,
                                          thickness: 0.5,
                                          height: 1,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        productDetail.type ==
                                                    'PORTIONED_SINGLE_PRODUCT' &&
                                                productDetailSnapShot.data !=
                                                    null &&
                                                productDetailSnapShot
                                                        .data!.qty ==
                                                    0
                                            ? Container(
                                                padding: PagePadding.custom(
                                                    1.w, 1.w, 0, 2.w),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      padding: PagePadding
                                                          .horizontalSymmetric(
                                                              2.w),
                                                      child: Center(
                                                        child: RabbleText
                                                            .subHeaderText(
                                                          text:
                                                              '${productDetail.totalThresholdQuantity} ${productDetail.orderSubUnit} ${productDetail.orderUnit}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16.sp,
                                                          fontFamily: cGosha,
                                                          color: APPColors
                                                              .appBlack4,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: context.allWidth *
                                                          0.06,
                                                      width: context.allWidth *
                                                          0.13,
                                                      margin:
                                                          PagePadding.onlyTop(
                                                              1.w),
                                                      decoration: ContainerDecoration
                                                          .boxDecoration(
                                                              border: APPColors
                                                                  .appGreen5,
                                                              bg: APPColors
                                                                  .appGreen5,
                                                              width: 1,
                                                              radius: 28),
                                                      child: Center(
                                                        child: RabbleText
                                                            .subHeaderText(
                                                          text: productDetailSnapShot
                                                                      .data!
                                                                      .qty !=
                                                                  null
                                                              ? productDetail.thresholdQuantity! -
                                                                          productDetailSnapShot
                                                                              .data!
                                                                              .qty!
                                                                              .toInt() <
                                                                      0
                                                                  ? '0 left'
                                                                  : '${productDetail.thresholdQuantity! - productDetailSnapShot.data!.qty!} left'
                                                              : productDetail
                                                                          .thresholdQuantity! <
                                                                      0
                                                                  ? '0 left'
                                                                  : '${productDetail.thresholdQuantity!} left',
                                                          textAlign:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 7.sp,
                                                          fontFamily: cPoppins,
                                                          color: APPColors
                                                              .appGreen4,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        bloc.expandedTeamInfoSubject$
                                                            .sink
                                                            .add(
                                                                !expandedTeamInfoSnapshot
                                                                    .data!);
                                                      },
                                                      child: Container(
                                                        padding: PagePadding
                                                            .onlyRight(1.w),
                                                        child: Icon(
                                                          !expandedTeamInfoSnapshot
                                                                  .data!
                                                              ? Icons
                                                                  .keyboard_arrow_down_outlined
                                                              : Icons
                                                                  .keyboard_arrow_up_outlined,
                                                          color:
                                                              APPColors.appBlue,
                                                          size: 25,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : productDetail
                                                            .type ==
                                                        'PORTIONED_SINGLE_PRODUCT' &&
                                                    productDetailSnapShot
                                                            .data !=
                                                        null &&
                                                    productDetailSnapShot
                                                            .data!.qty !=
                                                        0 &&
                                                    productDetail
                                                            .thresholdQuantity !=
                                                        0
                                                ? Container(
                                                    padding: PagePadding.custom(
                                                        1.w, 1.w, 0, 2.w),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          padding: PagePadding
                                                              .horizontalSymmetric(
                                                                  2.w),
                                                          child: Center(
                                                            child: RabbleText
                                                                .subHeaderText(
                                                              text:
                                                                  '${productDetail.totalThresholdQuantity} ${productDetail.orderSubUnit} ${productDetail.orderUnit}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 16.sp,
                                                              fontFamily:
                                                                  cGosha,
                                                              color: APPColors
                                                                  .appBlack4,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height:
                                                              context.allWidth *
                                                                  0.06,
                                                          width:
                                                              context.allWidth *
                                                                  0.13,
                                                          margin: PagePadding
                                                              .onlyTop(1.w),
                                                          decoration: ContainerDecoration
                                                              .boxDecoration(
                                                                  border: APPColors
                                                                      .appGreen5,
                                                                  bg: APPColors
                                                                      .appGreen5,
                                                                  width: 1,
                                                                  radius: 28),
                                                          child: Center(
                                                            child: RabbleText
                                                                .subHeaderText(
                                                              text: productDetailSnapShot
                                                                          .data!
                                                                          .qty !=
                                                                      null
                                                                  ? productDetail.thresholdQuantity! -
                                                                              productDetailSnapShot
                                                                                  .data!.qty! <
                                                                          0
                                                                      ? '0 left'
                                                                      : '${productDetail.thresholdQuantity! - productDetailSnapShot.data!.qty!} left'
                                                                  : productDetail
                                                                              .thresholdQuantity! <
                                                                          0
                                                                      ? '0 left'
                                                                      : '${productDetail.thresholdQuantity!} left',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 7.sp,
                                                              fontFamily:
                                                                  cPoppins,
                                                              color: APPColors
                                                                  .appGreen4,
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            bloc.expandedTeamInfoSubject$
                                                                .sink
                                                                .add(
                                                                    !expandedTeamInfoSnapshot
                                                                        .data!);
                                                          },
                                                          child: Container(
                                                            padding: PagePadding
                                                                .onlyRight(1.w),
                                                            child: Icon(
                                                              !expandedTeamInfoSnapshot
                                                                      .data!
                                                                  ? Icons
                                                                      .keyboard_arrow_down_outlined
                                                                  : Icons
                                                                      .keyboard_arrow_up_outlined,
                                                              color: APPColors
                                                                  .appBlue,
                                                              size: 25,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                        if (productDetail.type ==
                                                'PORTIONED_SINGLE_PRODUCT' &&
                                            expandedTeamInfoSnapshot.data!)
                                          BehaviorSubjectBuilder<
                                                  List<TempBoxData>>(
                                              subject: bloc
                                                  .purchasedUserListSubject$,
                                              builder: (context,
                                                  purchaseUserSnapshot) {
                                                return Container(
                                                  margin: PagePadding
                                                      .horizontalSymmetric(3.w),
                                                  child:
                                                      PortionedProductTeamListWidget(
                                                    partionedProductsList:
                                                        productDetail
                                                                    .partionedProducts !=
                                                                null
                                                            ? productDetail
                                                                .partionedProducts!
                                                            : [],
                                                    purchaseUser:
                                                        purchaseUserSnapshot
                                                                .hasData
                                                            ? purchaseUserSnapshot
                                                                .data!
                                                            : [],
                                                    totalItems: productDetail
                                                        .totalThresholdQuantity!,
                                                  ),
                                                );
                                              }),
                                        if (productDetail.type ==
                                            'PORTIONED_SINGLE_PRODUCT')
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                        Container(
                                          color: APPColors.appWhite,
                                          padding: PagePadding.custom(
                                              1.w, 1.w, 4.w, 1.w),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (productDetailSnapShot.hasData)
                                                if (productDetail.type ==
                                                    'PORTIONED_SINGLE_PRODUCT')
                                                  Container(
                                                    height:
                                                        context.allWidth * 0.16,
                                                    padding: PagePadding
                                                        .horizontalSymmetric(
                                                            1.w),
                                                    margin: PagePadding
                                                        .horizontalSymmetric(
                                                            2.w),
                                                    decoration: ContainerDecoration
                                                        .boxDecoration(
                                                            border: APPColors
                                                                .appBlue,
                                                            bg: APPColors
                                                                .bg_grey34,
                                                            width: 1,
                                                            radius: 8,
                                                            showShadow: true),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        const Icon(
                                                          Icons.info,
                                                          color:
                                                              APPColors.appBlue,
                                                          size: 26,
                                                        ),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              context.allWidth *
                                                                  0.75,
                                                          child: RabbleText
                                                              .subHeaderText(
                                                            text:
                                                                'This is a ${productDetail.totalThresholdQuantity} ${productDetail.orderSubUnit!.toLowerCase()} ${productDetail.orderUnit!.toLowerCase()}. The ${productDetail.orderUnit!.toLowerCase()} is ordered once all ${productDetail.orderSubUnit!.toLowerCase()} are sold to the team',
                                                            textAlign:
                                                                TextAlign.start,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 10.sp,
                                                            fontFamily:
                                                                cPoppins,
                                                            color: APPColors
                                                                .appBlue,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                              if (productDetail.type ==
                                                  'PORTIONED_SINGLE_PRODUCT')
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        context.allWidth * 0.55,
                                                    padding: PagePadding.custom(
                                                        3.w, 3.w, 1.w, 1.w),
                                                    child: RabbleText
                                                        .subHeaderText(
                                                      text:
                                                          productDetailSnapShot
                                                                  .data!.name ??
                                                              '',
                                                      fontSize: 13.sp,
                                                      fontFamily: cPoppins,
                                                      textAlign:
                                                          TextAlign.start,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          APPColors.appBlack4,
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            PagePadding.onlyTop(
                                                          1.w,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            RabbleText
                                                                .subHeaderText(
                                                              text: 'RRP: ',
                                                              fontSize: 11.sp,
                                                              fontFamily:
                                                                  cPoppins,
                                                              maxLines: 2,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: APPColors
                                                                  .bg_grey27,
                                                            ),
                                                            RabbleText
                                                                .subHeaderText(
                                                              text: productDetail
                                                                          .rrp !=
                                                                      null
                                                                  ? '£${productDetail.rrp}'
                                                                  : '',
                                                              fontSize: 11.sp,
                                                              textDecoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontFamily:
                                                                  cPoppins,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: APPColors
                                                                  .bg_grey27,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            PagePadding.custom(
                                                                3.w, 3.w, 0, 0),
                                                        child: RabbleText
                                                            .subHeaderText(
                                                          text: productDetail
                                                                      .price !=
                                                                  null
                                                              ? '£${productDetail.price}'
                                                              : '',
                                                          fontSize: 17.sp,
                                                          fontFamily: cGosha,
                                                          color: APPColors
                                                              .appBlack4,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  )

                                                  // productDetail.type ==
                                                  //         'PORTIONED_SINGLE_PRODUCT'
                                                  //     ? Container(
                                                  //         padding: PagePadding.custom(
                                                  //             3.w, 3.w, 1.w, 0),
                                                  //         child: Row(
                                                  //           crossAxisAlignment:
                                                  //               CrossAxisAlignment
                                                  //                   .end,
                                                  //           children: [
                                                  //             RabbleText
                                                  //                 .subHeaderText(
                                                  //               text: productDetail
                                                  //                           .price !=
                                                  //                       null
                                                  //                   ? '£${productDetail.price}/'
                                                  //                   : '',
                                                  //               fontSize: 17.sp,
                                                  //               fontFamily: cGosha,
                                                  //               color: APPColors
                                                  //                   .appBlack4,
                                                  //               fontWeight:
                                                  //                   FontWeight.bold,
                                                  //             ),
                                                  //             RabbleText
                                                  //                 .subHeaderText(
                                                  //               text:
                                                  //                   '${productDetail.orderSubUnit}',
                                                  //               fontSize: 10.sp,
                                                  //               height: 1,
                                                  //               fontFamily: cPoppins,
                                                  //               color: APPColors
                                                  //                   .appBlack4,
                                                  //               fontWeight:
                                                  //                   FontWeight.w500,
                                                  //             )
                                                  //           ],
                                                  //         ),
                                                  //       )
                                                  //     : Padding(
                                                  //         padding: PagePadding.custom(
                                                  //             3.w, 3.w, 1.w, 0),
                                                  //         child: RabbleText
                                                  //             .subHeaderText(
                                                  //           text:
                                                  //               '${DateFormatUtil.amountFormatter(double.parse(productDetail.price.toString()))}',
                                                  //           textAlign:
                                                  //               TextAlign.start,
                                                  //           fontSize: 18.sp,
                                                  //           fontFamily: cGosha,
                                                  //           letterSpacing: 0.7,
                                                  //           wordSpacing: 1.5,
                                                  //           color: APPColors
                                                  //               .appTextPrimary,
                                                  //         ),
                                                  //       )
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    PagePadding.onlyTop(0.5.w),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          PagePadding.custom(
                                                              1.w,
                                                              3.w,
                                                              1.w,
                                                              1.w),
                                                      child: RabbleText
                                                          .subHeaderText(
                                                        text:
                                                            '${productDetail.unitsPerOrder} ${productDetail.unitsOfMeasure!.toLowerCase()} ${productDetail.orderSubUnit!.toLowerCase()}',
                                                        textAlign:
                                                            TextAlign.start,
                                                        fontSize: 11.sp,
                                                        fontFamily: cPoppins,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0.7,
                                                        wordSpacing: 1.5,
                                                        color:
                                                            APPColors.bg_grey27,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      padding: PagePadding
                                                          .customHorizontalVerticalSymmetric(
                                                              1.h, 0.4.h),
                                                      decoration: ContainerDecoration
                                                          .boxDecoration(
                                                              bg: APPColors
                                                                  .appBlack4,
                                                              border: APPColors
                                                                  .appBlack4,
                                                              width: 1,
                                                              radius: 28),
                                                      child: Center(
                                                        child: RabbleText
                                                            .subHeaderText(
                                                          text:
                                                              'You Save ${bloc.calculateSaving(productDetail.price, productDetail.rrp)}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 7.sp,
                                                          fontFamily: cPoppins,
                                                          color: APPColors
                                                              .appPrimaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: PagePadding.custom(
                                                    1.w, 3.w, 2.w, 3.w),
                                                child: RabbleText.subHeaderText(
                                                  text:
                                                      '${productDetail.description}',
                                                  textAlign: TextAlign.start,
                                                  fontSize: 11.sp,
                                                  fontFamily: cPoppins,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      APPColors.appTextPrimary,
                                                ),
                                              ),
                                              Container(
                                                padding: PagePadding.custom(
                                                    3.w, 3.w, 2.w, 5.w),
                                                child: productDetailSnapShot
                                                                .data!.qty !=
                                                            null &&
                                                        productDetailSnapShot
                                                                .data!.qty !=
                                                            0
                                                    ? Container(
                                                        padding:
                                                            PagePadding.custom(
                                                                3.w,
                                                                3.w,
                                                                1.5.w,
                                                                1.5.w),
                                                        decoration: ContainerDecoration
                                                            .boxDecoration(
                                                                bg: APPColors
                                                                    .appPrimaryColor,
                                                                border: APPColors
                                                                    .appPrimaryColor,
                                                                radius: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                String status =
                                                                    await RabbleStorage
                                                                            .getLoginStatus() ??
                                                                        "0";
                                                                if (status !=
                                                                    '0') {
                                                                  String
                                                                      postalCode =
                                                                      await RabbleStorage
                                                                          .getPostalCode();

                                                                  if (postalCode
                                                                      .isEmpty) {
                                                                    NavigatorHelper()
                                                                        .navigateTo(
                                                                            '/add_postal_code_view');
                                                                  } else {
                                                                    if (productDetail
                                                                            .type ==
                                                                        'PORTIONED_SINGLE_PRODUCT') {
                                                                      List<
                                                                          TempBoxData> tempList = bloc
                                                                              .purchasedUserListSubject$
                                                                              .hasValue
                                                                          ? bloc
                                                                              .purchasedUserListSubject$
                                                                              .value
                                                                          : [];

                                                                      if (tempList
                                                                          .isNotEmpty) {
                                                                        tempList
                                                                            .removeLast();
                                                                      }
                                                                      bloc.purchasedUserListSubject$
                                                                          .sink
                                                                          .add(
                                                                              tempList);
                                                                      if (productDetailSnapShot.data !=
                                                                              null &&
                                                                          productDetailSnapShot.data!.qty! >
                                                                              1) {
                                                                        bloc.productQuantity(
                                                                            productDetailSnapShot.data!.qty! -
                                                                                1,
                                                                            productDetailSnapShot.data!.id!,
                                                                            productDetailSnapShot.data!.producer!.id!);
                                                                      } else {
                                                                        await bloc
                                                                            .removeProduct(productDetail.id!);
                                                                        bloc.fetchAllProducts(productDetailSnapShot
                                                                            .data!
                                                                            .producer!
                                                                            .id!);
                                                                      }
                                                                    } else {
                                                                      if (productDetailSnapShot.data !=
                                                                              null &&
                                                                          productDetailSnapShot.data!.qty! >
                                                                              1) {
                                                                        bloc.productQuantity(
                                                                            productDetailSnapShot.data!.qty! -
                                                                                1,
                                                                            productDetailSnapShot.data!.id!,
                                                                            productDetailSnapShot.data!.producer!.id!);
                                                                      } else {
                                                                        await bloc
                                                                            .removeProduct(productDetail.id!);
                                                                        bloc.fetchAllProducts(productDetailSnapShot
                                                                            .data!
                                                                            .producer!
                                                                            .id!);
                                                                      }
                                                                    }
                                                                  }
                                                                } else {
                                                                  openLoginSheet();
                                                                }
                                                              },
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                width: 7.w,
                                                                height: 5.h,
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      APPColors
                                                                          .appBlack,
                                                                  child: productDetailSnapShot.data!.id != null &&
                                                                          productDetailSnapShot.data!.qty !=
                                                                              null &&
                                                                          productDetailSnapShot.data!.qty! >
                                                                              1
                                                                      ? Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              APPColors.appPrimaryColor,
                                                                        )
                                                                      : Assets
                                                                          .svgs
                                                                          .trash
                                                                          .svg(
                                                                              width: 4.w,
                                                                              height: 2.5.h),
                                                                ),
                                                              ),
                                                            ),
                                                            RabbleText
                                                                .subHeaderText(
                                                              text: productDetailSnapShot
                                                                  .data!.qty
                                                                  .toString(),
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  cGosha,
                                                              color: APPColors
                                                                  .appBlack,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                String
                                                                    postalCode =
                                                                    await RabbleStorage
                                                                        .getPostalCode();

                                                                if (postalCode
                                                                    .isEmpty) {
                                                                  NavigatorHelper()
                                                                      .navigateTo(
                                                                          '/add_postal_code_view');
                                                                } else {
                                                                  if (productDetail
                                                                          .type ==
                                                                      'PORTIONED_SINGLE_PRODUCT') {
                                                                    List<
                                                                        TempBoxData> tempList = bloc
                                                                            .purchasedUserListSubject$
                                                                            .hasValue
                                                                        ? bloc
                                                                            .purchasedUserListSubject$
                                                                            .value
                                                                        : [];

                                                                    if (productDetailSnapShot.data!.qty! +
                                                                            1 <=
                                                                        productDetail
                                                                            .thresholdQuantity!) {
                                                                      tempList.add(
                                                                          TempBoxData(
                                                                              '${bloc.userDataSubject$.value.firstName} ${bloc.userDataSubject$.value.lastName}'));
                                                                      bloc.purchasedUserListSubject$
                                                                          .sink
                                                                          .add(
                                                                              tempList);
                                                                    }
                                                                    if (productDetailSnapShot.data!.qty! +
                                                                            1 <=
                                                                        productDetail
                                                                            .thresholdQuantity!) {
                                                                      bloc.productQuantity(
                                                                          productDetailSnapShot.data!.qty! +
                                                                              1,
                                                                          productDetail
                                                                              .id,
                                                                          productDetailSnapShot
                                                                              .data!
                                                                              .producer!
                                                                              .id!);
                                                                    }
                                                                  } else {
                                                                    bloc.productQuantity(
                                                                        productDetailSnapShot.data!.qty! +
                                                                            1,
                                                                        productDetail
                                                                            .id,
                                                                        productDetailSnapShot
                                                                            .data!
                                                                            .producer!
                                                                            .id!);
                                                                  }
                                                                }
                                                              },
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                width: 7.w,
                                                                height: 5.h,
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      APPColors
                                                                          .appBlack,
                                                                  child: Icon(
                                                                    Icons
                                                                        .add_outlined,
                                                                    color: APPColors
                                                                        .appPrimaryColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : RabbleButton
                                                        .tertiaryFilled(
                                                        buttonSize:
                                                            ButtonSize.large,
                                                        bgColor: APPColors
                                                            .appPrimaryColor,
                                                        onPressed: () async {
                                                          String status =
                                                              await RabbleStorage
                                                                      .getLoginStatus() ??
                                                                  "0";

                                                          if (status != '0') {
                                                            String postalCode =
                                                                await RabbleStorage
                                                                    .getPostalCode();

                                                            if (postalCode
                                                                .isEmpty) {
                                                              NavigatorHelper()
                                                                  .navigateTo(
                                                                      '/add_postal_code_view');
                                                            } else {
                                                              if (productDetailSnapShot
                                                                      .hasData &&
                                                                  productDetailSnapShot
                                                                          .data!
                                                                          .qty !=
                                                                      null &&
                                                                  productDetailSnapShot
                                                                          .data!
                                                                          .qty !=
                                                                      0) {
                                                                NavigatorHelper()
                                                                    .navigateTo(
                                                                        "/checkout",
                                                                        data)
                                                                    .then(
                                                                        (value) {
                                                                  bloc.fetchSingleProductExist(
                                                                      productDetail
                                                                          .id!);
                                                                });
                                                              } else {
                                                                productDetail
                                                                    .producerName = productDetailSnapShot
                                                                        .data!
                                                                        .producer!
                                                                        .businessName ??
                                                                    '';
                                                                bloc.addProductInCart(
                                                                    context,
                                                                    productDetail);
                                                              }
                                                            }
                                                          } else {
                                                            openLoginSheet();
                                                          }
                                                        },
                                                        child: RabbleText
                                                            .subHeaderText(
                                                          text: kAddToBasket,
                                                          fontSize: 14.sp,
                                                          fontFamily: cGosha,
                                                          color: APPColors
                                                              .appBlack,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BehaviorSubjectBuilder<
                                                List<ProductDetail>>(
                                            subject:
                                                bloc.moreProductListSubject$,
                                            builder:
                                                (context, productSnapshot) {
                                              return state.tertiaryBusy
                                                  ? Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey.shade300,
                                                      highlightColor:
                                                          Colors.grey.shade100,
                                                      child: GridView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: 4,
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,
                                                                childAspectRatio:
                                                                    9 / 10),
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Container(
                                                            height: 30,
                                                            margin: PagePadding
                                                                .custom(
                                                                    2.w,
                                                                    2.w,
                                                                    1.w,
                                                                    2.w),
                                                            child: Container(
                                                              width: 50.w,
                                                              height: context
                                                                      .allHeight *
                                                                  0.22,
                                                              decoration:
                                                                  ContainerDecoration
                                                                      .boxDecoration(
                                                                bg: APPColors
                                                                    .appWhite,
                                                                border: APPColors
                                                                    .appYellow,
                                                                radius: 12,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  : productSnapshot
                                                          .data!.isNotEmpty
                                                      ? Container(
                                                          margin: PagePadding
                                                              .horizontalSymmetric(
                                                                  1.w),
                                                          color:
                                                              APPColors.bgColor,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 3.h,
                                                              ),
                                                              Container(
                                                                width: context
                                                                        .allWidth *
                                                                    0.7,
                                                                padding:
                                                                    PagePadding
                                                                        .custom(
                                                                            3.w,
                                                                            3.w,
                                                                            0,
                                                                            0),
                                                                child: RabbleText
                                                                    .subHeaderText(
                                                                  text:
                                                                      'Members also bought',
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontFamily:
                                                                      cGosha,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: APPColors
                                                                      .appTextPrimary,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2.h,
                                                              ),
                                                              GridView.builder(
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                shrinkWrap:
                                                                    true,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                itemCount:
                                                                    productSnapshot
                                                                        .data!
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
                                                                  return productSnapshot
                                                                              .data![index]
                                                                              .type ==
                                                                          'PORTIONED_SINGLE_PRODUCT'
                                                                      ? SharedProductItemWidget(
                                                                          productSnapshot
                                                                              .data![index],
                                                                          businessDetail: productDetailSnapShot
                                                                              .data!
                                                                              .producer!,
                                                                          isEmpty:
                                                                              data,
                                                                          isHorizontal:
                                                                              false,
                                                                          isSamePage:
                                                                              true,
                                                                          samePageCallBack:
                                                                              () {
                                                                            setState(() {
                                                                              productDetail = productSnapshot.data![index];
                                                                            });
                                                                          },
                                                                          voidCallBack:
                                                                              () {
                                                                            bloc.fetchAllProducts(productDetailSnapShot.data!.producer!.id!);
                                                                          },
                                                                        )
                                                                      : SingleProductItemWidget(
                                                                          productSnapshot
                                                                              .data![index],
                                                                          businessDetail: productDetailSnapShot
                                                                              .data!
                                                                              .producer!,
                                                                          isEmpty:
                                                                              data,
                                                                          isHorizontal:
                                                                              false,
                                                                          isSamePage:
                                                                              true,
                                                                          samePageCallBack:
                                                                              () {
                                                                            setState(() {
                                                                              productDetail = productSnapshot.data![index];
                                                                            });
                                                                          },
                                                                          voidCallBack:
                                                                              () {
                                                                            bloc.fetchAllProducts(productDetailSnapShot.data!.producer!.id!);
                                                                          },
                                                                        );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox.shrink();
                                            })
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                      bottomNavigationBar: BehaviorSubjectBuilder<double>(
                          subject: bloc.totalSum,
                          initialData: 0.0,
                          builder: (BuildContext context,
                              AsyncSnapshot<double> totalAmountSnapShot) {
                            return GestureDetector(
                              onTap: () {
                                if (totalAmountSnapShot.data != 0.0) {
                                  NavigatorHelper()
                                      .navigateTo("/checkout", data)
                                      .then((value) {
                                    bloc.fetchAllProducts(producerId);
                                  });
                                }
                              },
                              child: totalAmountSnapShot.data != 0
                                  ? Container(
                                      margin: PagePadding.custom(
                                          3.w, 3.w, 3.w, 6.w),
                                      padding: PagePadding.custom(
                                          3.w, 3.w, 1.5.w, 1.5.w),
                                      decoration:
                                          ContainerDecoration.boxDecoration(
                                              bg: APPColors.appPrimaryColor,
                                              border: APPColors.appPrimaryColor,
                                              radius: 8),
                                      child: BehaviorSubjectBuilder<int>(
                                          subject: bloc.totalQuantity,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<int> snapshot) {
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: 5.h,
                                                      child: RabbleText
                                                          .subHeaderText(
                                                        text: DateFormatUtil
                                                            .amountFormatter(
                                                                double.parse(
                                                                    totalAmountSnapShot
                                                                        .data!
                                                                        .toString())),
                                                        fontSize: 13.sp,
                                                        fontFamily: cGosha,
                                                        color:
                                                            APPColors.appBlack,
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
                  });
        });
  }

  void openLoginSheet() {
    CustomBottomSheet.showLoginViewModelSheet(context, LoginModalView(), true,
        isRemove: true);
  }
}
