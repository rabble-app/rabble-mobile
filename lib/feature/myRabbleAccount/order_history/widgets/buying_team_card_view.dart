import 'package:rabble/core/config/export.dart';

class BuyingTeamCardView extends StatefulWidget {
  const BuyingTeamCardView({
    Key? key,
    required this.date,
    required this.amount,
    required this.deliveryFee,
    required this.orderItems,
    required this.orderNumber,
    required this.subTotal,
    required this.orderQty, required this.basket,
  }) : super(key: key);

  final String date, amount, orderNumber;

  final List<Basket>? basket;
  /// additional details
  final String orderItems, orderQty;
  final String subTotal, deliveryFee;

  @override
  State<BuyingTeamCardView> createState() => _BuyingTeamCardViewState();
}

class _BuyingTeamCardViewState extends State<BuyingTeamCardView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Size data = MediaQuery.of(context).size;

    return Container(
      width: data.width,
      decoration: BoxDecoration(
          color: APPColors.appWhite, borderRadius: BorderRadius.circular(8)),
      child: ExpansionTile(
        iconColor: APPColors.appPrimaryColor,
        initiallyExpanded: false,
        childrenPadding: const EdgeInsets.all(0),
        tilePadding: EdgeInsets.only(left: 3.w,right: 3.w),
        title: Align(
          alignment: Alignment.topLeft,
          child: content('${widget.orderQty} items ',
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: APPColors.appTextPrimary,
              fontFamily: cPoppins),
        ),
        maintainState: true,
        onExpansionChanged: (b) {
          setState(() {
            isExpanded = b;
          });
        },
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,

        trailing: SizedBox(
          width: 25.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              content(widget.amount,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: APPColors.appTextPrimary,
                  fontFamily: cGosha),
              SizedBox(
                width: 2.w,
              ),
              !isExpanded
                  ? const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: APPColors.appBlue,
                      size: 20,
                    )
                  : const Icon(
                      Icons.keyboard_arrow_up_outlined,
                      color: APPColors.appBlue,
                      size: 20,
                    )
            ],
          ),
        ),
        children: [
         ...widget.basket!.map((e) => Container(
           padding: PagePadding.custom(2.w, 2.w, 1.5.w, 1.5.w),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Divider(
                 color: APPColors.bg_grey25,
                 thickness: 0.7,
               ),
               Padding(
                 padding: PagePadding.horizontalSymmetric(2.w),
                 child: BasketItemWidget(
                   qty: e.quantity.toString(),
                   title: e.product!.name!,
                   price: ' ${e.price.toString()}',
                 ),
               ),
             ],
           ),
         )) ,
        ],
      ),
    );
  }

  dynamic content(String text,
      {FontWeight? fontWeight,
      double? fontSize,
      Color? color,
      String? fontFamily}) {
    return RabbleText.subHeaderText(
      text: text,
      fontSize: fontSize,
      fontFamily: fontFamily ?? cPoppins,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
