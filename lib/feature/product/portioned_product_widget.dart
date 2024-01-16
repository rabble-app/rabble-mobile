import 'package:rabble/feature/product/portioned_product_list_widget.dart';

import '../../config/export.dart';
import '../../domain/entities/PartionedProductsData.dart';

class PortionedProductWidget extends StatelessWidget {
  PortionedProductWidget({
    Key? key,
    required this.heading,
    required this.subHeading,
    required this.items, required this.purchaseUser,
  }) : super(key: key);

  final String heading, subHeading;
  final List<PartionedProducts> items;
 final List<List<TempBoxData>> purchaseUser;
  final StreamController<bool> expansionStream =
      StreamController<bool>.broadcast();

  @override
  Widget build(BuildContext context) {


    print("items ${items.length}");
    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(3.w, 1.h),
      margin: PagePadding.onlyBottom(1.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: APPColors.greyText.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: StreamBuilder<bool>(
          stream: expansionStream.stream,
          initialData: false,
          builder: (context, expansionSnapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    expansionStream.sink.add(!expansionSnapshot.data!);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RabbleText.subHeaderText(
                        text: heading,
                        fontSize: 15.sp,
                        color: APPColors.appBlack4,
                        fontFamily: cGosha,
                        fontWeight: FontWeight.w700,
                      ),
                      Icon(
                        !expansionSnapshot.data!
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: APPColors.appBlue,
                        size: 30,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                RabbleText.subHeaderText(
                  text: subHeading,
                  fontSize: 10.sp,
                  fontFamily: cPoppins,
                  textAlign: TextAlign.start,
                  height: 1.3,
                  fontWeight: FontWeight.w400,
                  color: APPColors.appTextPrimary,
                ),
                SizedBox(
                  height: 1.h,
                ),
                if (expansionSnapshot.data!)
                  ListView.builder(
                      itemCount: items.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        PartionedProducts item = items[index];
                        return PortionedProductTeamListWidget(
                          totalItems: item.threshold!.toInt(),
                          partionedProductsList: items,
                          purchaseUser: purchaseUser[index],
                        );
                      }),
              ],
            );
          }),
    );
  }
}
