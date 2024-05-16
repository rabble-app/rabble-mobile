import 'package:flutter/cupertino.dart';
import 'package:rabble/core/config/export.dart';

class CommunityDetailItemWidget extends StatelessWidget {
  final MockCommunityModel mockData;

  const CommunityDetailItemWidget({super.key, required this.mockData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePadding.onlyBottom(1.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          mockData.image.png(width: 3.5.h, height: 3.5.h),
          SizedBox(
            width: 2.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RabbleText.subHeaderText(
                text: mockData.heading,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
                color: APPColors.appTextPrimary,
                fontFamily: cPoppins,
                fontSize: 9.5.sp,
              ),
              RabbleText.subHeaderText(
                text: mockData.subHeading,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                color: APPColors.bg_grey27,
                fontFamily: cPoppins,
                fontSize: 7.2.sp,
              ),
            ],
          )
        ],
      ),
    );
  }
}
