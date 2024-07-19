import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/hub/open_hours_model.dart';
import 'package:rabble/domain/entities/mock/mock_days_model.dart';

class DaysWidget extends StatelessWidget {
  final List<CustomOpenHours> list;

  const DaysWidget(this.list, {super.key});

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: PagePadding.onlyTop(1.h),
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 18,
          mainAxisSpacing: 5,
          childAspectRatio: (9 / 4)),
      itemBuilder: (BuildContext context, int index) {
        CustomOpenHours daysModel = list[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RabbleText.subHeaderText(
              text: daysModel.day,
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
              text:
                  '${daysModel.startTime?.replaceFirstMapped(RegExp(r'(\d{2}:\d{2})([aApP][mM])'), (match) => "${match.group(1)} ${match.group(2)?.toUpperCase()}")} - ${daysModel.endTime?.replaceFirstMapped(RegExp(r'(\d{2}:\d{2})([aApP][mM])'), (match) => "${match.group(1)} ${match.group(2)?.toUpperCase()}")}',
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
