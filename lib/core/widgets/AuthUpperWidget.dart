import 'package:rabble/config/export.dart';

class AuthUpperWidget extends StatelessWidget {
  final String heading, subHeading;
  final String? steps;
  const AuthUpperWidget({Key? key, required this.heading, required this.subHeading, this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 30.h,
      padding: PagePadding.onlyTop(20),

      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.appBlack,
          border: APPColors.appBlack,
          radius: 0,
          width: 0),
      child: Stack(
        children: [
          Assets.svgs.Ellipse1.svg(height: 10.h),
          Assets.svgs.Ellipse2.svg(height: 17.h),
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
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                  fontFamily: 'Gosha',
                  fontSize: 22.sp,
                ),
                SizedBox(
                  height: 0.7.h,
                ),
                RabbleText.subHeaderText(
                  text: subHeading,
                  color: APPColors.appPrimaryColor1,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.start,
                  fontFamily: 'Poppin',
                  fontSize: 10.sp,
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
