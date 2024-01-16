import 'package:rabble/config/export.dart';

class CartItemWidget extends StatelessWidget {
  final String itemName, producerName, qty, price, productType;
  final Function qtyCallBack;
  final String? unitsOfMeasure, orderSubUnit, orderUnit;
  final int? unitsPerOrder, thresholdQty,totalThresholdQty;
  final bool isLast;
  final Function removeProduct;

  const CartItemWidget(
      {Key? key,
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
      this.orderUnit, this.totalThresholdQty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePadding.custom(2.w, 2.w, 5.w, 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          productType == 'PORTIONED_SINGLE_PRODUCT'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RabbleText.subHeaderText(
                      text: producerName,
                      fontWeight: FontWeight.bold,
                      fontFamily: cGosha,
                      color: APPColors.appBlack4,
                      fontSize: 14.sp,
                    ),
                    Container(
                      height: context.allWidth * 0.07,
                      width: context.allWidth * 0.2,
                      padding: PagePadding.horizontalSymmetric(1.w),
                      decoration: ContainerDecoration.boxDecoration(
                          border: APPColors.borderColor2,
                          bg: APPColors.borderColor2,
                          width: 1,
                          radius: 28),
                      child: Center(
                        child: RabbleText.subHeaderText(
                          text: '${totalThresholdQty} ${orderSubUnit} ${orderUnit}',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600,
                          fontSize: 6.5.sp,
                          fontFamily: cPoppins,
                          color: APPColors.appBlue,
                        ),
                      ),
                    ),
                  ],
                )
              : RabbleText.subHeaderText(
                  text: itemName,
                  fontWeight: FontWeight.bold,
                  fontFamily: cGosha,
                  color: APPColors.appBlack4,
                  fontSize: 14.sp,
                ),
          if (productType != 'PORTIONED_SINGLE_PRODUCT')
            SizedBox(
              height: 0.5.h,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child:  RabbleText.subHeaderText(
                        text:
                            '${unitsPerOrder} ${unitsOfMeasure!.toLowerCase()} ${orderSubUnit!.toLowerCase()}',
                        fontSize: 10.sp,
                        fontFamily: cPoppins,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.normal,
                        color: APPColors.appTextPrimary,
                      )

              ),
              Padding(
                padding: PagePadding.onlyTop(2.w),
                child: QuantityWidget(
                  qty: qty.toString(),
                  qtyCallBack: (qty) {
                    if (productType != 'PORTIONED_SINGLE_PRODUCT') {
                      qtyCallBack.call(qty);
                    } else {
                      print(qty);
                      print(this.qty);
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
              )
            ],
          ),
          if (productType != 'PORTIONED_SINGLE_PRODUCT')
            SizedBox(
              height: 1.h,
            ),
          productType == 'PORTIONED_SINGLE_PRODUCT'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RabbleText.subHeaderText(
                          text: price != null ? '$price/' : '',
                          fontSize: 13.sp,
                          fontFamily: cGosha,
                          color: APPColors.appBlack4,
                          fontWeight: FontWeight.bold,
                        ),
                        RabbleText.subHeaderText(
                          text: '${orderSubUnit}',
                          fontSize: 8.sp,
                          height: 1,
                          fontFamily: cPoppins,
                          color: APPColors.appBlack4,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    Container(
                      height: context.allWidth * 0.06,
                      width: thresholdQty! <= 0
                          ? context.allWidth * 0.4
                          : context.allWidth * 0.1,
                      padding: PagePadding.all(1.w),
                      decoration: ContainerDecoration.boxDecoration(
                          border: APPColors.appGreen5,
                          bg: APPColors.appGreen5,
                          width: 1,
                          radius: 28),
                      child: Center(
                        child: RabbleText.subHeaderText(
                          text: thresholdQty! <= 0
                              ? 'you grabbed the last carton!'
                              : '${thresholdQty} left',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600,
                          fontSize: 6.5.sp,
                          fontFamily: cPoppins,
                          color: APPColors.appGreen4,
                        ),
                      ),
                    )
                  ],
                )
              : RabbleText.subHeaderText(
                  text: '${price}',
                  textAlign: TextAlign.start,
                  fontSize: 13.sp,
                  fontFamily: cGosha,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.7,
                  wordSpacing: 1.5,
                  color: APPColors.appTextPrimary,
                ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            height: 1,
            color: const Color(0x33777777),
          )
        ],
      ),
    );
  }
}
