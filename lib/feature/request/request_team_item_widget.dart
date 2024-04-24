import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';

class RequestTeamItemWidget extends StatelessWidget {
  final RequestSendData requests;
  final Function(RequestSendData) joinCallBack;
  final Function(RequestSendData) removeCallBack;

  const RequestTeamItemWidget(this.requests,
      {Key? key, required this.joinCallBack, required this.removeCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePadding.all(2.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularAvatarWidget(
                firstName: requests.user!.firstName ?? '',
                lastName: requests.user!.lastName ?? '',
                width: 3.w,
                height: 3.h,
                radius: 6.w,
                url: requests.user!.imageUrl ?? '',
              ),
              SizedBox(
                width: 2.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RabbleText.subHeaderText(
                    text:
                        '${requests.user!.firstName ?? ''} ${requests.user!.lastName ?? ''}',
                    fontSize: 13.sp,
                    color: APPColors.appBlack,
                    fontWeight: FontWeight.bold,
                  ),
                  RabbleText.subHeaderText(
                    text: requests.introduction,
                    fontSize: 9.sp,
                    color: APPColors.appTextPrimary,
                    fontFamily: cPoppins,
                    fontWeight: FontWeight.normal,
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      joinCallBack.call(requests);
                    },
                    child: Container(
                      height: 4.5.h,
                      width: context.allWidth * 0.25,
                      decoration: ContainerDecoration.boxDecoration(
                          bg: APPColors.bg_grey22,
                          border: APPColors.bg_grey22,
                          radius: 24,
                          width: 1),
                      child: Center(
                        child: RabbleText.subHeaderText(
                          text: kAddToTeam,
                          textAlign: TextAlign.center,
                          fontSize: context.allWidth * 0.03,
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
                  InkWell(
                    onTap: () {
                      removeCallBack(requests);
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 8.5.w,
                      height: 4.2.h,
                      child: CircleAvatar(
                        backgroundColor: APPColors.appPrimaryColor,
                        child: const Icon(
                          Icons.close,
                          color: APPColors.appBlack4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 1.2.h,
          ),
          const Divider(
            color: APPColors.bg_grey23,
            thickness: 0.5,
            height: 0.1,
          )
        ],
      ),
    );
  }
}
