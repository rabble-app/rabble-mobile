import '../../../config/export.dart';
import '../../../core/widgets/avatar_square_widget.dart';

class SubscriptionBasketWidget extends StatelessWidget {
  const SubscriptionBasketWidget({Key? key, required this.basket, required this.basketController}) : super(key: key);

  final String basket;
  final TextEditingController basketController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(2.5.w, 2.h),
      decoration: BoxDecoration(
        color: APPColors.appWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [

          SquareAvatarWidget(
            backgroundColor: APPColors.appGrey,
          ),

          SizedBox(
            width: 3.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Padding(
                padding: PagePadding.onlyBottom(10),
                child: RabbleText.subHeaderText(
                  text: kSubscription,
                  color: APPColors.appTextGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(
                  width: 62.w,
                  child: RabbleTextField.borderLess(
                    controller: basketController,
                    color: APPColors.appBlack,
                    keyBoardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    hint: kBasket,
                    onChange: (String query) {

                    },
                    filledColor: APPColors.appGrey,
                    fontFamily: 'Gosha',
                    letterSpacing: -0.9,
                    hintColor: APPColors.appTextGrey,
                  )),
            ],
          ),

        ],
      ),
    );
  }

}
