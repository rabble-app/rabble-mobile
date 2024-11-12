import '../../../core/config/export.dart';

class DeliveryAddressCustom extends StatelessWidget {
  const DeliveryAddressCustom({
    super.key,
    required this.label,
    required this.value,
    this.trailing,
    this.trailingValue,
    this.color,
    this.imageBgColor,
    required this.countDay,
    this.partnerName,
    this.status,
    required this.isMember,
  });

  final String label;
  final String value;
  final String? trailingValue;

  final Widget? trailing;
  final Color? color;
  final Color? imageBgColor;
  final String countDay;
  final String? partnerName;
  final bool? status;
  final bool isMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(2.w, 2.w),
      margin: PagePadding.onlyBottom(1.5.h),
      decoration: ContainerDecoration.boxDecoration(
          bg: color ?? APPColors.appWhite,
          border: color ?? APPColors.appWhite,
          radius: 8,
          showShadow: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: value.length > 40
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
                child: int.parse(countDay) <= 0 && status! && isMember
                    ? Assets.svgs.boxTickRemove.svg()
                    : Assets.svgs.boxTick.svg(),
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
                    fontFamily: cPoppins,
                    fontWeight: FontWeight.w500,
                    color: APPColors.appTextPrimary,
                  ),
                  SizedBox(
                    height: 0.3.w,
                  ),
                  SizedBox(
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
                ],
              ),
            ],
          ),
          if (countDay == '1' && status! && isMember) ...[
            SizedBox(
              height: 1.h,
            ),
            Container(
              decoration: ContainerDecoration.boxDecoration(
                  bg: const Color(0xffFFFAE5),
                  border: const Color(0xffB54708).withOpacity(0.20),
                  radius: 8,
                  width: 1,
                  showShadow: true),
              padding: PagePadding.all(3.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Assets.svgs.danger_filled.svg(),
                  SizedBox(
                    width: 2.w,
                  ),
                  SizedBox(
                    width: context.allWidth * 0.72,
                    child: RabbleText.subHeaderText(
                      text:
                          'You have 24 hours to collect your items and will be charged £1 per day after that. All proceeds go to $partnerName',
                      fontSize: 10.sp,
                      fontFamily: cPoppins,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffB54708),
                    ),
                  ),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}
