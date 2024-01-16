import '../../config/export.dart';
import '../../domain/entities/PartionedProductsData.dart';

class PortionedProductListWidget extends StatelessWidget {
  final PartionedProducts item;

  const PortionedProductListWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1;

    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(3.w, 1.h),
      margin: PagePadding.onlyBottom(1.h),
      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.appWhite,
          border: APPColors.appWhite,
          radius: 8,
          width: 1,
          showShadow: true),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: item.threshold!.toInt(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: (itemWidth / itemHeight)),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: context.allWidth * 0.04,
            width: context.allWidth * 0.23,
            padding: PagePadding.horizontalSymmetric(1.w),
            decoration: ContainerDecoration.boxDecoration(
                border: index < item.accumulator!.toInt()
                    ? APPColors.borderColor
                    : APPColors.bg_grey26,
                bg: index < item.accumulator!.toInt()
                    ? APPColors.bg_grey26
                    : APPColors.bg_grey26,
                width: 1,
                radius: 8),
            child: Container(
              margin: index < item.accumulator!.toInt()
                  ? PagePadding.verticalSymmetric(1.w)
                  : PagePadding.custom(0.3.w, 0.3.w, 1.3.w, 1.3.w),
              decoration: ContainerDecoration.boxDecoration(
                  border: index < item.accumulator!.toInt()
                      ? APPColors.appBlue
                      : APPColors.bg_grey33,
                  bg: index < item.accumulator!.toInt()
                      ? APPColors.appBlue
                      : APPColors.bg_grey33,
                  width: 1,
                  radius: 4),
              child: Center(
                child: RabbleText.subHeaderText(
                  text: getName('${item.partitionedProductUsersRecord!.first.owner!.firstName!} ${item.partitionedProductUsersRecord!.first.owner!.lastName!}'),
                  fontWeight: FontWeight.bold,
                  color: APPColors.appPrimaryColor,
                  fontSize: 8.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  getName(String name) {
    List<String> text = name.split(' ');
    print(text.toString());

    String firstCharName1 = '';
    String firstCharName2 = '';

    String combination = '';

    if (text.isNotEmpty) {
      firstCharName1 = text[0];
      firstCharName2 = text.length > 1 ? text[1] : " "; // Change 2 to 1

      combination = firstCharName1[0] + firstCharName2[0];
    }
    return combination;
  }

}

class PortionedProductTeamListWidget extends StatelessWidget {
  final int totalItems;
  final List<PartionedProducts> partionedProductsList;
  final List<TempBoxData> purchaseUser;

  const PortionedProductTeamListWidget(
      {super.key,
      required this.totalItems,
      required this.partionedProductsList,
      required this.purchaseUser});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1;

    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(3.w, 1.h),
      margin: PagePadding.onlyTop(2.w),
      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.appWhite,
          border: APPColors.appWhite,
          radius: 8,
          width: 1,
          showShadow: true),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: totalItems,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: (itemWidth / itemHeight)),
        itemBuilder: (BuildContext context, int index) {

          return Container(
            height: context.allWidth * 0.04,
            width: context.allWidth * 0.23,
            padding: PagePadding.horizontalSymmetric(1.w),
            decoration: ContainerDecoration.boxDecoration(
                border: purchaseUser.length > index
                    ? APPColors.appBlack
                    : APPColors.bg_grey26,
                bg: purchaseUser.length > index
                    ? APPColors.appBlack
                    : APPColors.bg_grey26,
                width: 1,
                radius: 8),
            child: Container(
              margin: purchaseUser.length > index
                  ? PagePadding.verticalSymmetric(1.w)
                  : PagePadding.custom(0.3.w, 0.3.w, 1.3.w, 1.3.w),
              decoration: ContainerDecoration.boxDecoration(
                  border: purchaseUser.length > index
                      ? APPColors.appBlack
                      : APPColors.borderColor2,
                  bg: purchaseUser.length > index
                      ? APPColors.appBlack
                      : APPColors.borderColor2,
                  width: 1,
                  radius: 4),
              child: purchaseUser.length > index
                  ? Center(
                      child: RabbleText.subHeaderText(
                        text: purchaseUser.length > index
                            ? getName(purchaseUser[index].userName!)
                            : '',
                        fontWeight: FontWeight.bold,
                        color: APPColors.appPrimaryColor,
                        fontSize: 7.2.sp,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }

  getName(String name) {
    List<String> text = name.split(' ');
    print('names ${text.toString()}');
    print('length ${text.length.toString()}');

    String firstCharName1 = '';
    String firstCharName2 = '';

    String combination = '';

    if (text.isNotEmpty) {
      firstCharName1 = text[0];
      firstCharName2 = text.length > 1 ? text[1] : " "; // Change 2 to 1

      combination = firstCharName2.length > 0? firstCharName1[0] + firstCharName2[0]:firstCharName1[0];
    }
    return combination;
  }
}
