import 'package:rabble/core/config/export.dart';

class SubscriberTeamItemWidget extends StatelessWidget {
  final BuyingTeamDetail? buyingTeamDetail;

  const SubscriberTeamItemWidget({Key? key, this.buyingTeamDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('${buyingTeamDetail!.name}');
    return Container(
      width: context.allWidth * 0.9,
      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.bg_app_primary,
          border: APPColors.bg_grey25,
          width: 1,
          radius: 12),
      padding: PagePadding.custom(2.w, 2.w, 2.w, 0),
      margin: PagePadding.custom(0, 0, 0, 4.w),
      child: GestureDetector(
        onTap: () {
          Map map = {'teamId': buyingTeamDetail!.id, 'type': '1'};
          NavigatorHelper().navigateToScreen('/threshold_view', arguments: map);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 15.h,
              width: context.allWidth * 0.9,
              child: Stack(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(8),
                  //   child: Assets.png.buying_team_test.png(
                  //     width: context.allWidth * 0.9,
                  //     height: 14.h,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Positioned(
                    bottom: 15,
                    right: 10,
                    child: Container(
                      width: 14.w,
                      height: 3.h,
                      decoration: ContainerDecoration.boxDecoration(
                        bg: APPColors.appBlack,
                        border: APPColors.appBlack,
                        radius: 30,
                      ),
                      child: Center(
                        child: RabbleText.subHeaderText(
                          text: kWeekly,
                          color: APPColors.appPrimaryColor,
                          fontFamily: cPoppins,
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                RabbleText.subHeaderText(
                  text: buyingTeamDetail != null ? buyingTeamDetail!.name : '',
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.bold,
                  color: APPColors.appTextPrimary,
                  fontFamily: cGosha,
                  fontSize: 14.sp,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  width: 14.w,
                  height: 3.h,
                  decoration: ContainerDecoration.boxDecoration(
                    bg: APPColors.appBlack,
                    border: APPColors.appBlack,
                    radius: 30,
                  ),
                  child: Center(
                    child: RabbleText.subHeaderText(
                      text: kMember,
                      color: APPColors.appPrimaryColor,
                      fontFamily: cPoppins,
                      fontWeight: FontWeight.bold,
                      fontSize: 8.sp,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Assets.svgs.multi_profileuser
                        .svg(width: 4.w, height: 2.h, color: APPColors.appBlue),
                    SizedBox(
                      width: 2.w,
                    ),
                    RabbleText.subHeaderText(
                      text: buyingTeamDetail!.members!.isNotEmpty
                          ? buyingTeamDetail!.members!.length.toString()
                          : '0',
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w500,
                      color: APPColors.bg_grey27,
                      fontFamily: cPoppins,
                      fontSize: 9.sp,
                    ),
                  ],
                ),
                SizedBox(
                  width: 4.w,
                ),
                Row(
                  children: [
                    Assets.svgs.category
                        .svg(width: 4.w, height: 2.h, color: APPColors.appBlue),
                    SizedBox(
                      width: 2.w,
                    ),
                    RabbleText.subHeaderText(
                      text: buyingTeamDetail!.producer!.categories != null &&
                              buyingTeamDetail!
                                  .producer!.categories!.isNotEmpty &&
                              buyingTeamDetail!
                                      .producer!.categories!.first.category !=
                                  null
                          ? buyingTeamDetail!
                              .producer!.categories!.first.category!.name
                          : '',
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
            SizedBox(
              height: 1.h,
            ),
            Row(
              children: [
                Assets.svgs.truck_blue
                    .svg(width: 4.w, height: 2.h, color: APPColors.appBlue),
                SizedBox(
                  width: 2.w,
                ),
                RabbleText.subHeaderText(
                  text: DateFormatUtil.getNextDeliveryDate(
                      buyingTeamDetail!.nextDeliveryDate, buyingTeamDetail!.frequency!.toInt()),
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  color: APPColors.bg_grey27,
                  fontFamily: cPoppins,
                  fontSize: 9.sp,
                ),
              ],
            ),
            const Divider(
              color: APPColors.bg_grey25,
              thickness: 0.7,
            ),
            Row(
              children: [
                Container(
                  width: 18.w,
                  height: 3.2.h,
                  decoration: ContainerDecoration.boxDecoration(
                    bg: APPColors.appYellow,
                    border: APPColors.appYellow,
                    radius: 24,
                  ),
                  child: Center(
                    child: RabbleText.subHeaderText(
                      text: kProdcuer,
                      color: APPColors.appBlack,
                      fontFamily: cPoppins,
                      fontWeight: FontWeight.bold,
                      fontSize: 8.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                RabbleText.subHeaderText(
                  text: buyingTeamDetail!.producer! == null
                      ? ''
                      : buyingTeamDetail!.producer!.businessName,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.normal,
                  color: APPColors.appBlack,
                  fontFamily: cGosha,
                  fontSize: 11.sp,
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      width: 14.w,
                      height: 3.h,
                      decoration: ContainerDecoration.boxDecoration(
                        bg: APPColors.appYellow,
                        border: APPColors.appYellow,
                        radius: 24,
                      ),
                      child: Center(
                        child: RabbleText.subHeaderText(
                          text: kHost2,
                          color: APPColors.appBlack,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Center(
                      child: RabbleText.subHeaderText(
                        text: buyingTeamDetail!.host! == null
                            ? ''
                            : '${buyingTeamDetail!.host!.firstName ?? ''} ${buyingTeamDetail!.host!.lastName ?? ''}',
                        color: APPColors.appBlack,
                        fontSize: 10.sp,
                      ),
                    )
                  ],
                ),
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
