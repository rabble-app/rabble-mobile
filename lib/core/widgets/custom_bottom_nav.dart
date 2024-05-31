import 'package:path/path.dart';
import 'package:rabble/core/config/export.dart';

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
    return Container(
      color: APPColors.appBlack,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            item(
                context,
                currentIndex == 0
                    ? Assets.svgs.search_bottom_selected.path
                    : Assets.svgs.tabhome.path,
                0,
                kExplore),
            item(
                context,
                currentIndex == 1
                    ? Assets.svgs.tabteam_selected.path
                    : Assets.svgs.tabteam.path,
                1,
                'Teams'),
            item(
                context,
                currentIndex == 2
                    ? Assets.svgs.tabmessages_selected.path
                    : Assets.svgs.tabteam0.path,
                2,
                'Messages'),
            item(
                context,
                currentIndex == 3
                    ? Assets.svgs.tabprofile_selected.path
                    : Assets.svgs.tabprofile.path,
                3,
                kMyRabble),
          ],
        ),
      ),
    );
  }

  InkWell item(
      BuildContext context, String path, int index, String title) {
    return InkWell(
        key: ValueKey(index), // Assign a ValueKey based on the index
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
          width: 16.w,
          height: MediaQuery.of(context).size.height * 0.057,


          child: Column(
            children: [
              SvgPicture.asset(
                path,
              ),
              SizedBox(
                height: 0.2.h,
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
