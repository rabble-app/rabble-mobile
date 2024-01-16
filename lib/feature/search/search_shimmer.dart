import 'package:shimmer/shimmer.dart';

import '../../../config/export.dart';

class SearchShimmer extends StatelessWidget {
  const SearchShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: APPColors.bgColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Container(
              margin: PagePadding.horizontalSymmetric(context.allWidth * 0.04),
              child: RabbleText.subHeaderText(
                text: '',
                fontSize: 15.sp,
                color: APPColors.appBlack,
                fontFamily: cGosha,
                fontWeight: FontWeight.w700,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade300,
              enabled: true,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    margin:
                        PagePadding.horizontalSymmetric(context.allWidth * 0.04),
                    child: Row(
                      children: [
                        Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: APPColors.bgColor)),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: context.allHeight * 0.007,
                          child: Container(
                            width: 40.w,
                            height: context.allHeight * 0.22,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    margin:
                        PagePadding.horizontalSymmetric(context.allWidth * 0.04),
                    child: Row(
                      children: [
                        Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: APPColors.bgColor)),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: context.allHeight * 0.007,
                          child: Container(
                            width: 37.w,
                            height: context.allHeight * 0.22,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    margin:
                        PagePadding.horizontalSymmetric(context.allWidth * 0.04),
                    child: Row(
                      children: [
                        Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: APPColors.bgColor)),
                        const SizedBox(
                          width: 10,
                        ),
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
                        const Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    margin:
                        PagePadding.horizontalSymmetric(context.allWidth * 0.04),
                    child: Row(
                      children: [
                        Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: APPColors.bgColor)),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: context.allHeight * 0.007,
                          child: Container(
                            width: 33.w,
                            height: context.allHeight * 0.22,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    margin:
                        PagePadding.horizontalSymmetric(context.allWidth * 0.04),
                    child: Row(
                      children: [
                        Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: APPColors.bgColor)),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: context.allHeight * 0.007,
                          child: Container(
                            width: 30.w,
                            height: context.allHeight * 0.22,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              margin: PagePadding.horizontalSymmetric(context.allWidth * 0.04),
              child: RabbleText.subHeaderText(
                text: '',
                fontSize: 15.sp,
                color: APPColors.appBlack,
                fontFamily: cGosha,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              margin: PagePadding.horizontalSymmetric(context.allWidth * 0.04),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                enabled: true,
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List<Widget>.generate(
                      10,
                      (index) => Container(
                          width: 30*index.toDouble(),
                          height: 25,
                          decoration: ContainerDecoration.boxDecoration(
                            bg: APPColors.bgColor,
                            border: APPColors.bgColor,
                            radius: 12,
                            width: 1
                          ))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
