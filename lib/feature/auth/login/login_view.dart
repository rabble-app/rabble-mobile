import 'package:rabble/config/export.dart';

class LoginView extends StatelessWidget {


  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: APPColors.bgColor,
      extendBodyBehindAppBar: true,
      body: ToucheDetector(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Column(
                children: [
                  AuthUpperWidget(
                    heading: kLoginToRabble,
                    subHeading: kLoginHint,
                  ),
                  AuthWidget(type: '0',),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.12,
                  ),

                ],
              ),
              SizedBox(height: 5.h,),

              AuthNowWidget(
                  heading: kNewToRabble,
                  subHeading: kRegisterNow,
                  callBack: () {
                    NavigatorHelper().navigateTo('/signup_view');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
