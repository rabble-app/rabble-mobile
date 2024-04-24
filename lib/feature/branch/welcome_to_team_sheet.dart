import '../../../core/config/export.dart';

class WelcomeToTeamSheet extends StatelessWidget {
  final InvitationData? data;

  const WelcomeToTeamSheet(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    dbHelper.clearTeamData(data!.producerInfo!.id!);
    RabbleStorage.setInivitationData(json.encode(data));
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: ToucheDetector(
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
                  NavigatorHelper().navigateAnClearAll('/home');
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
                text: 'Welcome to Your New Team',
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
                    'Welcome to ${data!.teamName} Buying Team. In order to join please choose the product you want delivered  ',
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
                bgColor: APPColors.appPrimaryColor,
                onPressed: () {
                  Map body = {
                    'type': true,
                    'data': ProducerDetail(
                        imageUrl: data!.producerInfo!.imageUrl,
                        id: data!.producerInfo!.id,
                        businessName: data!.producerInfo!.businessName,
                        businessAddress: data!.producerInfo!.businessAddress,
                        website: data!.producerInfo!.website,
                        categories: data!.producerInfo!.categories!,
                        count: data!.producerInfo!.count),
                    'team': TeamData(
                      id: data!.teamId,
                      name: data!.teamName,
                      producer: data!.producerInfo,
                      producerId: data!.producerInfo!.id,
                    )
                  };
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/producer', (Route route) => false,
                      arguments: body);
                },
                child: RabbleText.subHeaderText(
                  text: kContinue,
                  fontSize: 13.sp,
                  fontFamily: cGosha,
                  color: APPColors.appBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
