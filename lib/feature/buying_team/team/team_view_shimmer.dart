import 'package:rabble/config/export.dart';

class TeamViewShimmer extends StatelessWidget {
  TeamViewShimmer({Key? key}) : super(key: key);

  final StreamController<bool> _expandableStream = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CreationTeamAppbar(
            backTitle: kBack,
            title: data['teamName'] ?? '',
            backRoute: '',
            action: [
              CustomShareWidget(
                title: kShare,
                onTap: () async {},
              ),
            ],
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade300,
            enabled: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.allHeight * 0.25,
                  child: Container(
                    width: 100.w,
                    height: context.allHeight * 0.22,
                    color: Colors.white,
                  ),
                ),

                SizedBox(
                  height: 2.w,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                  width: 70,
                                  height: 70,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: APPColors.bgColor)),
                              Container(
                                width: 8.w,
                                height: 2.h,
                                transform: Matrix4.translationValues(0, -10, 0),
                                decoration: ContainerDecoration.boxDecoration(
                                  bg: APPColors.appYellow,
                                  border: APPColors.appYellow,
                                  radius: 24,
                                ),
                                child: RabbleText.subHeaderText(
                                  text: kHost2,
                                  color: APPColors.appBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: context.allHeight * 0.007,
                                child: Container(
                                  width: 35.w,
                                  height: context.allHeight * 0.22,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: context.allHeight * 0.007,
                                child: Container(
                                  width: 15.w,
                                  height: context.allHeight * 0.22,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: context.allHeight * 0.007,
                                child: Container(
                                  width: 15.w,
                                  height: context.allHeight * 0.22,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),

                              SizedBox(
                                height: context.allHeight * 0.007,
                                child: Container(
                                  width: 12.w,
                                  height: context.allHeight * 0.22,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: APPColors.bgColor)),
                                  Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: APPColors.bgColor)),
                                  Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: APPColors.bgColor)),
                                ],
                              )
                            ],
                          )

                        ],
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: context.allHeight * 0.09,
                        child: Container(
                          width: 90.w,
                          height: context.allHeight * 0.22,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: context.allHeight * 0.09,
                  child: Container(
                    height: context.allHeight * 0.22,
                    color: Colors.white,
                  ),
                ),
                
                Container(
                  height: context.allHeight * 0.2,
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: context.allHeight * 0.22,
                    color: Colors.white,
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }


}
