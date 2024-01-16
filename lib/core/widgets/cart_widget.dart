import 'package:rabble/config/export.dart';

class CartWidget extends StatelessWidget {
  final CheckoutCubit checkoutCubit;

  const CartWidget({Key? key, required this.checkoutCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BehaviorSubjectBuilder<List<ProductDetail>>(
        subject: checkoutCubit.productList,
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                ProductDetail item = snapshot.data![index];
                return CartItemWidget(
                  isLast: snapshot.data!.length - 1 == index,
                  itemName: item.name!,
                  price: DateFormatUtil.amountFormatter(
                      double.parse(item.price.toString())),
                  producerName: item.producerName!,
                  productType: item.type!,
                  orderSubUnit: item.orderSubUnit,
                  unitsPerOrder: item.unitsPerOrder,
                  thresholdQty: item.thresholdQuantity!-item.qty!,
                  totalThresholdQty: item.totalThresholdQuantity!,
                  unitsOfMeasure: item.unitsOfMeasure,
                  orderUnit: item.orderUnit,
                  qtyCallBack: (qty) {
                    // if (item.type == 'PORTIONED_SINGLE_PRODUCT') {
                    //   int threshold = qty < item.qty!
                    //       ? item.thresholdQuantity! + 1
                    //       : item.thresholdQuantity! - 1;
                    //   checkoutCubit.updateThreshold(threshold, item.id);
                    // }
                    checkoutCubit.productQuantity(qty, item.id);
                  },
                  removeProduct: () async {
                    await checkoutCubit.removeProduct(item.id!);
                  },
                  qty: item.qty.toString(),
                );
              });
        });
  }
}
