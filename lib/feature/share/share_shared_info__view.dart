import 'package:rabble/core/util/trim_name_extension.dart';
import 'package:rabble/domain/entities/PartionedProductsData.dart';

import '../../core/config/export.dart';

class SharedInfoView extends StatelessWidget {
  final String orderUnit, subUnit;

  SharedInfoView({required this.orderUnit, required this.subUnit});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: APPColors.bgColor,
      width: context.allWidth,
      padding: PagePadding.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              NavigatorHelper().pop();
            },
            child: CircleAvatar(
              radius: 2.2.h,
              backgroundColor: APPColors.appTextPrimary,
              child: const Icon(
                Icons.close,
                color: APPColors.appWhite,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          RabbleText.subHeaderText(
            text: 'Carton Details',
            fontSize: 13.sp,
            fontFamily: cGosha,
            color: APPColors.appBlack4,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Container(
                height: context.allWidth * 0.07,
                width: context.allWidth * 0.07,
                padding: PagePadding.horizontalSymmetric(1.w),
                decoration: ContainerDecoration.boxDecoration(
                    border: APPColors.bg_grey25,
                    bg: APPColors.bg_grey25,
                    width: 1,
                    radius: 8),
              ),
              SizedBox(
                width: 2.w,
              ),
              RabbleText.subHeaderText(
                text: 'Available for purchase.',
                fontSize: 11.sp,
                fontFamily: cPoppins,
                color: APPColors.appBlack4,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          RabbleText.subHeaderText(
            text:
                'Boxes with a grey colour indicate that they are available for purchase. Users can add these ${subUnit}’s to their cart.',
            fontSize: 10.5.sp,
            textAlign: TextAlign.start,
            fontFamily: cPoppins,
            color: APPColors.appTextPrimary,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Container(
                height: context.allWidth * 0.07,
                width: context.allWidth * 0.07,
                padding: PagePadding.horizontalSymmetric(1.w),
                decoration: ContainerDecoration.boxDecoration(
                    border: APPColors.appBlack4,
                    bg: APPColors.appBlack4,
                    width: 1,
                    radius: 8),
                child: Center(
                  child: RabbleText.subHeaderText(
                    text: 'EH',
                    fontSize: 8.sp,
                    fontFamily: cPoppins,
                    color: APPColors.appPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              RabbleText.subHeaderText(
                text: 'Reserved by a user.',
                fontSize: 11.sp,
                fontFamily: cPoppins,
                color: APPColors.appBlack4,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          RabbleText.subHeaderText(
            text:
                'Boxes with a black colour and initials indicate that they have been reserved or claimed by a specific user.',
            fontSize: 10.5.sp,
            textAlign: TextAlign.start,
            fontFamily: cPoppins,
            color: APPColors.appTextPrimary,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Container(
                height: context.allWidth * 0.07,
                width: context.allWidth * 0.07,
                padding: PagePadding.horizontalSymmetric(1.w),
                decoration: ContainerDecoration.boxDecoration(
                    border: APPColors.appPrimaryColor,
                    bg: APPColors.appPrimaryColor,
                    width: 1,
                    radius: 8),
                child: Center(
                  child: RabbleText.subHeaderText(
                    text: 'EH',
                    fontSize: 8.sp,
                    fontFamily: cPoppins,
                    color: APPColors.appBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              RabbleText.subHeaderText(
                text: 'Sold',
                fontSize: 11.sp,
                fontFamily: cPoppins,
                color: APPColors.appBlack4,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          RabbleText.subHeaderText(
            text:
                'When the boxes turn a green colour with the initials it indicates that all the ${subUnit}’s have been sold and the ${orderUnit} is now part of the upcoming order.',
            fontSize: 10.5.sp,
            textAlign: TextAlign.start,
            fontFamily: cPoppins,
            color: APPColors.appTextPrimary,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
