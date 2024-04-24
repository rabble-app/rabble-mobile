import 'package:rabble/core/config/export.dart';

class RequestBadgeWidget extends StatelessWidget {
  final Color? IconColor;
  const RequestBadgeWidget({Key? key, this.IconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.supervisor_account_outlined,
          color: IconColor ?? APPColors.appBlack,
          size: 6.w,
        ),
        const Positioned(
          bottom: 0,
          right: 0.0,
          child: Icon(Icons.brightness_1,
              size: 10.0, color: APPColors.appRed),
        )
      ],
    );
  }
}
