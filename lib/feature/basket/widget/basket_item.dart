import 'package:rabble/config/export.dart';

class BasketItemWidget extends StatelessWidget {
  final String title, qty, price;

  const BasketItemWidget(
      {super.key, required this.title, required this.qty, required this.price});

  @override
  Widget build(BuildContext context) {

    print("price ${price}");
    return SizedBox(
      height: 5.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              RabbleText.subHeaderText(
                text: '${qty}x   ',
                fontSize: 12.sp,
                fontFamily: cPoppins,
                fontWeight: FontWeight.w400,
                color: APPColors.appTextPrimary,
              ),
              SizedBox(
                width: context.allWidth*0.5,
                child: RabbleText.subHeaderText(
                  text: title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  fontSize: 12.sp,
                  fontFamily: cPoppins,
                  fontWeight: FontWeight.w400,
                  color: APPColors.appTextPrimary,
                ),
              ),
            ],
          ),
          RabbleText.subHeaderText(
            text: DateFormatUtil.amountFormatter( (int.parse(qty)*int.parse(price)).toDouble()),
            fontSize: 13.sp,
            fontFamily: cGosha,
            fontWeight: FontWeight.w700,
            color: APPColors.appTextPrimary,
          ),
        ],
      ),
    );
  }
}
