
import '../../../core/config/export.dart';


class BuyingWithTeamsView extends StatelessWidget {
  const BuyingWithTeamsView({Key? key,  this.avatar, required this.host, required this.address, required this.nextCharge, required this.teamTitle, this.status, this.onTap}) : super(key: key);

  final String? avatar;
  final String teamTitle;
  final String host;
  final String nextCharge;
  final String address;
  final String? status;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
   return InkWell(
     onTap: onTap,
     child: Container(
       padding: PagePadding.customHorizontalVerticalSymmetric(3.w, 2.h),
       margin: PagePadding.onlyBottom(1.2.h),
       decoration: BoxDecoration(
         color: APPColors.appWhite,
         borderRadius: BorderRadius.circular(8),
         border: Border.all(color: APPColors.appPrimaryColor)
       ),
       child: Row(
         children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 children: [
                   SquareAvatarWidget(
                     backgroundColor: Colors.transparent,
                   ),
                   SizedBox(
                     width: 2.w,
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       content(teamTitle, fontWeight: FontWeight.w700, fontSize: 14.sp),
                       SizedBox(
                         height: 0.5.h,
                       ),
                       OrderCustomTextSpan(
                         prefixLabel: kHost,
                         postFixLabel: host,
                         shouldMakeBold: false,
                         labelColor: APPColors.appBlack.withOpacity(0.5),
                       ),
                     ],
                   ),
                 ],
               ),
               SizedBox(
                 height: 1.h,
               ),

               Padding(
                 padding: PagePadding.horizontalSymmetric(2.w),
                 child: status == sStatus ? OrderCustomTextSpan(
                   prefixLabel: kStatus,
                   postFixLabel: status!,
                   labelColor: APPColors.appBlack.withOpacity(0.5),
                 ) : Column(
                   mainAxisSize: MainAxisSize.min,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     OrderCustomTextSpan(
                       prefixLabel: kNextCharge,
                       postFixLabel: nextCharge,
                       labelColor: APPColors.appBlack.withOpacity(0.5),
                       postFixLabelColor: APPColors.appBlack,
                     ),
                     content(address, color: APPColors.appBlack.withOpacity(0.5)),
                   ],
                 ),
               ),

             ],
           ),
           Spacer(),
           Icon(Icons.arrow_forward_ios_outlined, color: APPColors.appTextGrey,)
         ],
       ),
     ),
   );
  }

  dynamic content(String text, {FontWeight? fontWeight, double? fontSize, Color? color}) {
    return RabbleText.subHeaderText(
      text: text,
      fontSize: fontSize,
        fontWeight: fontWeight,
      color: color,
    );
  }
}
