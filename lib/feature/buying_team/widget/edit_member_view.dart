import '../../../config/export.dart';

class EditMemberView extends StatelessWidget {
  const EditMemberView({
    Key? key,
    required this.title,
    required this.onTap,
     this.trailingTitle,
    this.fontSize,
    this.fontWeight,
    this.labelColor,
    this.trailingMargin,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final String? trailingTitle;

  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? labelColor;
  final double? trailingMargin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.81,
          child: RabbleText.subHeaderText(
            text: title,
            fontSize: fontSize ?? 22.sp,
            textAlign: TextAlign.start,
            fontWeight: fontWeight ?? FontWeight.w700,
            color: labelColor,
          ),
        ),

        Spacer(),
        InkWell(
          onTap: onTap,
          child: Container(
            margin: PagePadding.onlyTop(trailingMargin ?? 3.h),
            child: RabbleText.subHeaderText(
              text: trailingTitle ?? 'Edit',
              color: APPColors.appBlue,
            ),
          ),
        ),

      ],
    );
  }
}
