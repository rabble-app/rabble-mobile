import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/hub/open_hours_model.dart';

class OpenHourWidget extends StatelessWidget {
  final OpenHoursModel openHoursModel;

  OpenHourWidget(this.openHoursModel, {super.key});

  final StreamController<bool> collectionES = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: collectionES.stream,
        initialData: false,
        builder: (context, snapshot) {
          return Container(
            decoration: ContainerDecoration.boxDecoration(
                bg: APPColors.bgColor,
                border: APPColors.bg_grey25,
                radius: 8,
                width: 1,
                showShadow: true),
            padding: PagePadding.customHorizontalVerticalSymmetric(1.5.h, 1.h),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    collectionES.sink.add(!snapshot.data!);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          RabbleText.subHeaderText(
                            text: 'Open Hours',
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,
                            color: APPColors.appBlack4,
                            fontFamily: cGosha,
                            height: 1.3,
                            fontSize: 14.sp,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          Container(
                            decoration: ContainerDecoration.boxDecoration(
                                bg: APPColors.appGreen5,
                                border: APPColors.appGreen5,
                                width: 1,
                                radius: 30),
                            padding:
                                PagePadding.customHorizontalVerticalSymmetric(
                                    2.w, 1.w),
                            margin: PagePadding.onlyTop(1.w),
                            child: RabbleText.subHeaderText(
                              text:openHoursModel.type == 'ALL_THE_TIME'?
                              'Open 24/7':
                              openHoursModel.customOpenHours?.length == 1
                                  ? openHoursModel.customOpenHours?.first.day
                                  : getDays(openHoursModel.customOpenHours),
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600,
                              color: APPColors.appGreen4,
                              fontFamily: cPoppins,
                              fontSize: 8.sp,
                            ),
                          ),
                        ],
                      ),
                      if(openHoursModel.type != 'ALL_THE_TIME')
                      InkWell(
                        child: !snapshot.data!
                            ? Assets.svgs.arrowUp
                                .svg(color: APPColors.appBlack5)
                            : Assets.svgs.arrowDown
                                .svg(color: APPColors.appBlack5),
                      ),
                    ],
                  ),
                ),
                snapshot.data! &&
                        (openHoursModel.type == 'CUSTOM' ||
                            openHoursModel.type == 'MON_TO_FRI')
                    ? DaysWidget(openHoursModel.customOpenHours!)
                    : const SizedBox.shrink()
              ],
            ),
          );
        });
  }

  getDays(List<CustomOpenHours>? customOpenHours) {
    Map<String, int> dayOrder = {
      "MONDAY": 1,
      "TUESDAY": 2,
      "WEDNESDAY": 3,
      "THURSDAY": 4,
      "FRIDAY": 5,
      "SATURDAY": 6,
      "SUNDAY": 7,
    };

    customOpenHours
        ?.sort((a, b) => dayOrder[a.day]!.compareTo(dayOrder[b.day]!));

    return '${customOpenHours?.first.day?.substring(0, 3)} - ${customOpenHours?.last.day?.substring(0, 3)}';
  }
}
