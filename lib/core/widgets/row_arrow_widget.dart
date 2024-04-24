import 'package:rabble/core/config/export.dart';

class RowArrowWidget extends StatelessWidget {
  final Widget? widget;
  final String title;
  final Function? callBack;
  final Color? titlColor;
  final bool? showArrow;

  const RowArrowWidget(
      {Key? key, this.widget, required this.title, this.callBack, this.titlColor, this.showArrow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack == null
          ? null
          : () {
              callBack!.call();
            },
      child: Padding(
        padding: PagePadding.custom(4.w, 4.w, 2.5.w, 2.5.w),
        child: Column(
          children: [
            Row(
              children: [
                widget!,
                SizedBox(
                  width: 3.w,
                ),
                RabbleText.subHeaderText(
                  text: title,
                  color: titlColor ?? APPColors.appBlack,

                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                showArrow != null
                    ? const SizedBox.shrink()
                    : const Icon(
                  Icons.arrow_forward_ios,
                  color: APPColors.bgGreyLight,
                )
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            showArrow != null
                ? const SizedBox.shrink()
                :    const Divider(
              color: APPColors.bg_grey12,
              thickness: 0.5,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
