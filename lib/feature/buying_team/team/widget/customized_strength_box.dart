import 'package:rabble/core/config/export.dart';

class CustomizedTeamStrengthBox extends StatelessWidget {
  const CustomizedTeamStrengthBox({
    Key? key,
    required this.amountSaved,
    required this.teamStrength,
    required this.vansPrevented,
  }) : super(key: key);

  final String vansPrevented;
  final String amountSaved;

  final String teamStrength;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: APPColors.appBlack,
      padding: PagePadding.all(1.78.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            padding: const PagePadding.customHorizontalVerticalSymmetric(7, 5),
            decoration: BoxDecoration(
              color: APPColors.appGreen3,
              borderRadius: BorderRadius.circular(3.w),
            ),
            child: Center(
              child: RabbleText.subHeaderText(
                text: '$kTeamStrength $teamStrength',
                textAlign: TextAlign.center,
                color: APPColors.appWhite,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
                fontSize: 10.sp,
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          content(Assets.svgs.truck_blue.svg(width: 6.w, height: 3.h, color: APPColors.appPrimaryColor), '$vansPrevented $kVans'),
          contentRichText(Assets.svgs.dollarSaved2.svg(width: 6.w, height: 3.h, color: APPColors.appPrimaryColor), '$amountSaved $kAmountSaved'),
        ],
      ),
    );
  }

  Widget content(Widget icon, String text) {
    return Padding(
      padding: const PagePadding.onlyTop(6),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 3.w,
          ),
          RabbleText.subHeaderText(
            text: text,
            color: APPColors.bgColor,
            fontWeight: FontWeight.w500,
            fontFamily: cPoppins,
            textAlign: TextAlign.left,
            fontSize: 12.sp,
          ),
        ],
      ),
    );
  }

  Widget contentRichText(Widget icon, String text) {
    return Padding(
      padding: const PagePadding.onlyTop(6),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 3.w,
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$amountSaved\t',
                  style: TextStyle(
                    color: APPColors.appPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                ),
                TextSpan(
                  text: kAmountSaved,
                  style: TextStyle(
                    color: APPColors.appWhite,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
