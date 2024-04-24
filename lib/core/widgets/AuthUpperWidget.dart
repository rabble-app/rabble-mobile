import 'package:rabble/config/export.dart';

class AuthUpperWidget extends StatelessWidget {
  final String heading, subHeading;
  final String? steps;
  final Image? image;
  const AuthUpperWidget({Key? key, required this.heading, required this.subHeading, this.steps, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 30.h,

      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.appBlack,
          border: APPColors.appBlack,
          radius: 0,
          width: 0),
      child: Stack(
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
              child: image),
            Positioned(
            bottom: -2,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.5.h,
                ),
                RabbleText.subHeaderText(
                  text: heading,
                  color: APPColors.appPrimaryColor,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                  fontFamily: cGosha,
                  fontSize: 25.sp,
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                RabbleText.subHeaderText(
                  text: subHeading,
                  color: APPColors.appPrimaryColor2,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                  fontFamily: cPoppins,
                  fontSize: 11.sp,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
              ],
            ),
          ),
       steps==null? const SizedBox.shrink():   Positioned(
            bottom: 50,
            right: 15,
            child: RabbleText.subHeaderText(
            text: steps,
            color: APPColors.appWhite,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
            fontFamily: cPoppins,
            fontSize: 10.sp,
          ),)
        ],
      ),
    );
  }
}
