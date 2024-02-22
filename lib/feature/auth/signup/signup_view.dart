import 'package:rabble/config/export.dart';

class SignUpView extends StatelessWidget {
   SignUpView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.bgColor,

      body: ToucheDetector(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Column(
                      children: [
                        AuthUpperWidget(
                          heading: kSignUp,
                          subHeading: kSignUpHint,
                          image: Assets.png.singupImage.png(),
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


                  ],
                ),
              ),
            ),
            AuthNowWidget(
                heading: kAlreadyMember,
                subHeading: kLogin,
                callBack: () {
                  NavigatorHelper().navigateTo('/login');
                }),
            SizedBox(height: 4.h,)

          ],
        ),
      ),
    );
  }
}
