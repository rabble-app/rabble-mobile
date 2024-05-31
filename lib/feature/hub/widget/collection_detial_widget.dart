import '../../../core/config/export.dart';

class CollectionDetailWidget extends StatelessWidget {
  CollectionDetailWidget({super.key});

  final StreamController<bool> collectionES = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: collectionES.stream,
        initialData: false,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: PagePadding.custom(2.h, 2.h, 1.5.h, 0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        collectionES.sink.add(!snapshot.data!);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RabbleText.subHeaderText(
                            text: 'Collection Details',
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,
                            color: APPColors.appBlack4,
                            fontFamily: cGosha,
                            height: 1.3,
                            fontSize: 15.sp,
                          ),
                          !snapshot.data!
                              ? Assets.svgs.arrowUp.svg()
                              : Assets.svgs.arrowDown.svg()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    snapshot.data!
                        ? Column(
                            children: [
                              Container(
                                width: context.allWidth,
                                decoration: ContainerDecoration.boxDecoration(
                                    bg: APPColors.appWhite,
                                    border: APPColors.bg_grey26,
                                    radius: 8,
                                    width: 1,
                                    showShadow: true),
                                child: Padding(
                                  padding: PagePadding.all(1.5.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RabbleText.subHeaderText(
                                        text: 'Order Collection Address',
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w400,
                                        color: APPColors.appTextPrimary,
                                        fontFamily: cGosha,
                                        fontSize: 10.sp,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RabbleText.subHeaderText(
                                            text:
                                                'The High Road Wood Green,\nLondon N22 6SU',
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            color: APPColors.appBlack4,
                                            fontFamily: cGosha,
                                            fontSize: 11.sp,
                                          ),
                                          const KiloMeterWidget(
                                            color: APPColors.appBlack,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      SizedBox(
                                        height: context.allHeight * 0.2,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: const AppGoogleMap(
                                            zoomControlsEnabled: false,
                                            zoomGesturesEnabled: false,
                                            initialCameraPosition:
                                                CameraPosition(
                                                    target: LatLng(
                                                        36.7783, -119.4179),
                                                    zoom: 10),
                                            scrollGesturesEnabled: false,
                                            rotateGesturesEnabled: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              OpenHourWidget(),
                              SizedBox(
                                height: 1.h,
                              ),
                              const CommunityDetailWidget()
                            ],
                          )
                        : const Empty(),
                  ],
                ),
              ),
              if (snapshot.data!)
                SizedBox(
                  height: 2.5.h,
                ),
              const Divider(
                thickness: 0.5,
                height: 0.5,
                color: APPColors.bg_grey25,
              ),
            ],
          );
        });
  }
}
