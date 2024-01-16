import '../../../config/export.dart';

class QuiteTeam extends StatelessWidget {
  final String date;
  final VoidCallback callBackDelete;
  final String subheading, des;
  final bool showHeading;
  final bool isHost;
  final bool canLeave;

  const QuiteTeam(
      {super.key,
      required this.callBackDelete,
      required this.date,
      required this.subheading,
      required this.des,
      required this.showHeading,
      required this.isHost,
      required this.canLeave});

  @override
  Widget build(BuildContext context) {
    return ToucheDetector(
        child: canLeave ? quite(context) : upcomingCancellation(context));
  }

  Widget upcomingCancellation(BuildContext context) {
    return Container(
      color: APPColors.bgColor,
      padding: PagePadding.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          InkWell(
            onTap: () {
              NavigatorHelper().pop();
            },
            child: Container(
              alignment: Alignment.centerLeft,
              width: 9.w,
              height: 6.h,
              child: const CircleAvatar(
                backgroundColor: APPColors.appTextPrimary,
                child: Icon(
                  Icons.close,
                  color: APPColors.appWhite,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          RabbleText.subHeaderText(
            text: 'You have a shipment coming',
            fontSize: 15.sp,
            height: 1.4,
            fontFamily: cGosha,
            fontWeight: FontWeight.bold,
            color: APPColors.appBlack4,
          ),
          SizedBox(
            height: 1.h,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text:
                        ' You have a shipment on the way. You will be able to shut down your buying team once that delivery has been completed and before the next delivery is locked in.',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: cPoppins,
                      fontWeight: FontWeight.normal,
                      color: APPColors.appTextPrimary,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget quite(BuildContext context) {
    return Container(
      color: APPColors.bgColor,
      padding: PagePadding.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          InkWell(
            onTap: () {
              NavigatorHelper().pop();
            },
            child: Container(
              alignment: Alignment.centerLeft,
              width: 9.w,
              height: 6.h,
              child: const CircleAvatar(
                backgroundColor: APPColors.appTextPrimary,
                child: Icon(
                  Icons.close,
                  color: APPColors.appWhite,
                ),
              ),
            ),
          ),
          showHeading
              ? SizedBox(
                  height: 1.h,
                )
              : const SizedBox.shrink(),
          showHeading
              ? SizedBox(
                  height: 1.h,
                )
              : const SizedBox.shrink(),
          showHeading
              ? RabbleText.subHeaderText(
                  text: isHost
                      ? KQuiteTeam
                      : 'Are you sure you want to quit the team?',
                  fontSize: 15.sp,
                  height: 1.4,
                  fontFamily: cGosha,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.bold,
                  color: APPColors.appBlack4,
                )
              : const SizedBox.shrink(),
          !isHost
              ? SizedBox(
                  height: 2.h,
                )
              : const SizedBox.shrink(),
          showHeading
              ? RabbleText.subHeaderText(
                  text: isHost
                      ? subheading
                      : 'You will be removed from the team and unable to purchase direct from this supplier.',
                  fontSize: 11.sp,
                  height: 1.7,
                  fontFamily: cPoppins,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.normal,
                  color: APPColors.appTextPrimary,
                )
              : RabbleText.subHeaderText(
                  text: isHost
                      ? subheading
                      : 'You will be removed from the team and unable to purchase direct from this supplier.',
                  fontSize: 15.sp,
                  height: 1.4,
                  fontFamily: cGosha,
                  fontWeight: FontWeight.bold,
                  color: APPColors.appBlack4,
                ),
          SizedBox(
            height: 1.h,
          ),
          isHost
              ? Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: des,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: cPoppins,
                            fontWeight: FontWeight.normal,
                            color: APPColors.appTextPrimary,
                          )),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            height: isHost ? 1.h : 6.h,
          ),
          SizedBox(
            height: context.allHeight * 0.1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RabbleButton.tertiaryFilled(
                buttonSize: ButtonSize.large,
                bgColor: APPColors.appRedLight,
                onPressed: () {
                  NavigatorHelper().pop();
                  callBackDelete();
                },
                child: RabbleText.subHeaderText(
                  text: kQuitTeam,
                  fontSize: 13.sp,
                  fontFamily: cGosha,
                  color: APPColors.bgColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
