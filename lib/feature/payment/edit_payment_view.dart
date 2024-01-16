import 'package:rabble/config/export.dart';

class EditPaymentView extends StatelessWidget {
  const EditPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.grey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: const RabbleAppbar(
          backgroundColor: APPColors.bg_app_primary,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: PagePadding.all(4.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.5.h,
                ),
                RabbleText.subHeaderText(
                  text: kUpdateYourCreditCard,
                  color: APPColors.appBorder,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                RabbleTextField.border(
                  color: APPColors.appBlack,
                  keyBoardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  fontSize: 13.sp,
                  hintFontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  hint: kCardHolderName,
                  borderColor: APPColors.appWhite,
                  filledColor: APPColors.appWhite,
                  maxLines: 2,
                  fontFamily: 'Gosha',
                  letterSpacing: -0.9,
                  hintColor: APPColors.appBlack,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                RabbleTextField.border(
                  color: APPColors.appBlack,
                  keyBoardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  fontSize: 13.sp,
                  hintFontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  hint: kCreditCardNumber,
                  borderColor: APPColors.appWhite,
                  filledColor: APPColors.appWhite,
                  maxLines: 2,
                  fontFamily: 'Gosha',
                  letterSpacing: -0.9,
                  hintColor: APPColors.appBlack,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 44.w,
                      child: RabbleTextField.border(
                        color: APPColors.appBlack,
                        keyBoardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        fontSize: 13.sp,
                        hintFontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        hint: kMMYY,
                        borderColor: APPColors.appWhite,
                        filledColor: APPColors.appWhite,
                        maxLines: 2,
                        fontFamily: 'Gosha',
                        letterSpacing: -0.9,
                        hintColor: APPColors.appBlack,
                      ),
                    ),
                    SizedBox(
                      width: 44.w,
                      child: RabbleTextField.border(
                        color: APPColors.appBlack,
                        keyBoardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        fontSize: 13.sp,
                        hintFontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        hint: kCVV,
                        borderColor: APPColors.appWhite,
                        filledColor: APPColors.appWhite,
                        maxLines: 2,
                        fontFamily: 'Gosha',
                        letterSpacing: -0.9,
                        hintColor: APPColors.appBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.5.h,
                ),
                RabbleText.subHeaderText(
                  text: kBillingAddress,
                  color: APPColors.appBlack,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 4.5.h,
                ),
                RabbleText.subHeaderText(
                  text: kPostCode,
                  color: APPColors.appBlack,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                RabbleTextField.border(
                  color: APPColors.appBlack,
                  keyBoardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  fontSize: 13.sp,
                  hintFontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  borderColor: APPColors.appWhite,
                  filledColor: APPColors.appWhite,
                  maxLines: 2,
                  hint: "",
                  fontFamily: 'Gosha',
                  letterSpacing: -0.9,
                  hintColor: APPColors.appBlack,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                RabbleText.subHeaderText(
                  text: kBuildingNumber,
                  color: APPColors.appBlack,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                RabbleTextField.border(
                  color: APPColors.appBlack,
                  keyBoardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  fontSize: 13.sp,
                  hintFontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  borderColor: APPColors.appWhite,
                  filledColor: APPColors.appWhite,
                  maxLines: 2,
                  hint: "",
                  fontFamily: 'Gosha',
                  letterSpacing: -0.9,
                  hintColor: APPColors.appBlack,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                RabbleText.subHeaderText(
                  text: kAddressLine,
                  color: APPColors.appBlack,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                RabbleTextField.border(
                  color: APPColors.appBlack,
                  keyBoardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  fontSize: 13.sp,
                  hintFontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  borderColor: APPColors.appWhite,
                  filledColor: APPColors.appWhite,
                  maxLines: 2,
                  hint: "",
                  fontFamily: 'Gosha',
                  letterSpacing: -0.9,
                  hintColor: APPColors.appBlack,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                RabbleText.subHeaderText(
                  text: kCity,
                  color: APPColors.appBlack,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                RabbleTextField.border(
                  color: APPColors.appBlack,
                  keyBoardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  fontSize: 13.sp,
                  hintFontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  borderColor: APPColors.appWhite,
                  filledColor: APPColors.appWhite,
                  maxLines: 2,
                  hint: "",
                  fontFamily: 'Gosha',
                  letterSpacing: -0.9,
                  hintColor: APPColors.appBlack,
                ),
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  height: 8.h,
                  child: RabbleButton.tertiaryFilled(
                    child: RabbleText.subHeaderText(
                      text: kUpdateChanges,
                      fontSize: 14.sp,
                      fontFamily: 'Gosha',
                      color: APPColors.appIcons,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
