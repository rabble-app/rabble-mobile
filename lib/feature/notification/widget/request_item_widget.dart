import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';

class RequestItemWidget extends StatelessWidget {
  final RequestSendData requests;
  final String teamName;
  final Function(RequestSendData) joinCallBack;
  final Function(RequestSendData) removeCallBack;

  const RequestItemWidget(
    this.requests, {
    Key? key,
    required this.joinCallBack,
    required this.removeCallBack,
    required this.teamName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> text =
        '${requests.user!.firstName ?? ''} ${requests.user!.lastName ?? ''}'
            .split(' ');
    print(text.toString());

    String firstCharName1 = '';
    String firstCharName2 = '';

    String combination = '';

    if (text.isNotEmpty) {
      firstCharName1 = text[0];
      firstCharName2 = text.length > 1 ? text[1] : ' ';

      if(firstCharName1.length > 0 && firstCharName2.length > 2) {
        combination = firstCharName1[0] + firstCharName2[0];
      }
    }
    return Container(
      decoration: ContainerDecoration.boxDecoration(
          bg: Colors.transparent, border: APPColors.bg_grey25, radius: 8),
      padding: PagePadding.all(2.5.w),
      margin: PagePadding.onlyBottom(3.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              requests.user!.imageUrl != null &&
                      requests.user!.imageUrl!.isNotEmpty
                  ? CircularAvatarWidget(
                      firstName: requests.user!.firstName ?? '',
                      lastName: requests.user!.lastName ?? '',
                      width: 5.h,
                      height: 5.h,
                      radius: 6.w,
                      url: requests.user!.imageUrl,
                    )
                  : Container(
                      width: 12.w,
                      height: 6.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: APPColors.appBlack,
                      ),
                      child: Center(
                        child: RabbleText.subHeaderText(
                          text: combination,
                          fontWeight: FontWeight.bold,
                          color: APPColors.appPrimaryColor,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
              SizedBox(
                width: 2.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.allWidth * 0.35,
                    child: RabbleText.subHeaderText(
                      textAlign: TextAlign.left,
                      text:
                          '${requests.user!.firstName ?? ''} ${requests.user!.lastName ?? ''}',
                      fontSize: 12.sp,
                      color: APPColors.appBlack,
                      fontFamily: cGosha,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Row(
                    children: [
                      Assets.svgs.multi_profileuser
                          .svg(color: APPColors.appBlue),
                      SizedBox(
                        width: context.allWidth * 0.3,
                        child: RabbleText.subHeaderText(
                          text: teamName,
                          textAlign: TextAlign.start,
                          fontSize: 9.sp,
                          fontFamily: cPoppins,
                          color: APPColors.bg_grey27,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      joinCallBack.call(requests);
                    },
                    child: Container(
                      height: 4.5.h,
                      width: 25.w,
                      decoration: ContainerDecoration.boxDecoration(
                          bg: APPColors.appPrimaryColor,
                          border: APPColors.appPrimaryColor,
                          radius: 8,
                          width: 1),
                      child: RabbleButton.tertiaryBorderless(
                        child: RabbleText.subHeaderText(
                          text: kAccept,
                          fontSize: 12.sp,
                          fontFamily: 'Gosha',
                          color: APPColors.appBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  RemoveWidget(
                    width: 9.w,
                    height: 4.h,
                    backgroundColor: APPColors.appTextPrimary,
                    callBack: () {
                      removeCallBack(requests);
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          RabbleText.subHeaderText(
            text: kReasonToJoin,
            fontSize: 12.sp,
            color: APPColors.appBlack,
            fontFamily: cGosha,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 1.h,
          ),
          RabbleText.subHeaderText(
            text: requests.introduction,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.normal,
            fontFamily: cPoppins,
            height: 1.2,
            color: APPColors.appTextPrimary,
            fontSize: 10.sp,
          ),
          SizedBox(
            height: 1.2.h,
          ),
        ],
      ),
    );
  }
}
