import 'package:rabble/core/config/export.dart';

class AuthNowWidget extends StatelessWidget {
  final String heading, subHeading;
  final Function callBack;
  const AuthNowWidget({Key? key, required this.heading, required this.subHeading,
    required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        callBack.call();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RabbleText.subHeaderText(
            text: heading,
            fontSize: 12.sp,
            fontFamily: cGosha,
            fontWeight: FontWeight.w700,
            color: APPColors.appBlack,
          ),
          RabbleText.subHeaderText(
            text: subHeading,
            fontSize: 12.sp,
            fontFamily: cGosha,
            fontWeight: FontWeight.w700,
            color: APPColors.appBlue,
          ),
        ],
      ),
    );
  }
}
