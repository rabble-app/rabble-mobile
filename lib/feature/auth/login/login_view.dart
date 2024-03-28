import 'package:rabble/core/config/export.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.bgColor,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: ToucheDetector(
        child: Column(
          children: [

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    AuthUpperWidget(
                      heading: kLoginToRabble,
                      subHeading: kLoginHint,
                      image: Assets.png.loginImage.png(),
                    ),
                    AuthWidget(
                      type: '0',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ],
                ),
              ),
            ),
            AuthNowWidget(
                heading: kNewToRabble,
                subHeading: kRegisterNow,
                callBack: () {
                  NavigatorHelper().navigateTo('/signup_view');
                }),
            SizedBox(height: 4.h,)
          ],
        ),
      ),
    );
  }
}
