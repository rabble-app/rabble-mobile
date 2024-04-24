import 'package:rabble/core/config/export.dart';

class ViewAllWidget extends StatelessWidget {
  final Function? callback;
  final String title;
  final bool? showViewAllBtn;

  const ViewAllWidget({Key? key, required this.title, this.callback ,this.showViewAllBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: context.allWidth*0.6,
          child: RabbleText.subHeaderText(
            text: title,
            fontSize: 16.sp,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
            maxLines: 3,
            height: 1.1,
            fontFamily: cGosha,
            color: APPColors.appBlack4,
          ),
        ),
        showViewAllBtn!?  Padding(
          padding: PagePadding.onlyRight(2.w),
          child: GestureDetector(
            onTap: () {
              callback!.call();
            },
            child: RabbleText.subHeaderText(
              text: kViewAll,
              fontSize: 12.sp,
              color: APPColors.appBlue,
              fontWeight: FontWeight.bold,
              fontFamily: cGosha,
            ),
          ),
        ):const SizedBox.shrink(),
      ],
    );
  }
}
