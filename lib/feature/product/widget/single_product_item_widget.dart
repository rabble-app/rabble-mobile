import 'package:rabble/core/config/export.dart';
import 'package:rabble/feature/auth/login/login_modal_view.dart';
import 'package:rabble/feature/product/product_detail/portioned_product_sheet.dart';

class SingleProductItemWidget extends StatelessWidget {
  final ProductDetail productDetail;
  final ProducerDetail? businessDetail;
  final VoidCallback? voidCallBack;
  final VoidCallback? samePageCallBack;
  bool? isHorizontal = false;
  bool? isSamePage = false;
  bool? isPortionedProduct = false;
  Map? isEmpty = {};

  SingleProductItemWidget(this.productDetail,
      {Key? key,
      this.businessDetail,
      this.isHorizontal,
      this.voidCallBack,
      this.isSamePage,
      this.samePageCallBack,
      this.isPortionedProduct,
      this.isEmpty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, ProductDetailCubit>(
        create: (BuildContext context) => ProductDetailCubit()
          ..fetchSingleProductExist2(productDetail, productDetail.id!),
        builder: (BuildContext context, RabbleBaseState state,
            ProductDetailCubit bloc) {
          return BehaviorSubjectBuilder<ProductDetail>(
              subject: bloc.productDetailSubject$,
              builder: (BuildContext context,
                  AsyncSnapshot<ProductDetail> productInCartSnapShot) {
                if (!productInCartSnapShot.hasData) return SizedBox.shrink();
                return Padding(
                  padding: isHorizontal!
                      ? PagePadding.horizontalSymmetric(1.w)
                      : PagePadding.horizontalSymmetric(3.w),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');

                          if (isSamePage != null && isSamePage!) {
                            samePageCallBack!.call();
                          } else {
                            isEmpty!['productId'] = productDetail.id;
                            isEmpty!['producerId'] = businessDetail!.id;
                            NavigatorHelper()
                                .navigateTo('/detail', isEmpty)
                                .then((value) {
                              bloc.fetchSingleProductExist2(productDetail,productDetail.id!);
                              voidCallBack!.call();
                            });
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: ContainerDecoration.boxDecoration(
                                      border: APPColors.appWhite,
                                      bg: APPColors.appWhite,
                                      radius: 16,
                                      width: 1),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: SizedBox(
                                      width: isHorizontal!
                                          ? context.allWidth * 0.4
                                          : context.allWidth * 0.9,
                                      height: isHorizontal!
                                          ? MediaQuery.of(context).size.height *
                                              0.2
                                          : MediaQuery.of(context).size.height *
                                              0.22,
                                      child: RabbleImageLoader(
                                              imageUrl:
                                                  productDetail.imageUrl ?? '',
                                              isRound: false,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 10,
                                  child: Container(
                                    padding: PagePadding
                                        .customHorizontalVerticalSymmetric(
                                            0.8.h, 0.3.h),
                                    decoration:
                                        ContainerDecoration.boxDecoration(
                                            bg: APPColors.appBlack4,
                                            border: APPColors.appBlack4,
                                            width: 1,
                                            radius: 28),
                                    child: Center(
                                      child: RabbleText.subHeaderText(
                                        text:
                                            '${bloc.calculatePercentage(productDetail.price, productDetail.rrp)}% Discount',
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 7.sp,
                                        fontFamily: cPoppins,
                                        color: APPColors.appPrimaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),

                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                              width: context.allWidth * 0.42,
                              child: RabbleText.subHeaderText(
                                text: productDetail.name ?? '',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp,
                                fontFamily: cPoppins,
                                color: APPColors.appBlack4,
                              ),
                            ),
                            !isHorizontal!
                                ? SizedBox(
                                    height: 0.5.h,
                                  )
                                : const SizedBox.shrink(),
                            businessDetail != null
                                ? RabbleText.subHeaderText(
                                    text:
                                        '${productDetail.unitsPerOrder} ${productDetail.unitsOfMeasure!.toLowerCase()} ${productDetail.orderSubUnit!.toLowerCase()}',
                                    fontSize: 9.sp,
                                    fontFamily: cPoppins,
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                    color: APPColors.bg_grey27,
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(
                              height: 1.h,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RabbleText.subHeaderText(
                            text: 'RRP: ',
                            fontSize: 9.sp,
                            fontFamily: cPoppins,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w500,
                            color: APPColors.bg_grey27,
                          ),
                          RabbleText.subHeaderText(
                            text: productDetail.rrp != null
                                ? '£${productDetail.rrp}'
                                : '',
                            fontSize: 9.sp,
                            fontFamily: cPoppins,
                            textDecoration: TextDecoration.lineThrough,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w500,
                            color: APPColors.bg_grey27,
                          ),
                          const Spacer(),
                          Container(
                            padding:
                                PagePadding.customHorizontalVerticalSymmetric(
                                    0.8.h, 0.3.h),
                            decoration: ContainerDecoration.boxDecoration(
                                bg: APPColors.appPrimaryColor,
                                border: APPColors.appPrimaryColor,
                                width: 1,
                                radius: 28),
                            child: Center(
                              child: RabbleText.subHeaderText(
                                text:
                                    'Save ${bloc.calculateSaving(productDetail.price, productDetail.rrp)}',
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                fontSize: 7.sp,
                                fontFamily: cPoppins,
                                color: APPColors.appBlack4,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RabbleText.subHeaderText(
                            text: productDetail.price != null
                                ? '£${productDetail.price}'
                                : '',
                            fontSize: 17.sp,
                            fontFamily: cGosha,
                            color: APPColors.appBlack4,
                            fontWeight: FontWeight.bold,
                          ),
                          isHorizontal!
                              ? SizedBox(
                                  width: context.allWidth * 0.16,
                                )
                              : const SizedBox.shrink(),
                          productInCartSnapShot.hasData &&
                                  productInCartSnapShot.data!.qty != null &&
                                  productInCartSnapShot.data!.qty != 0
                              ? QuantityWidget(
                                  qty: productInCartSnapShot.data!.qty
                                      .toString(),
                                  qtyCallBack: (qty) async {
                                    print("PORTIONED_SINGLE_PRODUCT ");
                                    await bloc.productQuantity(
                                        qty,
                                        productDetail.id,
                                        businessDetail != null
                                            ? businessDetail!.id!
                                            : '');

                                    if (voidCallBack != null) {
                                      voidCallBack!.call();
                                    }
                                  },
                                  removeProduct: () async {
                                    if (productInCartSnapShot.data != null &&
                                        productInCartSnapShot.data!.qty! > 1) {
                                      await bloc.productQuantity(
                                          productInCartSnapShot.data!.qty! - 1,
                                          productInCartSnapShot.data!.id!,
                                          businessDetail!.id!);
                                    } else {
                                      await bloc
                                          .removeProduct(productDetail.id!);
                                    }

                                    voidCallBack!.call();
                                  },
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    String status =
                                        await RabbleStorage().getLoginStatus() ??
                                            "0";

                                    String postalCode =
                                        await RabbleStorage().getPostalCode();

                                    if (status != '0') {
                                      if (postalCode.isEmpty) {
                                        NavigatorHelper().navigateTo(
                                            '/add_postal_code_view');
                                      } else {
                                        productDetail
                                            .producerName = businessDetail !=
                                                null
                                            ? businessDetail!.businessName ?? ''
                                            : '';
                                        if (voidCallBack != null) {
                                          productDetail.qty =
                                              productInCartSnapShot.data!.qty! +
                                                  1;
                                          await bloc.addProductInCart(
                                              context, productDetail);
                                          voidCallBack!.call();
                                        } else {
                                          productDetail.qty =
                                              productInCartSnapShot.data!.qty! +
                                                  1;
                                          bloc.addProductInCart(
                                              context, productDetail);
                                        }
                                      }
                                    }
                                    else {
                                      CustomBottomSheet.showLoginViewModelSheet(
                                          context, LoginModalView(), true,
                                          isRemove: true);
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          RabbleText.subHeaderText(
                                            text: kAdd,
                                            fontSize: 13.sp,
                                            fontFamily: cGosha,
                                            color: APPColors.appBlack4,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          Container(
                                            width: 8.w,
                                            height: 0.2.h,
                                            color: APPColors.appBlack,
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.add_outlined,
                                        color: APPColors.appBlack4,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
