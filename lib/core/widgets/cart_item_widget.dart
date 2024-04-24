import 'package:flutter/material.dart';
import 'package:rabble/core/config/export.dart';

class CartItemWidget extends StatelessWidget {
  final String itemName, producerName, qty, price, productType, imageUrl;
  final Function qtyCallBack;
  final String? unitsOfMeasure, orderSubUnit, orderUnit;
  final int? unitsPerOrder, thresholdQty, totalThresholdQty;
  final bool isLast;
  final Function removeProduct;

  const CartItemWidget({
    Key? key,
    required this.qtyCallBack,
    required this.isLast,
    required this.removeProduct,
    required this.itemName,
    required this.producerName,
    required this.qty,
    required this.price,
    required this.productType,
    this.unitsPerOrder,
    this.unitsOfMeasure,
    this.orderSubUnit,
    this.thresholdQty,
    this.orderUnit,
    this.totalThresholdQty,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePadding.onlyTop(3.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: context.allWidth * 0.16,
              height: MediaQuery.of(context).size.height * 0.07,
              child: RabbleImageLoader(
                imageUrl: imageUrl ?? '',
                isRound: false,
                roundValue: 25,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 1.5.w),
          // Title and other details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: context.allWidth * 0.51,
                child: RabbleText.subHeaderText(
                  text: itemName,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                  fontFamily: cPoppins,
                  color: APPColors.appBlack4,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(
                height: 0.2.h,
              ),
              RabbleText.subHeaderText(
                text:
                    '${unitsPerOrder} ${unitsOfMeasure!.toLowerCase()} ${orderSubUnit!.toLowerCase()}',
                fontSize: 10.sp,
                fontFamily: cPoppins,
                maxLines: 1,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.normal,
                color: APPColors.appTextPrimary,
              ),
              SizedBox(
                height: 0.6.h,
              ),
              RabbleText.subHeaderText(
                text: '${price}',
                textAlign: TextAlign.start,
                fontSize: 10.sp,
                height: 0.7,
                fontFamily: cPoppins,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.7,
                wordSpacing: 1.5,
                color: APPColors.appTextPrimary,
              ),
            ],
          ),
          SizedBox(width: 1.5.w),
          productType == 'PORTIONED_SINGLE_PRODUCT'
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (productType == 'PORTIONED_SINGLE_PRODUCT')
                        Container(
                          height: context.allWidth * 0.067,
                          width: orderSubUnit == 'Bottle'
                              ? context.allWidth * 0.17
                              : context.allWidth * 0.22,
                          padding: PagePadding.horizontalSymmetric(1.w),
                          margin: PagePadding.onlyBottom(1.w),
                          decoration: ContainerDecoration.boxDecoration(
                            border: APPColors.borderColor2,
                            bg: APPColors.borderColor2,
                            width: 1,
                            radius: 28,
                          ),
                          child: Center(
                            child: RabbleText.subHeaderText(
                              text: orderSubUnit == 'Bottle'
                                  ? '$totalThresholdQty $orderSubUnit'
                                  : '$totalThresholdQty $orderSubUnit $orderUnit',
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600,
                              fontSize: 6.5.sp,
                              fontFamily: cPoppins,
                              color: APPColors.appBlue,
                            ),
                          ),
                        ),
                      QuantityWidget(
                        qty: qty.toString(),
                        qtyCallBack: (qty) {
                          if (productType != 'PORTIONED_SINGLE_PRODUCT') {
                            qtyCallBack.call(qty);
                          } else {
                            if (thresholdQty != 0 ||
                                int.parse(qty.toString()) <
                                    int.parse(this.qty)) {
                              qtyCallBack.call(qty);
                            }
                          }
                        },
                        removeProduct: () {
                          removeProduct.call();
                        },
                      ),
                      if (productType == 'PORTIONED_SINGLE_PRODUCT')
                        Container(
                          width:  context.allWidth * 0.1,
                          padding:
                              PagePadding.customHorizontalVerticalSymmetric(
                                  1.w, 1.w),
                          margin: PagePadding.onlyTop(1.w),
                          decoration: ContainerDecoration.boxDecoration(
                            border: APPColors.appGreen5,
                            bg: APPColors.appGreen5,
                            width: 1,
                            radius: 28,
                          ),
                          child: Center(
                            child: RabbleText.subHeaderText(
                              text: '${thresholdQty} left',
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600,
                              fontSize: 6.5.sp,
                              fontFamily: cPoppins,
                              color: APPColors.appGreen4,
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : Padding(
                  padding: PagePadding.onlyTop(1.h),
                  child: QuantityWidget(
                    qty: qty.toString(),
                    qtyCallBack: (qty) {
                      if (productType != 'PORTIONED_SINGLE_PRODUCT') {
                        qtyCallBack.call(qty);
                      } else {
                        if (thresholdQty != 0 ||
                            int.parse(qty.toString()) < int.parse(this.qty)) {
                          qtyCallBack.call(qty);
                        }
                      }
                    },
                    removeProduct: () {
                      removeProduct.call();
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
