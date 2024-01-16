import 'package:rabble/config/export.dart';

class DeliveryDetailWidget extends StatelessWidget {
  const DeliveryDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircularAvatarWidget(
              firstName: '',
              lastName: '',
              width: 6.w,
              height: 4.h,
              radius: 7.w,
            ),
            Container(
              width: 13.w,
              height: 3.2.h,
              transform: Matrix4.translationValues(0, -10, 0),
              decoration: ContainerDecoration.boxDecoration(
                bg: APPColors.appYellow,
                border: APPColors.appYellow,
                radius: 24,
              ),
              child: RabbleText.subHeaderText(
                text: kHost2,
                color: APPColors.appBlack,
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 2.w,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h,),
            RabbleText.subHeaderText(
              text: kHollyK,
              color: APPColors.appBlack,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
            SizedBox(height: 1.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Icon(
                Icons.person_outline,
                size: 20,
                color: APPColors.greyText,
              ),
                SizedBox(
                  width: 1.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RabbleText.subHeaderText(
                      text: sSinceJan,
                      fontSize: 12.sp,
                      fontFamily: 'Urbanist',
                      color: APPColors.bg_grey11,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 0.8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Assets.svgs.truck.svg(width: 5.w,height: 2.5.h),
                SizedBox(
                  width: 1.w,
                ),
                RabbleText.subHeaderText(
                  text: sDelivers800mAway,
                  fontSize: 12.sp,
                  fontFamily: 'Urbanist',
                  color: APPColors.bg_grey11,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
