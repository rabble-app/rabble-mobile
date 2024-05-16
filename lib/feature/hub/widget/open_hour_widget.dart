import 'package:rabble/core/config/export.dart';

class OpenHourWidget extends StatelessWidget {
  OpenHourWidget({super.key});

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
                              text: 'Mon - Fri',
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600,
                              color: APPColors.appGreen4,
                              fontFamily: cPoppins,
                              fontSize: 8.sp,
                            ),
                          ),
                        ],
                      ),
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
                snapshot.data! ? const DaysWidget() : const SizedBox.shrink()
              ],
            ),
          );
        });
  }
}
