import '../../../core/config/export.dart';

class ManageMemberTabView extends StatelessWidget {
  const ManageMemberTabView(
      {Key? key,
      required this.title,
      required this.isSelected,
      required this.onTap,
      required this.icon})
      : super(key: key);

  final String title;
  final bool isSelected;
  final SvgGenImage icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: PagePadding.custom(3.w,3.w,3.w,3.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? APPColors.appBlack : APPColors.appWhite,
          border: Border.all(width: 2, color: APPColors.appWhite),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: PagePadding.onlyTop(0.2.w),
              child: icon.svg(
                  color: isSelected
                      ? APPColors.appPrimaryColor
                      : APPColors.bg_grey27),
            ),
            SizedBox(
              width: 1.w,
            ),
            RabbleText.subHeaderText(
              text: title,
              fontSize: 11.sp,
              color:
                  isSelected ? APPColors.appPrimaryColor : APPColors.bg_grey27,
            )
          ],
        ),
      ),
    );
  }
}
