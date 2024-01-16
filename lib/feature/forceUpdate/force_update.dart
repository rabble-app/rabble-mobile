import 'package:rabble/config/export.dart';

class ForceUpdate extends StatelessWidget {
  const ForceUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (_, orientation, device) {
      return RabbleTheme(
          data: RabbleTheme.themeData,
          child: Scaffold(
              backgroundColor: APPColors.appWhite,
              body: FocusChild(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff202405),
                        Color(0xff000000),
                        Color(0xff202405),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RabbleText.subHeaderText(
                              text: 'RABBLE',
                              fontSize: 62.sp,
                              fontWeight: FontWeight.bold,
                              color: APPColors.appPrimaryColor,
                            ),
                            SizedBox(
                              height: 0.7.h,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              margin:  EdgeInsets.only(left: 3.h,right: 3.h),
                              child: RabbleText.subHeaderText(
                                text: sUpdateMsg,
                                fontSize: 12.sp,
                                height:1.7,
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
                            Padding(
                              padding: PagePadding.all(4.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _launchUrl();
                                    },
                                    child: SizedBox(
                                      width: 70.w,
                                      child: RabbleButton.primaryFilled(
                                        child: RabbleText.subHeaderText(
                                          text: 'Update',
                                          fontSize: 17.sp,
                                          fontFamily: 'Gosha',
                                          color: APPColors.appBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              )));
    });
  }



  Future<void> _launchUrl() async {
    var url = 'https://apps.apple.com/app/rabble/id6450045487';
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw 'Could not launch $url';
    }
  }
}
