import 'package:rabble/core/config/export.dart';

class ContinueButtonWidget extends StatelessWidget {
  final String? label;
  final Function? callBack;
  final double? width, height;
  final Color? backgroundColor;
  final PagePadding? padding;
  final Color? labelColor;

  const ContinueButtonWidget({
    Key? key,
    this.callBack,
    this.label,
    this.width,
    this.height,
    this.backgroundColor,
    this.padding,
    this.labelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callBack!.call();
      },
      child: Container(
        height: height ?? 6.5.h,
        width: width ?? 100.w,
        padding: padding ?? PagePadding.horizontalSymmetric(5.w),
        margin: PagePadding.onlyTop(5.w),
        // color: backgroundColor ?? Colors.transparent,
        child: RabbleButton.tertiaryFilled(
          bgColor: backgroundColor ?? APPColors.bg_grey6.withOpacity(0.7),
          child: RabbleText.subHeaderText(
            text: label ?? kContinue,
            fontSize: 13.sp,
            fontFamily: cGosha,
            //color: labelColor ?? APPColors.appIcons,
            color: labelColor == null ? backgroundColor == APPColors.appPrimaryColor ? APPColors.appBlack : APPColors.appIcons : labelColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
