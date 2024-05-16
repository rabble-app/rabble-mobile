import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/core/widgets/km_widget.dart';

class HubWidget extends StatelessWidget {
  final String? teamId,
      status,
      address,
      teamName,
      frequency,
      category,
      nextDelivery,
      totalTeamMembers,
      postalCode;
  final Function? callBack;
  final bool? isVertical;
  final VoidCallback callBackIfUpdated;
  final OrderHistoryData? historyData;
  final bool? isHost;

  const HubWidget(
      {Key? key,
      this.teamId,
      this.teamName,
      this.status,
      this.address,
      this.frequency,
      this.category,
      this.nextDelivery,
      this.totalTeamMembers,
      this.callBack,
      this.isVertical,
      required this.callBackIfUpdated,
      this.historyData,
      this.isHost,
      this.postalCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.allWidth * 0.93,
      decoration: ContainerDecoration.boxDecoration(
          bg: Colors.transparent,
          border: APPColors.bg_grey25,
          width: 1,
          radius: 12),
      padding: PagePadding.custom(2.w, 2.w, 2.w, 0),
      margin: PagePadding.custom(1.w, 3.w, 2.w, !isVertical! ? 2.w : 0),
      child: InkWell(
        onTap: () => callBack!.call(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: context.allHeight * 0.2,
              width: context.allWidth * 0.9,
              decoration: ContainerDecoration.boxDecoration(
                  bg: APPColors.appBlack4,
                  border: APPColors.appBlack4,
                  width: 0,
                  radius: 8),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: 1.h, right: 1.h, left: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const KiloMeterWidget(kiloMeters: '20 meters away'),
                          Container(
                            height: 3.h,
                            width: context.allWidth * 0.16,
                            decoration: ContainerDecoration.boxDecoration(
                              bg: APPColors.appBlack,
                              border: APPColors.appBlack,
                              radius: 30,
                            ),
                            child: Center(
                              child: RabbleText.subHeaderText(
                                text: frequency,
                                color: APPColors.appPrimaryColor,
                                fontFamily: cPoppins,
                                fontWeight: FontWeight.bold,
                                fontSize: 8.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 5,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: context.allWidth * 0.7,
                        child: RabbleText.subHeaderText(
                          text: '$teamName',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          color: APPColors.appPrimaryColor,
                          fontFamily: cGosha,
                          height: 1.1,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                  ),
                  Assets.svgs.hub_box.svg(fit: BoxFit.fill),
                ],
              ),
            ),
            SizedBox(
              height: 2.w,
            ),
            Row(
              children: [
                Container(
                  height: 3.2.h,
                  padding: PagePadding.horizontalSymmetric(1.5.w),
                  decoration: ContainerDecoration.boxDecoration(
                    bg: APPColors.appYellow,
                    border: APPColors.appYellow,
                    radius: 24,
                  ),
                  child: Center(
                    child: RabbleText.subHeaderText(
                      text: 'Hub Host',
                      color: APPColors.appBlack,
                      fontFamily: cPoppins,
                      fontWeight: FontWeight.bold,
                      fontSize: 8.sp,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Assets.svgs.multi_profileuser
                        .svg(width: 4.w, height: 2.h, color: APPColors.appBlue),
                    SizedBox(
                      width: 2.w,
                    ),
                    RabbleText.subHeaderText(
                      text:
                          '${totalTeamMembers ?? '0'} ${totalTeamMembers == '1' ? 'member' : 'members'}',
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w500,
                      color: APPColors.bg_grey27,
                      fontFamily: cPoppins,
                      fontSize: 9.sp,
                    ),
                  ],
                )
              ],
            ),
            const Divider(
              color: APPColors.bg_grey25,
              thickness: 0.7,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Assets.svgs.category.svg(
                            width: 4.w, height: 2.h, color: APPColors.appBlue),
                        SizedBox(
                          width: 2.w,
                        ),
                        RabbleText.subHeaderText(
                          text: category ?? '',
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          color: APPColors.bg_grey27,
                          fontFamily: cPoppins,
                          fontSize: 9.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    Row(
                      children: [
                        Assets.svgs.truck_filled.svg(
                            width: 4.w, height: 2.h, color: APPColors.appBlue),
                        SizedBox(
                          width: 2.w,
                        ),
                        RabbleText.subHeaderText(
                          text: nextDelivery ?? '',
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          color: APPColors.bg_grey27,
                          fontFamily: cPoppins,
                          fontSize: 9.sp,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                status != null && status == 'PENDING'
                    ? Container(
                        width: isHost == null ? 25.w : 18.w,
                        height: 3.h,
                        decoration: ContainerDecoration.boxDecoration(
                          bg: APPColors.bg_grey33,
                          border: APPColors.bg_grey33,
                          radius: 30,
                        ),
                        child: Center(
                          child: RabbleText.subHeaderText(
                            text:
                                isHost == null ? 'Request Pending' : 'Pending',
                            color: APPColors.appBlue,
                            fontFamily: cPoppins,
                            fontWeight: FontWeight.w600,
                            fontSize: 7.sp,
                          ),
                        ),
                      )
                    : status != null && status == 'APPROVED'
                        ? Container(
                            width: 15.w,
                            height: 3.h,
                            decoration: ContainerDecoration.boxDecoration(
                              bg: APPColors.appBlack,
                              border: APPColors.appBlack,
                              radius: 30,
                            ),
                            child: Center(
                              child: RabbleText.subHeaderText(
                                text: 'Member',
                                color: APPColors.appPrimaryColor,
                                fontFamily: cPoppins,
                                fontWeight: FontWeight.w600,
                                fontSize: 7.sp,
                              ),
                            ),
                          )
                        : status != null && status == 'CANCELLED'
                            ? Container(
                                width: 18.w,
                                height: 3.h,
                                decoration: ContainerDecoration.boxDecoration(
                                  bg: APPColors.appRedLight2,
                                  border: APPColors.appRedLight2,
                                  radius: 30,
                                ),
                                child: Center(
                                  child: RabbleText.subHeaderText(
                                    text: 'Cancelled',
                                    color: APPColors.appRedLight,
                                    fontFamily: cPoppins,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 7.sp,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
          ],
        ),
      ),
    );
  }
}
