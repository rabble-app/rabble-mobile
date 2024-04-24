import 'package:rabble/core/config/export.dart';

class BasketWidget extends StatelessWidget {
  final Function callBackExpanded;

  BasketWidget({Key? key, required this.callBackExpanded}) : super(key: key);

  final StreamController<bool> expandedController =
  StreamController<bool>.broadcast();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: expandedController.stream,
        initialData: false,
        builder: (context, snapshot) {
          return Container(
            padding: PagePadding.customHorizontalVerticalSymmetric(3.w, 1.2.h),
            decoration: BoxDecoration(
                color: APPColors.appWhite,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: RabbleText.subHeaderText(
                        text: 'GH',
                        color: APPColors.appPrimaryColor,
                      ),
                    ),

                    SizedBox(
                      width: 3.w,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RabbleText.subHeaderText(
                          text: kYourBasket,
                          fontWeight: FontWeight.w700,
                        ),
                        RabbleText.subHeaderText(
                          text: '3 items',
                        ),
                      ],
                    ),

                    Spacer(),

                    Container(
                      margin: PagePadding.onlyTop(0.5.h),
                      child: Row(
                        children: [
                          RabbleText.subHeaderText(
                            text: '£240.00',
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
                              color: APPColors.appIcons,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

                SizedBox(
                  height: 1.h,
                ),

                snapshot.data! ? Container(
                  height: 0.2,
                  color: APPColors.appTextGrey,
                ) : SizedBox.shrink(),

                snapshot.data!
                    ? Container(
                  height: 15.h,
                  decoration: ContainerDecoration.boxDecoration(
                      bg: APPColors.bgBasketItem,
                      border: Colors.transparent),
                  child: Column(
                    children:  [
                      const BasketItemWidget(
                        qty: '2',
                        title: kPName,
                        price: ' $k75',
                      ),
                      Container(
                        height: 0.2,
                        color: APPColors.appTextGrey,
                      ),
                      const BasketItemWidget(
                        qty: '2',
                        title: kPName,
                        price: ' $k75',
                      )
                    ],
                  ),
                )
                    : const SizedBox.shrink(),
              ],
            ),
          );
        });
  }
}
