import 'package:rabble/core/config/export.dart';

class RequestSubscriberView extends StatelessWidget {
  const RequestSubscriberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.appWhite,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(9.h),
          child:  RabbleAppbar(
            backgroundColor: APPColors.bg_app_primary,
            title: kGroup,
            leadingWidth: 20.w,
          )),
      body: SafeArea(
        child: Padding(
          padding: PagePadding.horizontalSymmetric(5.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
                RabbleText.subHeaderText(
                  text: kpeopleinthisgroup,
                  color: APPColors.bg_grey9,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
                const SubscriberWidget(showRequst: true,),
                SizedBox(height: 4.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
