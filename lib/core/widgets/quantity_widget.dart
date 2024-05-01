import 'package:rabble/core/config/export.dart';
import 'package:rabble/feature/auth/login/login_modal_view.dart';

class QuantityWidget extends StatelessWidget {
  final String qty;
  final Function qtyCallBack;
  final Function removeProduct;

  const QuantityWidget(
      {Key? key,
      required this.qty,
      required this.qtyCallBack,
      required this.removeProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23.w,
      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.appBlack,
          border: APPColors.appBlack,
          width: 1,
          radius: 30),
      child: Padding(
        padding: PagePadding.custom(2.w, 2.w, 0.5.w, 0.5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            int.parse(qty) == 1
                ? InkWell(
                    onTap: () async {
                      String status =
                          await RabbleStorage().getLoginStatus() ?? "0";
                      if (status != '0') {
                        String postalCode = await RabbleStorage().getPostalCode();

                        if (postalCode.isEmpty) {
                          NavigatorHelper().navigateTo('/add_postal_code_view');
                        } else {
                          removeProduct.call();
                        }
                      } else {
                        CustomBottomSheet.showLoginViewModelSheet(
                            context, LoginModalView(), true,
                            isRemove: true);
                      }
                    },
                    child: Assets.svgs.trash.svg(width: 3.w, height: 2.h))
                : InkWell(
                    onTap: () async {
                      String status =
                          await RabbleStorage().getLoginStatus() ?? "0";
                      if (status != '0') {
                        String postalCode = await RabbleStorage().getPostalCode();

                        if (postalCode.isEmpty) {
                          NavigatorHelper().navigateTo('/add_postal_code_view');
                        } else {
                          if (int.parse(qty) != 1) {
                            int quantity = int.parse(qty);
                            quantity--;
                            qtyCallBack.call(quantity);
                          }
                        }
                      } else {
                        CustomBottomSheet.showLoginViewModelSheet(
                            context, LoginModalView(), true,
                            isRemove: true);
                      }
                    },
                    child: Icon(
                      Icons.remove_outlined,
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
              onTap: () async {
                String status = await RabbleStorage().getLoginStatus() ?? "0";
                if (status != '0') {
                  String postalCode = await RabbleStorage().getPostalCode();

                  if (postalCode.isEmpty) {
                    NavigatorHelper().navigateTo('/add_postal_code_view');
                  } else {
                    int quantity = int.parse(qty);
                    quantity++;
                    qtyCallBack.call(quantity);
                  }
                } else {
                  CustomBottomSheet.showLoginViewModelSheet(
                      context, LoginModalView(), true,
                      isRemove: true);
                }
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
