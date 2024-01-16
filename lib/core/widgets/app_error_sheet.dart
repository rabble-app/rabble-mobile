import '../../../config/export.dart';

class AppErrorSheet extends StatelessWidget {
  final VoidCallback callBackTryAgain;
  final VoidCallback? callBackClose;

  const AppErrorSheet({super.key, required this.callBackTryAgain, this.callBackClose});

  @override
  Widget build(BuildContext context) {
    return ToucheDetector(child: quite(context));
  }

  Widget quite(BuildContext context) {
    return Container(
      color: APPColors.bgColor,
      padding: PagePadding.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          InkWell(
            onTap: () {
              callBackClose!.call();
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
          Center(child: Assets.svgs.error_500.svg(height: 20.h)),
          RabbleText.subHeaderText(
            text: 'Oops!',
            fontSize: 15.sp,
            height: 1.7,
            fontFamily: cPoppins,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w700,
            color: APPColors.appTextPrimary,
          ),

          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text:
                        'Looks like our app encountered a temporary issue. We\'re on it and will have things up and running soon. Thanks for your patience!',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: cPoppins,
                      fontWeight: FontWeight.w400,
                      color: APPColors.appTextPrimary,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          SizedBox(
            height: context.allHeight * 0.08,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RabbleButton.tertiaryFilled(
                buttonSize: ButtonSize.large,
                bgColor: APPColors.appPrimaryColor,
                onPressed: () {
                  NavigatorHelper().pop();
                  callBackTryAgain();
                },
                child: RabbleText.subHeaderText(
                  text: kTryAgain,
                  fontSize: 13.sp,
                  fontFamily: cGosha,
                  color: APPColors.appBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                PostalCodeService().isSheetOpenGlobalSubject.sink.add(false);
                String status = await RabbleStorage.getLoginStatus() ?? "0";
                String onBoardStatus =
                    await RabbleStorage.getOnBoardStatus() ?? '0';

                if (onBoardStatus == '0') {
                  NavigatorHelper().navigateAnClearAll('/onboard');
                } else {
                  if (status == '0') {
                    NavigatorHelper().navigateAnClearAll('/login');
                  } else {
                    NavigatorHelper().navigateAnClearAll('/home');
                  }
                }
              },
              child: RabbleText.subHeaderText(
                text: 'Take me back to home',
                fontSize: 13.sp,
                fontFamily: cGosha,
                fontWeight: FontWeight.w700,
                color: APPColors.appBlack,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
