import 'package:rabble/core/config/export.dart';

class CommunityDetailWidget extends StatelessWidget {
  const CommunityDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<MockCommunityModel> mockList = MockCommunityModel.getMockDaysData();
    return Container(
      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.bgColor,
          border: APPColors.bg_grey25,
          radius: 8,
          width: 1,
          showShadow: true),
      padding: PagePadding.customHorizontalVerticalSymmetric(1.5.h, 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RabbleText.subHeaderText(
            text: 'By buying as a community you are:',
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: APPColors.appBlack4,
            fontFamily: cGosha,
            height: 1.3,
            fontSize: 13.sp,
          ),
          SizedBox(
            height: 1.h,
          ),
          ListView.builder(
              shrinkWrap: true,
              padding: PagePadding.onlyTop(1.h),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mockList.length,
              itemBuilder: (context, index) {
                MockCommunityModel mockData = mockList[index];
                return CommunityDetailItemWidget(mockData: mockData);
              })
        ],
      ),
    );
  }
}
