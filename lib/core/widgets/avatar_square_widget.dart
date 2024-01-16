import 'package:rabble/config/export.dart';

class SquareAvatarWidget extends StatelessWidget {
  final double? width, height, radius;
  final Color? backgroundColor;
  final String? url;

  const SquareAvatarWidget(
      {Key? key,
        this.width,
        this.height,
        this.radius,
        this.backgroundColor,
        this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const PagePadding.customHorizontalVerticalSymmetric(9,14),
      decoration: BoxDecoration(
        color: backgroundColor ?? APPColors.appLightGrey,
          borderRadius: BorderRadius.circular(radius ?? 2.w),
      ),
      child: url == null
          ? Assets.svgs.placeHolder
          .svg(width: width ?? 8.w, height: height ?? 4.5.h)
          : Image.network(url!, width: width ?? 8.w, height: height ?? 4.5.h),
    );
  }
}
