import 'package:rabble/domain/entities/PartionedProductsData.dart';

import '../../../core/config/export.dart';

class PortionedProductSheet extends StatelessWidget {
  final VoidCallback callBackDelete;
  final String subheading, des, teamName;
  final bool showHeading;
  final bool isHost;
  final int? basketQty;
  final int? thresholdToMeetQty;
  final List<PartionedProducts>? data;

  const PortionedProductSheet(
      {super.key,
      required this.callBackDelete,
      required this.subheading,
      required this.teamName,
      required this.des,
      required this.showHeading,
      required this.isHost,
      this.data, this.basketQty, this.thresholdToMeetQty});

  @override
  Widget build(BuildContext context) {
    return ToucheDetector(child: portionedProductWidget(context));
  }

  Widget portionedProductWidget(BuildContext context) {
    return Container(
      color: APPColors.bgColor,
      padding: PagePadding.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          InkWell(
            onTap: () {
              NavigatorHelper().pop();
            },
            child: Container(
              alignment: Alignment.centerLeft,
              width: 9.w,
              height: 6.h,
              child: const CircleAvatar(
                backgroundColor: APPColors.appTextPrimary,
                child: Icon(
                  Icons.close,
                  color: APPColors.appWhite,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          RabbleText.subHeaderText(
            text: subheading,
            fontSize: 15.sp,
            height: 1.4,
            fontFamily: cGosha,
            fontWeight: FontWeight.bold,
            color: APPColors.appBlack4,
          ),
          SizedBox(
            height: 1.h,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: des,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: cPoppins,
                      fontWeight: FontWeight.normal,
                      color: APPColors.appTextPrimary,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          data!.isNotEmpty?
          ThresholdMetWidget(
            milestoneTowards: data!.first.threshold.toString(),
            completedMilestone: data!.first.accumulator.toString(),
            percentage: DateFormatUtil.calculatePercentage(
                int.parse(data!.first.accumulator.toString()),
                int.parse(data!.first.threshold.toString())),
            teamName: teamName ?? '',
          )
              :
          ThresholdMetWidget(
            milestoneTowards: thresholdToMeetQty.toString(),
            completedMilestone: basketQty.toString(),
            percentage: DateFormatUtil.calculatePercentage(
                int.parse(basketQty.toString()),
                int.parse(thresholdToMeetQty.toString())),
            teamName: teamName ?? '',
          ),

        ],
      ),
    );
  }
}
