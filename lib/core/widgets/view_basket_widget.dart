import 'package:rabble/config/export.dart';

class ViewBasketWidget extends StatelessWidget {
  const ViewBasketWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.25,
      height: MediaQuery.of(context).size.height*0.045,
      margin: PagePadding.onlyRight(5.w),
      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.bg_grey6,
          border: APPColors.bg_grey6,
          radius: 28,
          width: 1),
      child: Center(
        child: RabbleText.subHeaderText(
          text: kYourBasket,
          color: APPColors.appBlue,
          fontWeight: FontWeight.bold,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
