import 'package:rabble/config/export.dart';

class BuyingTeamCardShimmer extends StatefulWidget {
  const BuyingTeamCardShimmer({super.key});


  @override
  State<BuyingTeamCardShimmer> createState() => _BuyingTeamCardShimmerState();
}

class _BuyingTeamCardShimmerState extends State<BuyingTeamCardShimmer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Size data = MediaQuery.of(context).size;

    return Container(
      width: data.width,
      decoration: BoxDecoration(
          color: APPColors.appWhite, borderRadius: BorderRadius.circular(8)),
      child: ExpansionTile(
        iconColor: APPColors.appPrimaryColor,
        initiallyExpanded: false,
        tilePadding: PagePadding.custom(3.w, 3.w, 1.5.w, 1.5.w),
        childrenPadding: const PagePadding.all(0),
        expandedAlignment: Alignment.center,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            content('',
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: APPColors.appBlack4,
                fontFamily: cGosha),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                content('',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.normal,
                    color: APPColors.appTextPrimary,
                    fontFamily: cPoppins),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  width: 1.5.w,
                  height: 1.5.h,
                  decoration: const BoxDecoration(
                      color: APPColors.bg_grey25, shape: BoxShape.circle),
                ),
                SizedBox(
                  width: 2.w,
                ),
                content('',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.normal,
                    color: APPColors.appTextPrimary,
                    fontFamily: cPoppins),
              ],
            ),
          ],
        ),
        maintainState: true,
        onExpansionChanged: (b) {
          setState(() {
            isExpanded = b;
          });
        },
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        trailing: SizedBox(
          width: 20.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              content('',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: APPColors.appTextPrimary,
                  fontFamily: cGosha),
              SizedBox(
                width: 2.w,
              ),
              !isExpanded
                  ? const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: APPColors.appBlue,
                      size: 20,
                    )
                  : const Icon(
                      Icons.keyboard_arrow_up_outlined,
                      color: APPColors.appBlue,
                      size: 20,
                    )
            ],
          ),
        ),
        children: [
         ...[12,3].map((e) => Container(
           padding: PagePadding.custom(4.w, 4.w, 1.5.w, 1.5.w),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Divider(
                 color: APPColors.bg_grey25,
                 thickness: 0.7,
               ),
               Padding(
                 padding: PagePadding.horizontalSymmetric(2.w),
                 child: BasketItemWidget(
                   qty: '',
                   title: '',
                   price: '',
                 ),
               ),
             ],
           ),
         )) ,
        ],
      ),
    );
  }

  dynamic content(String text,
      {FontWeight? fontWeight,
      double? fontSize,
      Color? color,
      String? fontFamily}) {
    return RabbleText.subHeaderText(
      text: text,
      fontSize: fontSize,
      fontFamily: fontFamily ?? cPoppins,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
