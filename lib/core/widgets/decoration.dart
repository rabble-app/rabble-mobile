import 'package:rabble/core/config/export.dart';

class ContainerDecoration {
  static BoxDecoration boxDecoration(
      {Color? bg,
      Color? border,
      double? width = 1,
      double? radius,
      bool? showShadow}) {
    return radius != null && showShadow != null && showShadow
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: bg,
            border: Border.all(width: width!, color: border!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: const Offset(0, 3), // Offset in the x and y direction
              ),
            ],
          )
        : radius != null
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: bg,
                border: Border.all(width: width!, color: border!),
              )
            : BoxDecoration(
                color: bg,
                border: Border.all(width: width!, color: border!),
              );
  }

  static BoxDecoration sideRadiusDecoration(
      {Color? bg, Color? border, double? width = 1, double? radius}) {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      border: Border.all(
        color: APPColors.appGreen,
        width: 1.0,
      ),
    );
  }

  static BoxDecoration leftRightRadiusDecoration(
      {Color? bg, Color? border, double? width = 1, double? radius}) {
    return BoxDecoration(
      color: bg ?? APPColors.appWhite,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
    );
  }

  static BoxDecoration leftRightBottomRadiusDecoration(
      {Color? bg, Color? border, double? width = 1, double? radius}) {
    return BoxDecoration(
      color: bg ?? APPColors.appWhite,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
    );
  }

  static BoxDecoration sideBorderDecoration(
      {Color? bg, Color? border, double? width = 1, double? radius}) {
    return  BoxDecoration(
      border: Border(
        left: BorderSide(
          color: border ?? APPColors.appGreen,
          width: width?? 1.0,
        ),
        right: BorderSide(
          color:border ??  APPColors.appGreen,
          width:  width ??1.0,
        ),
        top: BorderSide(
          color:border ??  APPColors.appGreen,
          width:  width ??1.0,
        ),
      ),
    );
  }

  static BoxDecoration leftRightBorderDecoration(
      {Color? bg, Color? border, double? width = 1, double? radius}) {
    return const BoxDecoration(
      border: Border(
        left: BorderSide(
          color: APPColors.appGreen,
          width: 1.0,
        ),
        right: BorderSide(
          color: APPColors.appGreen,
          width: 1.0,
        ),
      ),
    );
  }

  static BoxDecoration greenDecoration() {
    return BoxDecoration(
      color: APPColors.appWhite,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      border: Border.all(
        color: APPColors.appWhite,
        width: 1,
      ),
    );
  }

  static BoxDecoration orangeDecoration() {
    return BoxDecoration(
      color: APPColors.appWhite,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(0),
        topLeft: Radius.circular(0),
        bottomRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
      border: Border.all(
        color: APPColors.appWhite,
        width: 1,
      ),
    );
  }

  static BoxDecoration gradientBackground({Color? color1, Color? color2}) {
    return BoxDecoration(
      gradient: LinearGradient(
          colors: [
            color1!,
            color2!,
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp),
    );
  }
}
