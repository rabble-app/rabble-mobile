import 'package:rabble/config/export.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23.w,
      height: 5.5.h,
      margin: PagePadding.onlyRight(5.w),
      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.bg_grey6,
          border: APPColors.bg_grey6,
          radius: 28,
          width: 1),
      child: Center(
        child: RabbleText.subHeaderText(
          text: kAdd,
          color: APPColors.appBlue,
          fontWeight: FontWeight.bold,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
