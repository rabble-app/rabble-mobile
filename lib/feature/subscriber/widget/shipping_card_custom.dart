import '../../../core/config/export.dart';

class ShippingCardCustom extends StatelessWidget {
  ShippingCardCustom({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.trailing,
    this.trailingValue,
    this.color,
    this.isTeamPage,
    this.imageBgColor,
    this.isTrailingWidget,
  });

  final String label;
  final String value;
  final String? trailingValue;
  final Widget icon;

  final Widget? trailing;
  final Color? color;
  final Color? imageBgColor;
  bool? isTeamPage = false;
  bool? isTrailingWidget = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(2.w, 3.w),
      margin: PagePadding.onlyBottom(1.5.h),
      decoration: ContainerDecoration.boxDecoration(
          bg: color ?? APPColors.appWhite,
          border: color ?? APPColors.appWhite,
          radius: 8,
          showShadow: true),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: value != null && value.length > 40
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Container(
            height: context.allHeight * 0.055,
            width: context.allWidth * 0.13,
            padding: PagePadding.all(2.w),
            decoration: ContainerDecoration.boxDecoration(
                bg: imageBgColor ?? APPColors.bg_grey26,
                border: imageBgColor ?? APPColors.bg_grey26,
                width: 1,
                radius: 8),
            child: icon,
          ),
          SizedBox(
            width: 3.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RabbleText.subHeaderText(
                text: label,
                fontSize: context.allWidth * 0.035,
                fontFamily:
                    isTeamPage != null && isTeamPage! ? cGosha : cPoppins,
                fontWeight: isTeamPage != null && isTeamPage!
                    ? FontWeight.w400
                    : FontWeight.w500,
                color: APPColors.appTextPrimary,
              ),
              SizedBox(
                height: 0.3.w,
              ),
              trailing != null && !isTrailingWidget!
                  ? Row(
                      children: [
                        RabbleText.subHeaderText(
                          text: trailingValue,
                          fontSize: context.allWidth * 0.03,
                          fontFamily: cPoppins,
                          fontWeight: FontWeight.normal,
                          color: APPColors.appBlack4,
                        ),
                        RabbleText.subHeaderText(
                          text: value.trim(),
                          fontSize: context.allWidth * 0.04,
                          fontFamily: cGosha,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                          color: APPColors.appBlack4,
                        ),
                      ],
                    )
                  : SizedBox(
                      width: context.allWidth * 0.67,
                      child: RabbleText.subHeaderText(
                        text: value.trim(),
                        fontSize: context.allWidth * 0.035,
                        fontFamily: cPoppins,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                        color: APPColors.appBlack4,
                      ),
                    ),
              if(isTrailingWidget!)
                trailing!,

            ],
          ),

          const Spacer(),
          Container(
              margin: imageBgColor != null
                  ? PagePadding.onlyRight(2.w)
                  : PagePadding.onlyRight(4.w),
              child: trailing ?? const SizedBox.shrink()),
        ],
      ),
    );
  }
}
