import 'package:rabble/config/export.dart';

class MemberCustomizedCard extends StatelessWidget {
  const MemberCustomizedCard({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
    this.trailing,
  }) : super(key: key);

  final String label;
  final String value;
  final Widget icon;

  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(3.w, 2.h),
      margin: PagePadding.onlyBottom(1.h),
      decoration: BoxDecoration(
        color: APPColors.appWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.w),
              color: APPColors.grey,
            ),
            child: icon,
          ),
          SizedBox(
            width: 4.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RabbleText.subHeaderText(
                text: label,
                fontSize: 9.sp,
                fontWeight: FontWeight.w600,
                color: APPColors.greyText,
                fontFamily: 'Poppins',
              ),
              SizedBox(
                height: 7,
              ),
              RabbleText.subHeaderText(
                text: value,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ],
          ),
          Spacer(),
          trailing ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
