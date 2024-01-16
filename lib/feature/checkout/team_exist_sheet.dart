import '../../../config/export.dart';

class TeamExistSheet extends StatelessWidget {
  final String producerName;
  final String producerId;
  final String postalCode;
  final List<BuyingTeamDetail> items;

  TeamExistSheet(this.producerName, this.postalCode, this.items, this.producerId);

  @override
  Widget build(BuildContext context) {
    return ToucheDetector(child: clearBasket(context));
  }

  Widget clearBasket(BuildContext context) {
    return Container(
      color: APPColors.bgColor,
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
              Navigator.of(context).pop(false);
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
            text: 'Starting a New Team?',
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
            text:
                'You are starting a new buying team as the host. There are already team\'s with $producerName that are delivering to $postalCode. Would you like to join one of these teams instead?',
            fontSize: 11.sp,
            height: 1.7,
            fontFamily: cPoppins,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.normal,
            color: APPColors.appTextPrimary,
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            height: context.allHeight * 0.1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RabbleButton.tertiaryFilled(
                buttonSize: ButtonSize.large,
                bgColor: APPColors.appPrimaryColor,
                onPressed: () {
                  Navigator.of(context).pop(true);

                  Map data = {
                    'name':producerName,
                    'producerId':producerId,
                    'teams':items
                  };

                  NavigatorHelper().navigateTo('/ExistingBuyingTeamsView', data);
                },
                child: RabbleText.subHeaderText(
                  text: 'Yes',
                  fontSize: 13.sp,
                  fontFamily: cGosha,
                  color: APPColors.appBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(true);

                BuyingTeamCreationService().isAuthSubject$.add(false);
                NavigatorHelper()
                    .navigateTo('/create_group_name_view', producerName);
              },
              child: RabbleText.subHeaderText(
                text: 'Create My Own Team',
                color: APPColors.appBlack,
                fontFamily: cGosha,
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
