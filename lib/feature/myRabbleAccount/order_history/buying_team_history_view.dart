import 'package:rabble/config/export.dart';

class BuyingTeamOrderHistoryView extends StatelessWidget {
  const BuyingTeamOrderHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderHistoryData data =
        ModalRoute.of(context)!.settings.arguments as OrderHistoryData;
    List<Basket> historyData = data.order!.basket!;
    return Scaffold(
      backgroundColor: APPColors.bg_app_primary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(9.h),
          child: RabbleAppbar(
            backTitle: kBack,
            title: kOrderHistory,
            leadingWidth: 40.w,
          )),
      body: SafeArea(
        child: Padding(
          padding: PagePadding.horizontalSymmetric(4.w),
          child: Container(
            padding: PagePadding.onlyTop(context.allHeight * 0.02),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: historyData.length,
              itemBuilder: (context, i) {
                Basket orderObject = historyData[i];
                return BuyingTeamCardView(
                  amount: DateFormatUtil.amountFormatter(double.parse( getTotalAmount(historyData))),
                  date: DateFormatUtil.formatDate(
                      orderObject.createdAt!, 'dd MMM yyyy'),
                  deliveryFee: sDeliveryAmount,
                  orderItems: data.order!.team!.name!,
                  orderNumber: data.order!.team!.postalCode!,
                  subTotal: DateFormatUtil.amountFormatter(double.parse( getTotalAmount(historyData))),
                  orderQty: orderObject.quantity.toString(),
                  basket:historyData
                );
              },
              separatorBuilder: (context, i) =>
                  Container(margin: PagePadding.onlyTop(1.h)),
            ),
          ),
        ),
      ),
    );
  }

  String getTotalAmount(List<Basket>? orders) {
    return orders!.fold(
        '0',
        (previousValue, element) => (int.parse(previousValue) +
                int.parse(element.price.toString()))
            .toString());
  }
}
