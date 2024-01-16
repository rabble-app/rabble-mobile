import 'package:rabble/config/export.dart';
import 'package:shimmer/shimmer.dart';

class BuyingTeamItemShimmer extends StatelessWidget {
  const BuyingTeamItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: context.allWidth * 0.9,
        decoration: ContainerDecoration.boxDecoration(
            bg: Colors.transparent,
            border: APPColors.bg_grey25,
            width: 1,
            radius: 12),
        padding: PagePadding.custom(2.w, 2.w, 2.w, 0),
        margin: PagePadding.custom(1.w, 3.w, 2.w, 2.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
              width: context.allWidth * 0.9,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: context.allWidth * 0.9,
                      height: 14.h,
                      child: Container(
                        width: context.allWidth * 0.9,
                        height: 14.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
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
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.allHeight * 0.007,
              child: Container(
                width: 20.w,
                height: context.allHeight * 0.22,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              children: [
                Container(
                  height: context.allHeight * 0.007,
                  margin: PagePadding.custom(3.w, 0,0, 0),

                  child: Container(
                    width: 15.w,
                    height: context.allHeight * 0.22,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: context.allHeight * 0.007,
                  margin: PagePadding.custom(3.w, 0,0, 0),

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
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              height: context.allHeight * 0.007,
              child: Container(
                width: 20.w,
                height: context.allHeight * 0.22,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            const Divider(
              color: APPColors.bg_grey25,
              thickness: 0.7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: context.allHeight * 0.007,
                  margin: PagePadding.custom(3.w, 0,0, 0),

                  child: Container(
                    width: 15.w,
                    height: context.allHeight * 0.22,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: context.allHeight * 0.007,
                  margin: PagePadding.custom(3.w, 0,0, 0),

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
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
