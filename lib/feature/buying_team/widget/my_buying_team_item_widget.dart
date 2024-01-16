import 'package:rabble/config/export.dart';

class MyBuyingTeamItemWidget extends StatelessWidget {
  final BuyingTeamDetail? buyingTeamDetail;

  const MyBuyingTeamItemWidget({Key? key, this.buyingTeamDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 87.w,
      child: InkWell(
        onTap: () {
          Map map = {
            'teamId': buyingTeamDetail!.id,
            'type':'1'
          };
          NavigatorHelper().navigateToScreen('/threshold_view',
              arguments: map);

          },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: ContainerDecoration.boxDecoration(
                    bg: APPColors.bg_grey4,
                    border: APPColors.appYellow,
                    width: 1,
                    radius: 12),
                height: 32.h,
                width: 87.w,
                margin: PagePadding.custom(4.w, 0, 4.w, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: Assets.svgs.placeHolder.svg(
                    width: 15.w,
                    height: 10.h,
                    fit: BoxFit.contain, // or BoxFit.cover
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              RabbleText.subHeaderText(
                text: buyingTeamDetail == null
                    ? "Testing"
                    : buyingTeamDetail!.name,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              SizedBox(
                height: 0.7.h,
              ),
              RabbleText.subHeaderText(
                text: buyingTeamDetail == null
                    ? s89subscribers
                    : buyingTeamDetail!.description,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.normal,
                color: APPColors.bg_grey3,
                fontFamily: 'Urbanist',
                fontSize: 11.sp,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
