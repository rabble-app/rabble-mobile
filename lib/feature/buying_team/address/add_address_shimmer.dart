import 'package:shimmer/shimmer.dart';

import '../../../core/config/export.dart';

class AddAddressShimmer extends StatelessWidget {
  const AddAddressShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BehaviorSubjectBuilder<String>(
              subject: BuyingTeamCreationService().groupNameSubject$,
              builder: (context, snapshot) {
                return CreationTeamAppbar(
                  backTitle: kBackToBasket,
                  title: snapshot.data,
                  barPercentage: 5,
                );
              }),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade300,
            enabled: true,
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: context.allHeight * 0.06,
                  child: Container(
                    height: context.allHeight * 0.22,
                    margin: PagePadding.horizontalSymmetric(context.allWidth*0.04),

                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: context.allHeight * 0.06,
                  child: Container(
                    height: context.allHeight * 0.22,
                    margin: PagePadding.horizontalSymmetric(context.allWidth*0.04),

                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),

                SizedBox(
                  height: context.allHeight * 0.06,
                  child: Container(
                    height: context.allHeight * 0.22,
                    margin: PagePadding.horizontalSymmetric(context.allWidth*0.04),

                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: context.allHeight * 0.06,
                  child: Container(
                    height: context.allHeight * 0.22,
                    margin: PagePadding.horizontalSymmetric(context.allWidth*0.04),

                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: context.allHeight * 0.06,
                  child: Container(
                    height: context.allHeight * 0.22,
                    margin: PagePadding.horizontalSymmetric(context.allWidth*0.04),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: context.allHeight/3,
                ),

                SizedBox(
                  height: context.allHeight * 0.06,
                  child: Container(
                    height: context.allHeight * 0.22,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
