import '../../../config/export.dart';

class RabbleCustomizedIconButton extends StatelessWidget {
  const RabbleCustomizedIconButton({Key? key, required this.onTap, required this.labelPrefix1, required this.labelPrefix2, required this.icon,}) : super(key: key);

  final String labelPrefix1;
  final String labelPrefix2;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: APPColors.appBlack,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            content(labelPrefix1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: icon,
            ),
            content(labelPrefix2),
          ],
        ),
      ),
    );
  }

  dynamic content(String text) {
    return RabbleText.subHeaderText(
      text: text,
      textAlign: TextAlign.center,
      color: APPColors.appWhite,
      letterSpacing: 0.5,
      fontSize: 12.sp,
    );
  }
}
