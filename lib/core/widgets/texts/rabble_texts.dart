import 'package:rabble/config/export.dart';

class RabbleText extends Text {
  RabbleText.headerText({
    super.key,
    String? text,
    double? fontSize,
    TextAlign? textAlign,
    String? fontFamily,
    Color? color,
    double? letterSpacing,
    double? wordSpacing,
    int? maxLines,
    FontWeight? fontWeight,
  }) : super(text!,
            textAlign: textAlign ?? TextAlign.center,
            maxLines: maxLines ?? 5,
            style: RabbleTheme.themeData.textTheme.displayLarge.copyWith(
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              color: color,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontFamily: fontFamily ?? cGosha,
            ));

  RabbleText.subHeaderText({
    super.key,
    String? text,
    String? fontFamily,
    int? maxLines,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? overflow,
    double? letterSpacing,
    double? height,
    double? wordSpacing,
    TextDecoration? textDecoration,
  }) : super(text!,
            maxLines: maxLines,
            textAlign: textAlign ?? TextAlign.center,
            overflow: overflow ?? TextOverflow.visible,
            style: RabbleTheme.themeData.textTheme.labelSmall.copyWith(
                color: color ?? const Color(0xff000000),
                fontSize: fontSize ?? 14,
                fontFamily: fontFamily ?? 'Gosha',
                fontWeight: fontWeight ?? FontWeight.normal,
                height: height ?? 0,
                letterSpacing: letterSpacing,
                wordSpacing: wordSpacing,
                decorationThickness: 1.5,
                decorationColor: color,
                decoration: textDecoration));
}
