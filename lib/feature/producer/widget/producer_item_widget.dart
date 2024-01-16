import 'package:flutter/scheduler.dart';
import 'package:rabble/config/export.dart';

class ProducerItemWidget extends StatelessWidget {
  final ProducerDetail producerDetail;

  const ProducerItemWidget({Key? key, required this.producerDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        SystemChannels.textInput.invokeMethod('TextInput.hide');

        Map body = {
          'type':false,
          'data':producerDetail,
          'id':producerDetail.id,
        };

        NavigatorHelper().navigateTo('/producer', body);

      },
      child: Container(
        width: context.allWidth * 0.9,
        margin: PagePadding.custom(1.w, 3.w, 3.w, 4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.allHeight * 0.26,
              width: context.allWidth*0.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: RabbleImageLoader(
                  imageUrl:producerDetail.imageUrl,

//                  imageUrl:'https://storage.googleapis.com/proudcity/petalumaca/uploads/2019/07/Benton_County_Courthouse_Greg_Keene-1200x600.jpg',
                  fit: BoxFit.fill, isRound: false,
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            RabbleText.subHeaderText(
              text: producerDetail.businessName![0].toUpperCase() +
                  producerDetail.businessName!.substring(1),
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
              fontFamily: cPoppins,
              color: APPColors.appTextPrimary,
              fontSize: 14.sp,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.svgs.category.svg(width: 3.7.w, height: 1.7.h),
                SizedBox(
                  width: 2.w,
                ),
                SizedBox(
                  width: context.allWidth*0.27,
                  child: RabbleText.subHeaderText(
                    text: producerDetail.categories != null &&
                        producerDetail.categories!.isNotEmpty
                        ? producerDetail.categories!.first.category!.name
                        : '',
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: cPoppins,
                    fontWeight: FontWeight.w500,
                    color: APPColors.bg_grey27,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
              ],
            ),
            SizedBox(height: 2.w,),
            Container(
              margin: PagePadding.onlyRight(2.w),
              child: RabbleText.subHeaderText(
                text: producerDetail.description ?? '',
                textAlign: TextAlign.start,
                fontWeight: FontWeight.normal,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                fontFamily: cPoppins,
                height: 1.3,
                color: APPColors.bg_grey27,
                fontSize: 11.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
