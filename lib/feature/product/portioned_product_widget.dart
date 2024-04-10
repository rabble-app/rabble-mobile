import 'package:dots_indicator/dots_indicator.dart';
import 'package:rabble/feature/product/portioned_product_list_widget.dart';
import 'package:rabble/feature/share/share_shared_info__view.dart';

import '../../core/config/export.dart';
import '../../domain/entities/PartionedProductsData.dart';

class PortionedProductWidget extends StatelessWidget {
  PortionedProductWidget({
    Key? key,
    required this.heading,
    required this.subHeading,
    required this.items,
    required this.purchaseUser,
    required this.orderUnit,
    required this.subUnit,
    required this.teamData,
  }) : super(key: key);

  final String heading, subHeading;
  final List<PartionedProducts> items;
  final List<List<TempBoxData>> purchaseUser;
  final String orderUnit, subUnit;
  final TeamData teamData;

  final StreamController<double> dynamicHeightController =
      StreamController<double>();

  final StreamController<int> currentPageController = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(3.w, 1.h),
      margin: PagePadding.onlyBottom(1.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: APPColors.greyText.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              InkWell(
                  onTap: () {
                    CustomBottomSheet.showShareInfoModelSheet(
                        context,
                        SharedInfoView(
                          orderUnit: orderUnit,
                          subUnit: subUnit,
                        ),
                        true,
                        isRemove: true);
                  },
                  child: Assets.svgs.info.svg())
            ],
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
          items.length > 3
              ? StreamBuilder<double>(
                  stream: dynamicHeightController.stream,
                  initialData: context.allHeight * 0.28,
                  builder: (context, snapshot) {
                    return SizedBox(
                      height: snapshot.data!,
                      width: 100.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: PageView.builder(
                                onPageChanged: (index) {
                                  dynamicHeightController
                                      .add(context.allHeight * 0.28);
                                  currentPageController.add(index);
                                },
                                itemCount: getSize(items.length),
                                itemBuilder: (context, pageIndex) {
                                  final startIndex = pageIndex * 3;
                                  final endIndex = startIndex + 3;
                                  final displayedItems = items.sublist(
                                      startIndex,
                                      endIndex < items.length
                                          ? endIndex
                                          : items.length);

                                  return Container(
                                    margin: PagePadding.onlyRight(1.w),
                                    child: ListView.builder(
                                        itemCount: displayedItems.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final itemIndex = startIndex +
                                              index; // Calculate the index in the original list

                                          PartionedProducts item =
                                              items[itemIndex];
                                          return PortionedProductListWidget(
                                            expendedCallBack: (bool status) {
                                              if (status) {
                                                dynamicHeightController.add(
                                                    context.allHeight * 0.38);
                                              } else {
                                                dynamicHeightController.add(
                                                    context.allHeight * 0.28);
                                              }
                                            },
                                            teamData: teamData,
                                            totalItems: item.threshold!.toInt(),
                                            partionedProductsList: items,
                                            index: itemIndex,
                                            purchaseUser:
                                                purchaseUser[itemIndex],
                                          );
                                        }),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          StreamBuilder<int>(
                              stream: currentPageController.stream,
                              initialData: 0,
                              builder: (context, snapshot) {
                                return DotsIndicator(
                                  dotsCount: getSize(items.length),
                                  position: snapshot.data!,
                                  decorator: DotsDecorator(
                                    size: Size(0.7.h, 0.7.h),
                                    activeSize: Size(0.7.h, 0.7.h),
                                    spacing: EdgeInsets.only(right: 1.w),
                                    color: APPColors.bg_grey25,
                                    activeColor: APPColors.appTextPrimary,
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 1.h,
                          ),
                        ],
                      ),
                    );
                  })
              : ListView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    PartionedProducts item = items[index];
                    return PortionedProductListWidget(
                      teamData: teamData,
                      totalItems: item.threshold!.toInt(),
                      partionedProductsList: items,
                      index: index,
                      purchaseUser: purchaseUser[index],
                    );
                  })
        ],
      ),
    );
  }

  int getSize(int length) {
    return (length / 3).ceil();
  }
}
