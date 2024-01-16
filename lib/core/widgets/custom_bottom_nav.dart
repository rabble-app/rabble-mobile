import 'package:path/path.dart';
import 'package:rabble/config/export.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation(
      {Key? key,
      required this.currentIndex,
      required this.list,
      required this.onTap})
      : super(key: key);

  final int currentIndex;
  final List<Widget> list;

  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: APPColors.appBlack,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              item(context,Assets.svgs.search_bottom.path, 0, kExplore),
              item(context,Assets.svgs.tabteam.path, 1, 'Teams'),
              item(context,Assets.svgs.tabmessages.path, 2, 'Messages'),
              item(context,Assets.svgs.tabprofile.path, 3, kMyRabble),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector item(BuildContext context,String path, int index, String title) {
    return GestureDetector(
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height*0.06,
          width: 14.w,
          child: Column(
            children: [
              SizedBox(
                height: 0.7.h,
              ),
              SvgPicture.asset(path,
                  color: currentIndex == index
                      ? APPColors.appPrimaryColor
                      : APPColors.bg_grey27),
              SizedBox(
                height: 0.5.h,
              ),
              RabbleText.subHeaderText(
                text: title,
                color: currentIndex == index
                    ? APPColors.appPrimaryColor
                    : APPColors.bg_grey27,
                fontWeight: FontWeight.w600,
                fontFamily: cPoppins,
                fontSize: 7.5.sp,
              )
            ],
          ),
        ));
  }
}
