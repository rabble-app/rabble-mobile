import '../../../config/export.dart';

class RemoveMyAccount extends StatelessWidget {
  final VoidCallback callBackDelete;
  const RemoveMyAccount({super.key, required this.callBackDelete});

  @override
  Widget build(BuildContext context) {
    return ToucheDetector(
      child: Container(
        color: APPColors.bg_app_primary,
        padding: PagePadding.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 1.h,
            ),
            InkWell(
              onTap: () {
                NavigatorHelper().pop();
              },
              child: Container(
                alignment: Alignment.centerLeft,
                width: 9.w,
                height: 6.h,
                child: const CircleAvatar(
                  backgroundColor: APPColors.appTextPrimary,
                  child: Icon(
                    Icons.close,
                    color: APPColors.appWhite,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            RabbleText.subHeaderText(
              text: kPleaseDontLeaveUs,
              fontSize: 15.sp,
              height: 1.4,
              fontFamily: cGosha,
              fontWeight: FontWeight.bold,
              color: APPColors.appBlack4,
            ),
            SizedBox(
              height: 1.h,
            ),
            RabbleText.subHeaderText(
              text: kDeleteDetail,
              fontSize: 11.sp,
              height: 1.7,
              fontFamily: cPoppins,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.normal,
              color: APPColors.appTextPrimary,
            ),
            SizedBox(
              height: 3.h,
            ),
            RabbleButton.tertiaryFilled(
              buttonSize: ButtonSize.large,
              bgColor: APPColors.appRedLight,
              onPressed: () {
                NavigatorHelper().pop();
                callBackDelete();
              },
              child: RabbleText.subHeaderText(
                text: kCloseAccount,
                fontSize: 13.sp,
                fontFamily: cGosha,
                color: APPColors.bgColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
          ],
        ),
      ),
    );
  }
}
