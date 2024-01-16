import 'package:rabble/config/export.dart';
import 'package:shimmer/shimmer.dart';

import '../../product/widget/product_item_shimmer.dart';

class ProducerViewShimmer extends StatelessWidget {
  const ProducerViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1;
    return FocusChild(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: context.allHeight * 0.007,
                    margin: PagePadding.custom(3.w, 3.w,0, 0),

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
                    margin: PagePadding.custom(3.w, 3.w,0, 0),

                    child: Container(
                      width: 20.w,
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
              Container(
                margin: PagePadding.custom(3.w, 3.w,0, 0),
                height: 7.h,
                child: Container(
                  width: 100.w,
                  height: context.allHeight * 0.22,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                height: 20,
                margin: PagePadding.custom(3.w, 3.w,0, 0),
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
              Container(
                height: 30,
                margin: PagePadding.custom(3.w, 3.w,0, 0),
                child: Container(
                  width: 40.w,
                  height: context.allHeight * 0.22,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                height: 30,
                margin: PagePadding.custom(3.w, 3.w,0, 0),
                child: Container(
                  width: 100.w,
                  height: context.allHeight * 0.22,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              GridView.builder(
                physics:
                const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                    (itemWidth /
                        itemHeight)),

                itemBuilder:
                    (BuildContext context,
                    int index) {
                  return  Container(
                    height: 30,
                    margin: PagePadding.custom(2.w, 2.w,1.w, 2.w),
                    child: Container(
                      width: 50.w,
                      height: context.allHeight * 0.22,
                      decoration: ContainerDecoration.boxDecoration(
                        bg: APPColors.appWhite,
                        border: APPColors.appYellow,
                        radius: 12,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
