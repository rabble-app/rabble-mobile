import 'package:rabble/core/config/export.dart';

class RabbleAppbar extends StatelessWidget {
  final String? title;
  final String? backTitle;
  final List<Widget>? action;
  final Color? backgroundColor;
  final bool? hideLeading;
  final bool? centerTitle;
  final Widget? titleWidget;
  final Widget? leading;
  final double? leadingWidth;
  final double? topMargin;
  final bool canGoBack;

  const RabbleAppbar({
    Key? key,
    this.title,
    this.backTitle,
    this.centerTitle,
    this.titleWidget,
    this.action,
    this.backgroundColor,
    this.hideLeading,
    this.leadingWidth,
    this.topMargin,
    this.leading, this.canGoBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: backgroundColor ?? APPColors.appWhite,
      backgroundColor: APPColors.appBlack,
      leading: hideLeading != null
          ? const SizedBox.shrink()
          : leading ??
              InkWell(
                onTap: !canGoBack? null : () async {
                  bool hasRoutesToPop = Navigator.canPop(context);
                  if (hasRoutesToPop) {
                    NavigatorHelper().pop();
                  } else {
                    NavigatorHelper().navigateAnClearAll('/home');
                  }
                },
                child: Padding(
                  padding: PagePadding.onlyLeft(
                    3.w,
                  ),
                  child: Row(
                    children: [
                      Assets.svgs.arrowLeft.svg(height: 3.h),
                      SizedBox(
                        width: 1.w,
                      ),
                      RabbleText.subHeaderText(
                        text: backTitle ?? kBack,
                        color: APPColors.appPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ),
              ),
      leadingWidth: leadingWidth ?? 35.w,
      title: title != null
          ? titleWidget ??
              Container(
                margin: PagePadding.onlyTop(topMargin ?? 0),
                child: RabbleText.subHeaderText(
                  text: title,
                  maxLines: 2,
                  height: 1,
                  overflow: TextOverflow.ellipsis,
                  color: APPColors.appPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: cGosha,
                  fontSize: 16.sp,
                ),
              )
          : const SizedBox.shrink(),
      centerTitle: centerTitle ?? true,
      actions: action ?? [],
    );
  }
}
