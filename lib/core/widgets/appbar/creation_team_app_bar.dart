import 'package:rabble/config/export.dart';

class CreationTeamAppbar extends StatelessWidget {
  final String? title;
  final double? barPercentage;
  final String? backTitle;
  final List<Widget>? action;
  final Color? backgroundColor;
  final bool? hideLeading;
  final double? leadingWidth;
  final Widget? icon;
  final String? backRoute;

  const CreationTeamAppbar({
    Key? key,
    this.title,
    this.backTitle,
    this.barPercentage,
    this.icon,
    this.action,
    this.backgroundColor,
    this.backRoute,
    this.hideLeading,
    this.leadingWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: APPColors.appBlack,
      height: title == null
          ? context.allHeight * 0.15
          : barPercentage == null
              ? context.allHeight * 0.18
              : context.allHeight * 0.2,
      padding: PagePadding.onlyTop(6.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  if (backRoute == null) {
                    //   BuyingTeamCreationService().reset();
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Assets.svgs.arrowLeft.svg(height: 2.5.h),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      RabbleText.subHeaderText(
                        text: backTitle ?? kBack,
                        color: APPColors.appPrimaryColor,
                        fontFamily: cGosha,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              if (action != null && action!.isNotEmpty) ...action!.map((e) => e)
            ],
          ),
          if (title != null)
            Center(
              child: Container(
                margin: PagePadding.onlyTop(6.w),
                child: RabbleText.subHeaderText(
                  text: title,
                  maxLines: 2,
                  color: APPColors.appPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          if (barPercentage != null)
            Expanded(
                child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: PagePadding.onlyTop(1.w),
                width: barPercentage! == 6
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width / 6 * barPercentage!,
                height: 1.h,
                decoration: BoxDecoration(
                    color: APPColors.appPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: barPercentage! == 6
                          ? const Radius.circular(0)
                          : const Radius.circular(8),
                      bottomRight: barPercentage! == 6
                          ? const Radius.circular(0)
                          : Radius.circular(8),
                    )),
              ),
            ))
        ],
      ),
    );
  }
}
