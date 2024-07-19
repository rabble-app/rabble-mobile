import 'package:rabble/core/config/export.dart';

class AllPartnersTeamsView extends StatelessWidget {
  const AllPartnersTeamsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.bg_app_primary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(8.h),
          child: RabbleAppbar(
            leadingWidth: 25.w,
            title: kRabbleHubs,
          )),
      body: Padding(
        padding: PagePadding.custom(2.w, 0, 0, 0),
        child: const HubListWidget(
          isHorizontal: false,
          showViewAll: false,
        ),
      ),
    );
  }
}
