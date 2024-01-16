import '../../../config/export.dart';

class DeliveryItemWidget extends StatelessWidget {
  const DeliveryItemWidget({
    Key? key,
    required this.heading,
    required this.trailing,
    this.isLast = false,
    this.subHeading,
  }) : super(key: key);

  final String heading;
  final String? subHeading;
  final Widget trailing;
  final bool? isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePadding.custom(4.w, 4.w, 1.w, 1.w),
      child: Column(
        children: [
          Row(
            children: [
              subHeading == null
                  ? RabbleText.subHeaderText(
                      text: heading,
                      fontSize: 11.sp,
                      fontFamily: cPoppins,
                      color: APPColors.appBlack4,
                      fontWeight: FontWeight.w400,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RabbleText.subHeaderText(
                          text: heading,
                          fontSize: 13.sp,
                          fontFamily: cGosha,
                          color: APPColors.appBlack4,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 0.3.h,),
                        RabbleText.subHeaderText(
                          text: subHeading,
                          fontSize: 10.sp,
                          fontFamily: cPoppins,
                          color: APPColors.appBlack4,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),
              const Spacer(),
              trailing,
            ],
          ),
        ],
      ),
    );
  }
}
