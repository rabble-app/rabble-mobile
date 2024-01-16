import 'package:rabble/config/export.dart';

class QuantityWidget extends StatelessWidget {
  final String qty;
  final Function qtyCallBack;
  final Function removeProduct;

  const QuantityWidget({Key? key, required this.qty, required this.qtyCallBack, required this.removeProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      margin: PagePadding.onlyBottom(1.w),
      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.appBlack,
          border: APPColors.appBlack,
          width: 1,
          radius: 30),
      child: Padding(
        padding: PagePadding.custom(2.w, 2.w, 1.5.w, 1.5.w),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            int.parse(qty) == 1
                ? InkWell(
                    onTap: () {
                      removeProduct.call();
                    },
                    child: Assets.svgs.trash.svg(width: 4.w, height: 2.5.h))
                : InkWell(
                    onTap: () {
                      if (int.parse(qty) != 1) {
                        int quantity = int.parse(qty);
                        quantity--;
                        qtyCallBack.call(quantity);
                      }
                    },
                    child: Icon(
                      Icons.remove,
                      color: APPColors.appPrimaryColor,
                    ),
                  ),
            RabbleText.subHeaderText(
              text: qty,
              fontSize: 13.sp,
              fontFamily: cGosha,
              color: APPColors.appPrimaryColor2,
              fontWeight: FontWeight.bold,
            ),
            InkWell(
              onTap: () {
                int quantity = int.parse(qty);
                quantity++;
                qtyCallBack.call(quantity);
              },
              child: Icon(
                Icons.add_outlined,
                color: APPColors.appPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
