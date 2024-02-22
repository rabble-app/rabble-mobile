import 'package:rabble/config/export.dart';

class RabbleTextField extends TextField {
  RabbleTextField.borderLess(
      {super.key,
      String? hint,
      String? fontFamily,
      double? fontSize,
      TextAlign? textAlign,
      Color? color,
      Color? filledColor,
      Color? hintColor,
      double? hintFontSize,
      FocusNode? focusNode,
      Color? cursoeColor,
      FontWeight? fontWeight,
      double? letterSpacing,
        int? maxLine,
      TextEditingController? controller,
      ValueChanged<String>? onChange,
      ValueChanged<String>? onSubmitted,
      TextInputType? keyBoardType,
      TextCapitalization? textCapitalization})
      : super(
          textAlign: textAlign ?? TextAlign.center,
          style: RabbleTheme.themeData.textTheme.displayLarge.copyWith(
            fontSize: fontSize,
            fontFamily: fontFamily ?? "Urbanist",
            color: color,
            letterSpacing: letterSpacing ?? -1.5,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          cursorColor: cursoeColor ?? APPColors.appBlack,
          keyboardType: keyBoardType ?? TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: onChange,
          controller: controller,
          maxLines: maxLine ?? 1,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: filledColor ?? APPColors.appWhite,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: hint ?? kETH,
            hintStyle: RabbleTheme.themeData.textTheme.displayLarge.copyWith(
              fontSize: hintFontSize ?? 14.sp,
              fontFamily: fontFamily ?? 'Gosha',
              letterSpacing: letterSpacing ?? -1.5,
              fontWeight: fontWeight ?? FontWeight.normal,
              color: hintColor ?? APPColors.appTextGrey,
            ),
          ),
        );

  RabbleTextField.borderLess2(
      {super.key,
      String? hint,
      String? fontFamily,
      double? fontSize,
      TextAlign? textAlign,
      Color? color,
      Color? filledColor,
      Color? hintColor,
      double? hintFontSize,
      FocusNode? focusNode,
      Color? cursoeColor,
      int? maxLength,
      bool? autofocus,
      FontWeight? fontWeight,
      double? letterSpacing,
      TextEditingController? controller,
      ValueChanged<String>? onChange,
      TextInputType? keyBoardType,
      TextCapitalization? textCapitalization})
      : super(
          textAlign: textAlign ?? TextAlign.center,
          style: RabbleTheme.themeData.textTheme.displayLarge.copyWith(
            fontSize: fontSize,
            fontFamily: fontFamily ?? "Urbanist",
            color: color,
            letterSpacing: letterSpacing ?? -1.5,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          cursorColor: cursoeColor ?? APPColors.appBlack,
          keyboardType: keyBoardType ?? TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: onChange,
          autofocus: autofocus ?? false,
          controller: controller,
          maxLength: maxLength ?? 5000,
          focusNode: focusNode ?? FocusNode(),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: filledColor ?? APPColors.appWhite,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: hint ?? kETH,
            hintStyle: RabbleTheme.themeData.textTheme.displayLarge.copyWith(
              fontSize: hintFontSize ?? 14.sp,
              fontFamily: fontFamily ?? 'Gosha',
              letterSpacing: letterSpacing ?? -1.5,
              fontWeight: fontWeight ?? FontWeight.normal,
              color: hintColor ?? APPColors.appTextGrey,
            ),
          ),
        );

  RabbleTextField.border(
      {super.key,
      String? hint,
      String? fontFamily,
      double? fontSize,
      bool? enable,
      double? hintFontSize,
      double? verticalContent,
      double? horizontalContent,
      int? maxLines,
      TextAlign? textAlign,
      Color? color,
      Color? filledColor,
      Color? hintColor,
      Color? cursoeColor,
      Color? borderColor,
      FontWeight? fontWeight,
      double? letterSpacing,
      int? maxLength,
      bool? obscureText,
      TextEditingController? controller,
      List<TextInputFormatter>? formater,
      ValueChanged<String>? onChange,
      TextInputType? keyBoardType,
      TextCapitalization? textCapitalization})
      : super(
          textAlign: textAlign ?? TextAlign.center,
          style: RabbleTheme.themeData.textTheme.displayLarge.copyWith(
            fontSize: fontSize,
            fontFamily: fontFamily ?? "Urbanist",
            color: color,
            letterSpacing: letterSpacing ?? -1.5,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          onChanged: onChange,
          controller: controller,
          enabled: enable ?? true,
          cursorColor: cursoeColor ?? APPColors.appBlack,
          keyboardType: keyBoardType ?? TextInputType.text,
          maxLines: maxLines ?? 3,
          obscureText: obscureText ?? false,
          inputFormatters: formater ?? [],
          maxLength: maxLength ?? 5000,
          decoration: InputDecoration(
            filled: true,
            counterText: '',

            fillColor: filledColor ?? APPColors.appWhite,
            contentPadding: EdgeInsets.symmetric(
                vertical: verticalContent ?? 10.0,
                horizontal: horizontalContent ?? 15.0),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? APPColors.bg_grey12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? APPColors.bg_grey12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? APPColors.bg_grey12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: hint ?? kETH,
            hintStyle: RabbleTheme.themeData.textTheme.displayLarge.copyWith(
              fontSize: hintFontSize ?? 14.sp,
              fontFamily: fontFamily ?? 'Gosha',
              letterSpacing: letterSpacing ?? -1.5,
              fontWeight: fontWeight ?? FontWeight.normal,
              color: hintColor ?? APPColors.appTextGrey,
            ),
          ),
        );
}
