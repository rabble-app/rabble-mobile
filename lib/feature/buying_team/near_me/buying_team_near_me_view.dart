import 'package:rabble/core/config/export.dart';

class BuyingTeamNearYou extends StatelessWidget {
  const BuyingTeamNearYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.appWhite,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(9.h),
          child: const RabbleAppbar(
            backgroundColor: APPColors.bg_app_primary,
            title: kBlackLines,
            action: [ShareWidget()],
          )),
      body: SafeArea(
        child: Padding(
          padding: PagePadding.custom(4.w, 6.w, 5.w, 5.w),
          child: const BuyingTeamNearYouWidget(),
        ),
      ),
    );
  }
}
