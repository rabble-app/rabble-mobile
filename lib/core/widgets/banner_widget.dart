import 'package:rabble/core/config/export.dart';

class BannerWidget extends StatelessWidget {
  final bool isDecoration;
  final double? width, height;
  final String? url;
  final bool? svg;

  const BannerWidget(
      {Key? key,
      required this.isDecoration,
      this.width,
      this.height,
      this.url,
      this.svg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 100.w,
      height: isDecoration ? height ?? 28.h : 52.h,
      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.bg_grey,
          border: APPColors.bg_grey,
          radius: isDecoration ? 11 : 0),
      child: Center(
        child: url == null
            ? svg != null
                ? Assets.png.teamhost.png()
                : Assets.svgs.placeHolder.svg(width: 18.w, height: context.allHeight*0.2)
            : Image.network(url!, width: 18.w, height: 9.h),
      ),
    );
  }
}
