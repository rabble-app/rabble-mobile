import 'package:rabble/core/config/export.dart';

class RabbleFormFields extends TextFormField {
  RabbleFormFields({
    super.key,
    this.textEditingController,
    this.hintText,
    this.isFilled,
    this.fillColor,
    this.borderColor,
    this.maxLines,
    this.maxLength,
    this.errorText,
    this.style,
    this.hintStyle,
    this.onTap,
    this.prefixIcon,
    this.onChange,
    this.suffixIcon,
    this.inputType,
    this.borderRadius,
    this.inputAction,
    this.obscureText = false,
    this.textAlign,
    this.autoFocus = false,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.readOnly = false,
  })  : assert(textEditingController != null, "Controller must not be null"),
        super(
          focusNode: focusNode,
          controller: textEditingController,
          maxLength: maxLength,
          readOnly: readOnly!,
          maxLines: obscureText ? 1 : maxLines,
          onTap: () => onTap,
          onChanged: (val) => onChange != null ? onChange.call(val) : {},
          keyboardType: inputType ?? TextInputType.text,
          inputFormatters: [
            LengthLimitingTextInputFormatter(500),
          ],
          textInputAction: inputAction ?? TextInputAction.done,
          obscureText: obscureText,
          decoration: InputDecoration(
              filled: isFilled ?? false,
              fillColor: fillColor,
              hintText: hintText,
              hintStyle: hintStyle ??
                  RabbleTheme.themeData.textTheme.headingMedium.copyWith(
                      color: APPColors.appBlack.withOpacity(0.9),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.normal),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? APPColors.appGrey),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? APPColors.appGrey),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: borderColor ?? APPColors.appPrimaryColor),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? APPColors.appGrey),
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              errorText: errorText,
              errorStyle: RabbleTheme.themeData.textTheme.labelMedium
                  .copyWith(color: Colors.red)),
          cursorColor: APPColors.appBlack,
          style: style ??
              RabbleTheme.themeData.textTheme.headingMedium.copyWith(
                  color: APPColors.appBlack, fontWeight: FontWeight.normal),
          textAlign: textAlign ?? TextAlign.left,
          autofocus: autoFocus!,
          onFieldSubmitted: onFieldSubmitted,
          onEditingComplete: onEditingComplete,
        );

  final TextEditingController? textEditingController;
  final String? hintText;
  final bool? isFilled;
  final Color? fillColor;
  final Color? borderColor;
  final int? maxLines, maxLength;
  final VoidCallback? onTap;
  final Function? onChange;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final TextInputType? inputType;
  final double? borderRadius;
  final TextInputAction? inputAction;
  final bool obscureText;
  final TextAlign? textAlign;
  final bool? autoFocus;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final bool? readOnly;
}
