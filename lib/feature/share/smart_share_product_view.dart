import 'package:rabble/core/util/trim_name_extension.dart';
import 'package:rabble/domain/entities/PartionedProductsData.dart';
import 'package:rabble/feature/product/portioned_product_list_widget.dart';

import '../../core/config/export.dart';

class SmartShareProductView extends StatelessWidget {
  final List<PartionedProducts> partionedProductsList;
  final int totalItems;
  final VoidCallback callBackClose;
  final TeamData teamData;
  final List<List<TempBoxData>> purchasedUser;

  const SmartShareProductView({
    super.key,
    required this.partionedProductsList,
    required this.totalItems,
    required this.teamData,
    required this.callBackClose,
    required this.purchasedUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: APPColors.bgColor,
        padding: PagePadding.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    NavigatorHelper().pop();
                    callBackClose();
                  },
                  child: CircleAvatar(
                    radius: 2.2.h,
                    backgroundColor: APPColors.appTextPrimary,
                    child: const Icon(
                      Icons.close,
                      color: APPColors.appWhite,
                    ),
                  ),
                ),
                Container(
                  width: context.allWidth * 0.1,
                  padding:
                      PagePadding.customHorizontalVerticalSymmetric(1.w, 1.w),
                  margin: PagePadding.onlyTop(1.w),
                  decoration: ContainerDecoration.boxDecoration(
                    border: APPColors.borderColor2,
                    bg: APPColors.borderColor2,
                    width: 1,
                    radius: 28,
                  ),
                  child: Center(
                    child: RabbleText.subHeaderText(
                      text: '${totalItems - partionedProductsList.length} left',
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                      fontSize: 7.sp,
                      fontFamily: cPoppins,
                      color: APPColors.appBlue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            RabbleText.subHeaderText(
              text: 'Share With Your Friends & Family',
              fontSize: 13.sp,
              fontFamily: cGosha,
              color: APPColors.appBlack4,
              fontWeight: FontWeight.w600,
            ),
            // SizedBox(height: 1.h),
            // RabbleText.subHeaderText(
            //   text:
            //       'There are ${totalItems - membersList.length} ${partionedProductsList[index].product!.orderSubUnit!.length > 1 ? '${partionedProductsList[index].product!.orderSubUnit!.toLowerCase()}s' : partionedProductsList[index].product!.orderSubUnit!.toLowerCase()} left in this ${partionedProductsList[index].product!.orderUnit!.toLowerCase()} of ${partionedProductsList[index].product!.unitsOfMeasure!.toLowerCase()} , invite others to try it with you.',
            //   fontSize: 10.sp,
            //   textAlign: TextAlign.start,
            //   fontFamily: cPoppins,
            //   color: APPColors.appTextPrimary,
            //   fontWeight: FontWeight.w400,
            // ),
            SizedBox(height: 2.h),
            ListView.builder(
                itemCount: partionedProductsList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  PartionedProducts item = partionedProductsList[index];
                  return PortionedProductBoxListWidget(
                    totalItems: item.threshold!.toInt(),
                    partionedProductsList: partionedProductsList,
                    purchaseUser: purchasedUser[index],
                  );
                }),
            const Spacer(),
            RabbleButton.tertiaryFilled(
              buttonSize: ButtonSize.large,
              bgColor: APPColors.appPrimaryColor,
              onPressed: () async {
                var link = await TeamViewCubit(teamId: '')
                    .generateDeepLinkForProducer(ProducerDetail(
                  id: teamData.producer!.id,
                  businessName: teamData.producer!.businessName,
                  imageUrl: teamData.producer!.imageUrl,
                  description: teamData.producer!.description,
                ));
                Share.share(
                  'Check out this producer on Rabble! ${teamData.producer!.businessName} $link',
                );
              },
              child: RabbleText.subHeaderText(
                text: 'Share Now',
                fontSize: 13.sp,
                fontFamily: cGosha,
                color: APPColors.appBlack4,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 3.h,
            )
          ],
        ),
      ),
    );
  }
}
