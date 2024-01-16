import 'package:rabble/config/export.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutShimmer extends StatelessWidget {
  const CheckoutShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: context.allWidth * 0.9,
        margin: PagePadding.custom(0, 3.w, 3.w, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: context.allHeight * 0.08,
              margin: PagePadding.custom(3.w, 0, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:  Container(
                  width: 100.w,
                  height: context.allHeight * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                Container(
                  height: context.allHeight * 0.007,
                  margin: PagePadding.custom(3.w, 0,0, 0),

                  child: Container(
                    width: 20.w,
                    height: context.allHeight * 0.3,
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
            Container(
              height: 5,
              margin: PagePadding.custom(2.w,0,0,5.w),

              child: Container(
                width: 100.w,
                height: context.allHeight * 0.22,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
