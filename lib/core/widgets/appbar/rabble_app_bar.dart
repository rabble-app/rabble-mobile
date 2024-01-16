import 'package:rabble/config/export.dart';

class RabbleAppbar extends StatelessWidget {
  final String? title;
  final String? backTitle;
  final List<Widget>? action;
  final Color? backgroundColor;
  final bool? hideLeading;
  final double? leadingWidth;
  final double? topMargin;

  const RabbleAppbar({
    Key? key,
    this.title,
    this.backTitle,
    this.action,
    this.backgroundColor,
    this.hideLeading,
    this.leadingWidth,
    this.topMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: backgroundColor ?? APPColors.appWhite,
      backgroundColor: APPColors.appBlack,
      leading: hideLeading != null
          ? const SizedBox.shrink()
          : InkWell(
              onTap: () async {
                bool hasRoutesToPop = Navigator.canPop(context);
                if (hasRoutesToPop) {
                  NavigatorHelper().pop();
                } else {

                  String status = await RabbleStorage.getLoginStatus() ?? "0";

                  if (status == '1') {
                    NavigatorHelper().navigateAnClearAll('/home');
                  } else {
                    NavigatorHelper().navigateAnClearAll('/splash');
                  }
                }
              },
              child: Padding(
                padding: PagePadding.onlyLeft(
                  3.w,
                ),
                child: Row(
                  children: [
                    Assets.svgs.arrowLeft.svg(height: 3.h),
                    SizedBox(width: 1.w,),
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
      leadingWidth: leadingWidth ?? 40.w,
      title: title != null
          ? Container(
              margin: PagePadding.onlyTop(topMargin ?? 0),
              child: RabbleText.subHeaderText(
                text: title,
                color: APPColors.appPrimaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: cGosha,
                fontSize: 16.sp,
              ),
            )
          : const SizedBox.shrink(),
      centerTitle: true,
      actions: action ?? [],
    );
  }
}
