import 'package:rabble/config/export.dart';
class RemoveWidget extends StatelessWidget {
  final Function callBack;
  final Color? backgroundColor;
  final double? width,height;
  const RemoveWidget({Key? key, required this.callBack, this.width, this.height, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       callBack.call();
      },
      child: Container(
        width:  width ?? 7.w,
        height: height ?? 3.5.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? APPColors.appWhite,
          border: Border.all(
            color: backgroundColor ?? APPColors.appIcons,
            width: 1.0,
          ),
        ),
        child:  Icon(
          Icons.close,
          color: backgroundColor ==null ? APPColors.appIcons : APPColors.appWhite,
          size: 16,
        ),
      ),
    );
  }
}
