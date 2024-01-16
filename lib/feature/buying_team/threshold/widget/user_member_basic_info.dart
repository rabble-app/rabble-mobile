import 'package:rabble/config/export.dart';

class UserMemberCustomInfo extends StatelessWidget {
  const UserMemberCustomInfo({Key? key, required this.text, required this.icon,  this.textColor,}) : super(key: key);

  final Widget icon;
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        icon,
        SizedBox(
          width: 1.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RabbleText.subHeaderText(
              text: text,
              fontSize: 9.sp,
              fontFamily: 'Poppins',
              color: textColor ?? APPColors.bg_grey11,
            ),
          ],
        ),
      ],
    );
  }
}
