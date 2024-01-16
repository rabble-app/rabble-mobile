import 'package:rabble/config/export.dart';

class ShareWidget extends StatelessWidget {
  const ShareWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper().navigateTo('/setting_view');
      },
      child: Row(
        children: [

        Padding(
          padding: PagePadding.onlyRight(2.w),
          child: Assets.svgs.share.svg(color: APPColors.appYellow),
        ),
          RabbleText.subHeaderText(
            text: kShare,
            color: APPColors.appYellow,
            fontFamily: cPoppins,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,

          ),
          SizedBox(width: 2.w,)
        ],
      ),
    );
  }
}
