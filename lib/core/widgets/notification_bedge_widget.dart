import 'package:rabble/config/export.dart';

class NotificationBadgeWidget extends StatelessWidget {

  final Color? IconColor;
  final Function? callBack;
  final List<NotificationData> notifcationList;
  const NotificationBadgeWidget({Key? key, this.IconColor, this.callBack, required this.notifcationList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack!=null? (){
        callBack!.call();
      }:null,
      child: Padding(
        padding: const PagePadding.custom(3,3,12.0,12.0),
        child: notifcationList.isNotEmpty?
        Assets.svgs.direct_notification.svg(
          width: 5.w,
          height: 2.5.h
        ):Assets.svgs.notification2.svg(
            width: 5.w,
            height: 2.5.h,
        ),
      ),
    );
  }
}
