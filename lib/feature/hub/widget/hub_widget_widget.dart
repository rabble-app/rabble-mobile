import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/mock/mock_hub_model.dart';
import 'package:rabble/feature/hub/hub_cubit.dart';

class HubWidget extends StatelessWidget {
  final String? teamId,
      status,
      address,
      teamName,
      frequency,
      category,
      nextDelivery,
      totalTeamMembers,
      distance,
      postalCode;
  final Function? callBack;
  final bool? isVertical;
  final VoidCallback callBackIfUpdated;
  final OrderHistoryData? historyData;
  final bool? isHost;
  final bool? isHorizontal;

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
      this.postalCode,
      this.distance,
      this.isHorizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExploreCubit bloc = context.read<ExploreCubit>();

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
        onTap: () {
          NavigatorHelper().navigateToPartnerTeamScreen(teamId.toString());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isHorizontal!
                ? Flexible(
                    child: Container(
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
                              padding: EdgeInsets.only(
                                  bottom: 1.h, right: 1.h, left: 1.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BehaviorSubjectBuilder<Map<String, int>>(
                                      subject: bloc.cachedDistancesSubject,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<Map<String, int>>
                                              snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Empty();
                                        }

                                        String distance = snapshot
                                                .data![postalCode]
                                                ?.toString() ??
                                            '';

                                        return KiloMeterWidget(
                                          distance: distance,
                                        );
                                      }),
                                  Container(
                                    height: 3.h,
                                    decoration:
                                        ContainerDecoration.boxDecoration(
                                      bg: APPColors.appBlack,
                                      border: APPColors.appBlack,
                                      radius: 30,
                                    ),
                                    padding:
                                        PagePadding.horizontalSymmetric(2.w),
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
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                  )
                : Container(
                    width: context.allWidth * 0.9,
                    height: context.allWidth * 0.45,
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
                            padding: EdgeInsets.only(
                                bottom: 1.h, right: 1.h, left: 1.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BehaviorSubjectBuilder<Map<String, int>>(
                                    subject: bloc.cachedDistancesSubject,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Map<String, int>>
                                            snapshot) {
                                      if (!snapshot.hasData)
                                        return const Empty();

                                      String distance = snapshot
                                              .data![postalCode]
                                              ?.toString() ??
                                          '';

                                      return KiloMeterWidget(
                                        distance: distance,
                                      );
                                    }),
                                Container(
                                  height: 3.h,
                                  decoration: ContainerDecoration.boxDecoration(
                                    bg: APPColors.appBlack,
                                    border: APPColors.appBlack,
                                    radius: 30,
                                  ),
                                  padding: PagePadding.horizontalSymmetric(2.w),
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
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
