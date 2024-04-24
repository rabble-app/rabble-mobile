import 'package:rabble/config/export.dart';

class LoginModalView extends StatelessWidget {


  LoginModalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: APPColors.bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(
            height: 1.h,
          ),

          Padding(
            padding: PagePadding.onlyLeft(3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 1.h,),
                InkWell(
                  onTap: () {
                    NavigatorHelper().pop();
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 4.h,
                    height: 4.h,
                    child: const CircleAvatar(
                      backgroundColor: APPColors.appTextPrimary,
                      child: Icon(
                        Icons.close,
                        color: APPColors.appWhite,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.h,),

                RabbleText.subHeaderText(
                  text: 'Let’s get you sign in!',
                  fontSize: 24.sp,
                  fontFamily: cGosha,
                  wordSpacing: 0,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w700,
                  color: APPColors.appBlack4,
                ),
                SizedBox(height: 1.h,),

                RabbleText.subHeaderText(
                  text: 'Get a connection code for your number on Rabble.',
                  fontSize: 9.sp,
                  fontFamily: cPoppins,
                  wordSpacing: 0,
                  letterSpacing: 0,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  color: APPColors.bg_grey27,
                ),
              ],
            ),
          ),
          AuthWidget(type: '0',),

        ],
      ),
    );
  }
}
