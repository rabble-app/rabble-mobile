import 'package:rabble/config/export.dart';

class SubscriberProfileView extends StatelessWidget {
  const SubscriberProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(10.h),
          child: const RabbleAppbar(
            title: khtl,
            backgroundColor: APPColors.bg_app_primary,
            backTitle: kSubscribers,
            action: [ShareWidget()],
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Center(
                child: CircularAvatarWidget(
                  firstName: '',
                  lastName: '',
                  width: 9.w,
                  height: 6.h,
                  radius: 12.w,
                ),
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
              SizedBox(
                height: 2.h,
              ),
              RabbleText.subHeaderText(
                text: kHollyK,
                color: APPColors.appBlack,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                  height: 4.5.h,
                  width: 30.w,
                  padding: PagePadding.verticalHorizontalSymmetric(2.5.w),
                  decoration: ContainerDecoration.boxDecoration(
                    bg: APPColors.bg_grey22,
                    border: APPColors.bg_grey22,
                    radius: 24,
                  ),
                  child: Center(
                    child: RabbleText.subHeaderText(
                      text: kFollow,
                      color: APPColors.appBlack,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(
                height: 3.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.supervisor_account_outlined,
                    color: APPColors.appBlue,
                    size: 28,
                  ),
                  RabbleText.subHeaderText(
                    text: k4Followers,
                    color: APPColors.appBlue,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  Container(
                      margin: PagePadding.custom(0,3.w,1.w,0),
                      child: Assets.svgs.vectorArrow.svg(width: 1.5.w, height: 1.2.h))
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: PagePadding.custom(0.w, 4.w, 5.w,0.w),
                child: const ProductWidget(
                  isHorizontal: true,
                  showHeading: true,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
