import 'package:flutter/gestures.dart';

import '../../../config/export.dart';

class TextRichCustom extends StatelessWidget {
  const TextRichCustom({
    Key? key,
    required this.labelPrefix1,
    required this.labelPrefix2,
    required this.labelPrefix3,
    required this.onTap1,
    required this.onTap2,
  }) : super(key: key);

  final String labelPrefix1, labelPrefix2, labelPrefix3;
  final VoidCallback onTap1, onTap2;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontSize: 9.sp,
        height: 1.3,
        color: APPColors.bg_grey9,
        fontWeight: FontWeight.w500,
        fontFamily: cPoppins,
        letterSpacing: 1);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: labelPrefix1,
            style: style,
          ),
          TextSpan(
            text: labelPrefix2,
            style: style.copyWith(color: APPColors.appBlue),
            recognizer: TapGestureRecognizer()..onTap = onTap1,
          ),
          TextSpan(
            text: ' and ',
            style: style,
          ),
          TextSpan(
            text: labelPrefix3,
            style: style.copyWith(color: APPColors.appBlue),
            recognizer: TapGestureRecognizer()..onTap = onTap2,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
