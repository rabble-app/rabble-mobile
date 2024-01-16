import 'package:rabble/config/export.dart';
import 'package:rabble/core/widgets/date_format.dart';

class ThresholdMetCustomWidget extends StatelessWidget {
  const ThresholdMetCustomWidget({
    Key? key,
    required this.completedMilestone,
    required this.milestoneTowards,
    required this.totalDays,
    required this.totalMembers,
    required this.percentage,
    required this.producerName,
  }) : super(key: key);

  final String completedMilestone, milestoneTowards, totalMembers, totalDays;
  final String percentage, producerName;

  @override
  Widget build(BuildContext context) {
    print(percentage);
    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(3.w, 3.h),
      margin: PagePadding.onlyBottom(1.h),
      decoration: BoxDecoration(
        color: APPColors.appWhite,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 3), // Offset in the x and y direction
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          int.parse(percentage) >= 100
              ? Row(
                  children: [
                    RabbleText.subHeaderText(
                      text: kThresholdMet,
                      fontSize: 14.sp,
                      color: APPColors.appBlack4,
                      fontFamily: cGosha,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    const Icon(
                      Icons.check_circle_outline,
                      color: APPColors.appGreen2,
                    )
                  ],
                )
              : Row(
                  children: [
                    RabbleText.subHeaderText(
                      text: kThresholdNotMet,
                      fontSize: 14.sp,
                      color: APPColors.appBlack4,
                      fontFamily: cGosha,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    const Icon(
                      Icons.warning_amber,
                      color: APPColors.appYellow2,
                    )
                  ],
                ),
          SizedBox(
            height: 1.h,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: completedMilestone,
                  style: buildTextStyle().copyWith(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: ' $kTowards ',
                  style: buildTextStyle(),
                ),
                TextSpan(
                  text: milestoneTowards,
                  style: buildTextStyle().copyWith(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text:
                      ' minimum by $totalMembers ${totalMembers == '1' ? 'member.' : 'members.'}\n',
                  style: buildTextStyle(),
                ),
                TextSpan(
                  text:
                      '${int.parse(totalDays)<0?0:totalDays} ${int.parse(totalDays)<=1?"day ":"days "}remaining to reach $producerName’s minimum order value',
                  style: buildTextStyle(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Container(
            child: Stack(
              fit: StackFit.loose,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 100.w,
                  height: 2.5.h,
                  decoration: BoxDecoration(
                      color: APPColors.bg_grey33,
                      borderRadius: BorderRadius.circular(8)),
                ),
                Stack(
                  fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: int.parse(percentage) >= 100
                          ? context.allWidth
                          : DateFormatUtil.calculateScreenPercentage(
                              double.parse(percentage), context.allWidth + 20),
                      height: 2.5.h,
                      decoration: BoxDecoration(
                          color: APPColors.appPrimaryColor,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    Positioned(
                      bottom: -10,
                      left: int.parse(percentage) < 100
                          ? DateFormatUtil.calculateScreenPercentage(
                              double.parse(percentage), context.allWidth + 40)
                          : context.allWidth * 0.75,
                      child: CircleAvatar(
                        backgroundColor: APPColors.appBlack,
                        radius: 6.w,
                        child: RabbleText.subHeaderText(
                          text: '${percentage}%',
                          fontFamily: cGosha,
                          fontSize: 11.sp,
                          color: APPColors.bg_grey26,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle buildTextStyle() {
    return const TextStyle(
        color: APPColors.appTextPrimary, fontFamily: cPoppins, height: 1.3);
  }
}

class ThresholdMetWidget extends StatelessWidget {
  const ThresholdMetWidget({
    Key? key,
    required this.completedMilestone,
    required this.milestoneTowards,
    required this.percentage,
    required this.teamName,
  }) : super(key: key);

  final String completedMilestone, milestoneTowards;
  final String percentage, teamName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(3.w, 3.h),
      margin: PagePadding.onlyBottom(1.h),
      decoration: BoxDecoration(
        color: APPColors.appWhite,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 3), // Offset in the x and y direction
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          int.parse(percentage) >= 100
              ? Row(
                  children: [
                    RabbleText.subHeaderText(
                      text: 'Order Threshold Met',
                      fontSize: 14.sp,
                      color: APPColors.appBlack4,
                      fontFamily: cGosha,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: APPColors.appGreen2,
                    )
                  ],
                )
              : Row(
                  children: [
                    RabbleText.subHeaderText(
                      text: 'Order to Meet Threshold',
                      fontSize: 14.sp,
                      color: APPColors.appBlack4,
                      fontFamily: cGosha,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    const Icon(
                      Icons.info,
                      color: APPColors.appBlue,
                      size: 26,
                    ),
                  ],
                ),
          SizedBox(
            height: 1.h,
          ),
          completedMilestone=='0'?
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: milestoneTowards,
                  style: buildTextStyle().copyWith(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: ' minimum $teamName',
                  style: buildTextStyle(),
                ),
              ],
            ),
          )
              :
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: completedMilestone,
                  style: buildTextStyle().copyWith(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: ' of ',
                  style: buildTextStyle(),
                ),
                TextSpan(
                  text: milestoneTowards,
                  style: buildTextStyle().copyWith(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: ' minimum $teamName',
                  style: buildTextStyle(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Container(
            child: Stack(
              fit: StackFit.loose,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 100.w,
                  height: 2.5.h,
                  decoration: BoxDecoration(
                      color: APPColors.bg_grey33,
                      borderRadius: BorderRadius.circular(8)),
                ),
                Stack(
                  fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: int.parse(percentage) >= 100
                          ? context.allWidth
                          : DateFormatUtil.calculateScreenPercentage(
                              double.parse(percentage), context.allWidth + 20),
                      height: 2.5.h,
                      decoration: BoxDecoration(
                          color: APPColors.appPrimaryColor,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    Positioned(
                      bottom: -10,
                      left: int.parse(percentage) < 100
                          ? DateFormatUtil.calculateScreenPercentage(
                              double.parse(percentage), context.allWidth + 40)
                          : context.allWidth * 0.75,
                      child: CircleAvatar(
                        backgroundColor: APPColors.appBlack,
                        radius: 6.w,
                        child: RabbleText.subHeaderText(
                          text: '${percentage}%',
                          fontFamily: cGosha,
                          fontSize: 11.sp,
                          color: APPColors.bg_grey26,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle buildTextStyle() {
    return const TextStyle(
        color: APPColors.appTextPrimary, fontFamily: cPoppins, height: 1.3);
  }
}
