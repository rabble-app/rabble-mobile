import 'package:rabble/core/util/trim_name_extension.dart';
import 'package:rabble/domain/entities/PartionedProductsData.dart';

import '../../core/config/export.dart';

class ShareProductView extends StatelessWidget {
  final List<PartionedProducts> partionedProductsList;
  final int totalItems;
  final List<TempBoxData> purchaseUser;
  final int index;
  final TeamData teamData;

  const ShareProductView({
    super.key,
    required this.partionedProductsList,
    required this.totalItems,
    required this.purchaseUser,
    required this.index,
    required this.teamData,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1;

    return Container(
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
                    text: '${totalItems - purchaseUser.length} left',
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
          SizedBox(height: 1.h),
          RabbleText.subHeaderText(
            text:
                'There are ${totalItems - purchaseUser.length} ${partionedProductsList[index].product!.orderSubUnit!.length > 1 ? '${partionedProductsList[index].product!.orderSubUnit!.toLowerCase()}s' : partionedProductsList[index].product!.orderSubUnit!.toLowerCase()} left in this ${partionedProductsList[index].product!.orderUnit!.toLowerCase()} of ${partionedProductsList[index].product!.unitsOfMeasure!.toLowerCase()} , invite others to try it with you.',
            fontSize: 10.sp,
            textAlign: TextAlign.start,
            fontFamily: cPoppins,
            color: APPColors.appTextPrimary,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: 2.h),
          Container(
            padding: PagePadding.customHorizontalVerticalSymmetric(1.h, 1.h),
            margin: PagePadding.custom(1.w, 1.w, 1.w, 1.w),
            decoration: ContainerDecoration.boxDecoration(
                bg: APPColors.appWhite,
                border: APPColors.appWhite,
                radius: 8,
                width: 1,
                showShadow: true),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
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
                  padding: PagePadding.horizontalSymmetric(1.w),
                  decoration: ContainerDecoration.boxDecoration(
                      border: purchaseUser.length > index
                          ? totalItems - purchaseUser.length == 0
                              ? APPColors.appPrimaryColor
                              : APPColors.appBlack
                          : APPColors.bg_grey25,
                      bg: purchaseUser.length > index
                          ? totalItems - purchaseUser.length == 0
                              ? APPColors.appPrimaryColor
                              : APPColors.appBlack
                          : APPColors.bg_grey25,
                      width: 1,
                      radius: 8),
                  child: Container(
                    margin: purchaseUser.length > index
                        ? PagePadding.verticalSymmetric(1.w)
                        : PagePadding.custom(0.3.w, 0.3.w, 1.3.w, 1.3.w),
                    decoration: ContainerDecoration.boxDecoration(
                        border: purchaseUser.length > index
                            ? totalItems - purchaseUser.length == 0
                                ? APPColors.appPrimaryColor
                                : APPColors.appBlack
                            : APPColors.bg_grey25,
                        bg: purchaseUser.length > index
                            ? totalItems - purchaseUser.length == 0
                                ? APPColors.appPrimaryColor
                                : APPColors.appBlack
                            : APPColors.bg_grey25,
                        width: 1,
                        radius: 4),
                    child: purchaseUser.length > index
                        ? Center(
                            child: RabbleText.subHeaderText(
                              text: purchaseUser.length > index
                                  ? purchaseUser[index].userName!.getName()
                                  : '',
                              fontWeight: FontWeight.bold,
                              color: totalItems - purchaseUser.length == 0
                                  ? APPColors.appBlack
                                  : APPColors.appPrimaryColor,
                              fontSize: 9.sp,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          RabbleButton.tertiaryFilled(
            buttonSize: ButtonSize.large,
            bgColor: APPColors.appPrimaryColor,
            onPressed: () async {
              var link = await TeamViewCubit(teamId: '')
                  .generateDeepLinkForProducer(
                  ProducerDetail(
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
    );
  }
}
