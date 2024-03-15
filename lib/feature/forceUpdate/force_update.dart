import 'package:rabble/config/export.dart';

class ForceUpdate extends StatelessWidget {
  const ForceUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (_, orientation, device) {
      return RabbleTheme(
          data: RabbleTheme.themeData,
          child: Scaffold(
            backgroundColor: APPColors.appBlack,
            body: FocusChild(
              child: Container(
                color: APPColors.appBlack,
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Colors.white,
                              Color(0xff000000).withOpacity(0.7)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds);
                        },
                        child: Assets.png.loginImage.png()),
                    SizedBox(height: 10.h,),
                    Center(
                      child: RabbleText.subHeaderText(
                        text: 'RABBLE',
                        fontSize: 62.sp,
                        fontWeight: FontWeight.bold,
                        color: APPColors.appPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: EdgeInsets.only(left: 3.h, right: 3.h),
                      child: RabbleText.subHeaderText(
                        text: sUpdateMsg,
                        fontSize: 12.sp,
                        height: 1.7,
                        fontFamily: cPoppins,
                        fontWeight: FontWeight.w400,
                        color: APPColors.appPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                )),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: PagePadding.customHorizontalVerticalSymmetric(4.w, 6.w),
              child: GestureDetector(
                onTap: () {
                  _launchUrl();
                },
                child: SizedBox(
                  width: 70.w,
                  child: RabbleButton.primaryFilled(
                    child: RabbleText.subHeaderText(
                      text: 'Update',
                      fontSize: 17.sp,
                      fontFamily: cGosha,
                      color: APPColors.appBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }

  Future<void> _launchUrl() async {
    var url = Platform.isAndroid
        ? 'https://play.google.com/store/apps/details?id=com.rabble.rabble'
        : 'https://apps.apple.com/app/rabble/id6450045487';
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw 'Could not launch $url';
    }
  }
}
