import 'package:rabble/config/export.dart';

class SubscriberItemWidget extends StatelessWidget {
  final bool showRequst;

  const SubscriberItemWidget({Key? key, required this.showRequst}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper().navigateTo('/team_host_view');

      },
      child: Container(
        margin: PagePadding.onlyTop(4.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                CircularAvatarWidget(
                  firstName: '',
                  lastName: '',
                  radius: 7.w,
                  width: 6.7.w,
                  height: 4.h,
                  backgroundColor: APPColors.bg_grey,
                ),
                SizedBox(width: 2.w,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 1.h,),
                    RabbleText.subHeaderText(
                      text: sTeamAbc,
                      fontWeight: FontWeight.bold,
                      color: APPColors.appBlack,
                      fontSize: 13.sp,
                    ),
                    RabbleText.subHeaderText(
                      text: s89subscribers,
                      color: APPColors.bg_grey11,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ],
                )
              ],
            ),
            showRequst?
            Container(
                height: 4.5.h,
                padding: PagePadding.verticalHorizontalSymmetric(2.5.w),
                decoration: ContainerDecoration.boxDecoration(
                  bg: APPColors.bg_grey22,
                  border: APPColors.appYellow,
                  radius: 24,
                ),
                child:Center(
                  child: RabbleText.subHeaderText(
                    text: kMember,
                    color: APPColors.appBlack,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ) :    Column(
              children: [
                SizedBox(height: 1.2.h,),
                RabbleText.subHeaderText(
                  text: kNearYou,
                  color: APPColors.bg_grey11,
                  fontWeight: FontWeight.bold,
                  fontSize: 9.sp,
                ),
                SizedBox(height: 0.7.h,),
               const JoinNowWidget()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
