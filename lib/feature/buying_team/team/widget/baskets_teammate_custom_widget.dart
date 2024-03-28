import 'package:rabble/core/config/export.dart';

class BasketTeammateView extends StatelessWidget {
  const BasketTeammateView({
    Key? key,
    required this.yourBasketItemAmount,
    required this.yourBasketItemsCount,
  }) : super(key: key);

  final String yourBasketItemsCount, yourBasketItemAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(3.w, 1.2.h),
      decoration: BoxDecoration(
          color: APPColors.appWhite, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: RabbleText.subHeaderText(
                  text: 'GH',
                  color: APPColors.appPrimaryColor,
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RabbleText.subHeaderText(
                    text: kYourBasket,
                    fontWeight: FontWeight.w700,
                  ),
                  RabbleText.subHeaderText(
                    text: k3Items,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: cPoppins,
                    color: APPColors.appBlack4,
                  ),
                ],
              ),
              Spacer(),
              Container(
                margin: PagePadding.onlyTop(1.2.h),
                child: RabbleText.subHeaderText(
                  text: k3Items,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: cPoppins,
                  color: APPColors.appBlack4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
