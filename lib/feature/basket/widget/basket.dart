import 'package:rabble/core/config/export.dart';

class BasketWidget extends StatelessWidget {
  final Function callBackExpanded;
  final List<Basket>? basket;
  final String? name;
  final String? heading;
  final String image;
  final bool? showImage;
  final int? orderCount;

  BasketWidget(
      {Key? key,
      required this.callBackExpanded,
      this.basket,
      this.name,
      this.heading,
      required this.image,
      this.showImage,
      this.orderCount})
      : super(key: key);

  final StreamController<bool> expandedController =
      StreamController<bool>.broadcast();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: expandedController.stream,
        initialData: false,
        builder: (context, snapshot) {
          return Container(
            decoration: ContainerDecoration.greenDecoration(),
            margin: PagePadding.onlyBottom(2.w),
            child: Column(
              children: [
                SizedBox(
                  height: 2.w,
                ),
                Padding(
                  padding: PagePadding.horizontalSymmetric(2.w),
                  child: Row(
                    children: [
                      if (showImage != null && showImage!)
                        image.isEmpty
                            ? CircleAvatar(
                                backgroundColor: APPColors.appBlack,
                                child: RabbleText.subHeaderText(
                                  text: name?.initials,
                                  color: APPColors.appPrimaryColor,
                                ),
                              )
                            : SizedBox(
                                width: 40,
                                height: 40,
                                child: RabbleImageLoader(
                                  imageUrl: image ?? '',
                                  isRound: true,
                                  roundValue: 15,
                                ),
                              ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RabbleText.subHeaderText(
                            text: heading ?? (orderCount! > 1 ? kYB : KUO),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: cGosha,
                            color: APPColors.appBlack4,
                          ),
                          Padding(
                            padding: PagePadding.onlyLeft(2.w),
                            child: RabbleText.subHeaderText(
                              text:
                                  '${basket!.length.toString()} ${basket!.length <= 1 ? "item" : "items"}',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: cPoppins,
                              color: APPColors.appTextPrimary,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          RabbleText.subHeaderText(
                            text: calculateAmount(basket!).toString(),
                            fontSize: 12.sp,
                            fontFamily: cGosha,
                            fontWeight: FontWeight.bold,
                            color: APPColors.appTextPrimary,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          InkWell(
                            onTap: () {
                              callBackExpanded.call(snapshot.data!);
                              expandedController.sink.add(!snapshot.data!);
                            },
                            child: Icon(
                              snapshot.data!
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: APPColors.appBlue,
                              size: 30,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                snapshot.data!
                    ? Container(
                        height: 0.8,
                        color: APPColors.bg_grey25,
                      )
                    : const SizedBox.shrink(),
                snapshot.data!
                    ? Container(
                        margin: PagePadding.onlyRight(2.w),
                        padding: PagePadding.horizontalSymmetric(2.w),
                        child: Column(
                          children: [
                            ...basket!.asMap().entries.map((e) => Column(
                                  children: [
                                    BasketItemWidget(
                                      qty: e.value.quantity.toString(),
                                      title: e.value.product!.name!,
                                      price: e.value.price.toString(),
                                    ),
                                    e.key == basket!.length - 1
                                        ? SizedBox.shrink()
                                        : Container(
                                            height: 0.6,
                                            color: APPColors.bg_grey25,
                                          ),
                                  ],
                                ))
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          );
        });
  }

  String calculateAmount(List<Basket> list) {
    return DateFormatUtil.amountFormatter(list.fold(
        0,
        (previousValue, item) =>
            previousValue +
            double.parse(item.price.toString()) *
                double.parse(item.quantity.toString())));
  }
}
