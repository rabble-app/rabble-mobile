import 'package:rabble/config/export.dart';

class OrderCustomTextSpan extends StatelessWidget {
  const OrderCustomTextSpan({
    Key? key,
    required this.prefixLabel,
    required this.postFixLabel,
    this.shouldMakeBold = true,
    this.labelColor,
    this.postFixLabelColor,
  }) : super(key: key);

  final String prefixLabel, postFixLabel;
  final bool shouldMakeBold;
  final Color? labelColor;
  final Color? postFixLabelColor;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.normal,
      color: labelColor ?? APPColors.appTextPrimary,
      fontFamily: cPoppins,
    );

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: prefixLabel,
            style: style,
          ),
          TextSpan(
            text: postFixLabel,
            style: style,
          ),
        ],
      ),
    );
  }
}
