import 'package:rabble/core/config/export.dart';

class CircularAvatarWidget extends StatelessWidget {
  final double? width, height, radius;
  final Color? backgroundColor;
  final String? url;
  final String firstName;
  final String lastName;
  final double? fontSize;

  const CircularAvatarWidget(
      {Key? key,
      this.width,
      this.height,
      this.radius,
      this.backgroundColor,
      this.url,
      required this.firstName,
      required this.lastName,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> text = '${firstName.trim()} ${lastName.trim()}'.split(' ');
    print(text.toString());

    String firstCharName1 = '';
    String firstCharName2 = '';

    String combination = '';

    if (text.isNotEmpty) {
      firstCharName1 = text[0];
      firstCharName2 = text.length > 1 ? text[1] : " "; // Change 2 to 1

      combination = firstCharName1[0] + firstCharName2[0];
    }

    return CircleAvatar(
        backgroundColor: backgroundColor ==null?  url == null || url!.isEmpty ? APPColors.appPrimaryColor:Colors.transparent : backgroundColor,
        radius: radius ?? 7.w,
        child: url == null || url!.isEmpty
            ? SizedBox(
                width: width ?? 8.w,
                height: height ?? 4.5.h,
                child: RabbleText.subHeaderText(
                  text: combination,
                  fontSize: fontSize ?? 19.sp,
                  color: APPColors.appBlack,
                ),
              )
            : SizedBox(
                width: width ?? 8.w,
                height: height ?? 4.h,
                child: RabbleImageLoader(
                  imageUrl: url ?? '',

                  isRound: true,
                  roundValue: 15,
                ),
              ));
  }
}
