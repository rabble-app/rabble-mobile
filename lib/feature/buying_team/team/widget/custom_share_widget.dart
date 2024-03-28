import 'package:rabble/core/config/export.dart';

class CustomShareWidget extends StatelessWidget {
  const CustomShareWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color color = APPColors.appPrimaryColor;
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
         Assets.svgs.share.svg(),
          SizedBox(
            width: 1.w,
          ),
          RabbleText.subHeaderText(
            text: title,
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11.sp,
          ),
          SizedBox(
            width: 2.w,
          ),
        ],
      ),
    );
  }
}
