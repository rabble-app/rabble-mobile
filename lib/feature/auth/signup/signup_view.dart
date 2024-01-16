import 'package:rabble/config/export.dart';

class SignUpView extends StatelessWidget {
   SignUpView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.bgColor,

      body: ToucheDetector(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Column(
                children: [
                  const AuthUpperWidget(
                    heading: kSignUp,
                    subHeading: kLoginHint,
                    steps: 'Step 1/2',
                  ),
                  AuthWidget(
                    type: '1',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.12,
                  ),

                ],
              ),
              SizedBox(height: 5.h,),
              AuthNowWidget(
                  heading: kAlreadyMember,
                  subHeading: kLogin,
                  callBack: () {
                    NavigatorHelper().navigateTo('/login');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
