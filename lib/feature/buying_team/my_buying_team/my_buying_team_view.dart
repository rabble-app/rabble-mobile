import 'package:rabble/core/config/export.dart';

class MyBuyingTeamView extends StatelessWidget {
  const MyBuyingTeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.appWhite,
      appBar: AppBar(
        leading: const Empty(),
        backgroundColor: APPColors.bg_app_primary,
        actions: [
          PostCodeWidget(
            callBack: () {
              NavigatorHelper().navigateTo('/add_postal_code_view');

            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: PagePadding.custom(5.w, 5.w, 5.w, 0.w),
          color: APPColors.appWhite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
                ),
              //  const BuyingTeamWidget(isHorizontal: true,),
                SizedBox(
                  height: 7.h,
                ),
                RabbleText.subHeaderText(
                  text: kStartYourOwnTeam,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: APPColors.appBlack,
                ),
                SizedBox(
                  height: 7.h,
                ),
                Center(
                    child: Container(
                  height: 30.w,
                  width: 25.h,
                  color: APPColors.appWhite,
                  child: DashedRect(
                    color: APPColors.appYellow,
                    strokeWidth: 2.0,
                    gap: 8.0,
                    child: Container(
                      margin: PagePadding.all(4.w),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: APPColors.appBlack,
                            width: 4.0,
                          ),
                          color: APPColors.appYellow,
                          shape: BoxShape.circle),
                      width: 20.w,
                      height: 10.h,
                      child: const Icon(
                        Icons.add,
                        color: APPColors.appBlack,
                        size: 50,
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: RabbleText.subHeaderText(
                    text: kStartabuyingteam,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Urbanist',
                    color: APPColors.bg_grey3,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
