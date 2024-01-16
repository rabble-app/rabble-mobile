import 'package:rabble/config/export.dart';

class CartBadgeWidget extends StatelessWidget {
  final Color? IconColor;
  final Function? callBack;

  const CartBadgeWidget({Key? key, this.IconColor, this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, CheckoutCubit>(
        create: (context) => CheckoutCubit()..fetchAllProducts(),
        builder: (context, state, bloc) {
          return InkWell(
            onTap: callBack != null
                ? () {
                    callBack!.call();
                  }
                : null,
            child: Padding(
              padding: PagePadding.custom(3, 3, 12.0, 12.0),
              child: Stack(
                children: [
                  Assets.svgs.cart.svg(width: 5.w, height: 2.5.h),
                  BehaviorSubjectBuilder<int>(
                      subject: globalBloc.cartItemQty,
                      builder: (context, snapshot) {
                        return snapshot.data == 0
                            ? const SizedBox.shrink()
                            : Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            transform: Matrix4.translationValues(5, -5, 0),
                            decoration: BoxDecoration(
                              color: APPColors.appPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center( // Added Center widget to ensure the text is in the center
                              child: RabbleText.subHeaderText(
                                text: '${snapshot.data ?? 0}',
                                fontSize: 8.sp,
                                height: 1.3, // Adjusted the height to its default value
                                color: APPColors.appBlack,
                                fontFamily: cPoppins,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );

                      }),
                ],
              ),
            ),
          );
        });
  }
}
