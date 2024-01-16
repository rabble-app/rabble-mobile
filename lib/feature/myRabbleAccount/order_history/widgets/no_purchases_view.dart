import 'package:rabble/config/export.dart';

class NoPurchasesView extends StatelessWidget {
  const NoPurchasesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(4.w, 3.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: APPColors.appWhite,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.png.bag.png(),
            SizedBox(
              height: 1.h,
            ),
            RabbleText.subHeaderText(
              text: kNoPurchases,
              color: APPColors.appBlack.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
