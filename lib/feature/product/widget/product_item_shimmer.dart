import 'package:rabble/config/export.dart';

class ProductItemShimmer extends StatelessWidget {
  const ProductItemShimmer({super.key});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        padding: PagePadding.horizontalSymmetric(1.w),
        margin: PagePadding.horizontalSymmetric(1.w),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: context.allWidth * 0.9,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              width: context.allWidth * 0.42 ,
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
