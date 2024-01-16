import '../../../config/export.dart';

class TeamSettingCustomView extends StatelessWidget {
  const TeamSettingCustomView({
    Key? key,
    required this.title,
    this.subTitle,
    required this.icon,
    this.trailing,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final Widget icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePadding.customHorizontalVerticalSymmetric(0, 0.4.h),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: APPColors.appWhite,
        child: Padding(
          padding: PagePadding.custom(3.w, 3.w, 4.5.w, 4.5.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon,
              SizedBox(
                width: 1.5.w,
              ),
              subTitle == null
                  ? RabbleText.subHeaderText(
                      text: title,
                      fontSize: 11.sp,
                      height: 1.4,
                      fontFamily: cPoppins,
                      fontWeight: FontWeight.w500,
                      color: APPColors.appBlack4,
                    )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RabbleText.subHeaderText(
                          text: title,
                          fontSize: 10.sp,
                          height: 1.4,
                          fontFamily: cPoppins,
                          fontWeight: FontWeight.w500,
                          color: APPColors.appBlack4,
                        ),
                        SizedBox(
                          width: context.allWidth*0.25,
                          child: RabbleText.subHeaderText(
                            text: subTitle,
                            textAlign: TextAlign.start,
                            fontSize: 10.sp,
                            height: 1.4,
                            fontFamily: cPoppins,
                            fontWeight: FontWeight.w500,
                            color: APPColors.appBlue,
                          ),
                        )
                      ],
                    ),
              const Spacer(),
              trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
