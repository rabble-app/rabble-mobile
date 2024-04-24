import 'package:rabble/core/config/export.dart';

class NotificationItemWidget extends StatelessWidget {
  final String? title, desc;
  final bool? unread;
  final Function callBack;
  final NotificationData notificationData;

  const NotificationItemWidget(
      {Key? key,
      this.title,
      this.desc,
      this.unread,
      required this.callBack,
      required this.notificationData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == 'Join Request') {
          callBack.call();
        } else if (notificationData.type == 'TEAM') {
          Map map = {
            'teamId': notificationData.teamId,
            'type': '1',
          };
          Navigator.pushNamed(context, '/threshold_view', arguments: map);
        } else if (notificationData.type == 'CHAT') {
          Map map = {
            'teamName': title,
            'teamId': notificationData.teamId,
          };
          Navigator.pushNamed(context, '/chat_room', arguments: map);
        } else {}
      },
      child: Container(
        padding: PagePadding.custom(3.w, 3.w, 1.w, 1.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 12.w,
              height: 7.h,
              child: CircleAvatar(
                backgroundColor: APPColors.appBlack,
                child: Assets.svgs.notification
                    .svg(color: APPColors.appPrimaryColor),
              ),
            ),
            SizedBox(
              width: 1.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.allWidth * 0.75,
                  child: RabbleText.subHeaderText(
                    text: title ?? '',
                    textAlign: TextAlign.start,
                    color: APPColors.appBlack4,
                    fontWeight: FontWeight.normal,
                    fontFamily: cGosha,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(
                  width: context.allWidth * 0.75,
                  child: RabbleText.subHeaderText(
                    text: desc ?? '',
                    textAlign: TextAlign.start,
                    color: APPColors.appTextPrimary,
                    fontWeight: FontWeight.normal,
                    fontFamily: cPoppins,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
