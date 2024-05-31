import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/mock/mock_days_model.dart';

class DaysWidget extends StatelessWidget {
  const DaysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<MockDaysModel> mockList = MockDaysModel.getMockDaysData();
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: PagePadding.onlyTop(1.h),
      itemCount: mockList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 5,
          childAspectRatio: (9 / 4)),
      itemBuilder: (BuildContext context, int index) {
        MockDaysModel daysModel = mockList[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RabbleText.subHeaderText(
              text: daysModel.dayName,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w600,
              color: APPColors.appTextPrimary,
              fontFamily: cPoppins,
              fontSize: 10.sp,
            ),
            SizedBox(
              height: 0.3.w,
            ),
            RabbleText.subHeaderText(
              text: daysModel.time,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
              color: APPColors.bg_grey27,
              fontFamily: cPoppins,
              fontSize: 8.sp,
            ),
          ],
        );
      },
    );
  }
}
