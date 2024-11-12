import 'package:rabble/domain/entities/distance_model.dart';
import 'package:rabble/domain/entities/mock/mock_hub_model.dart';
import 'package:rabble/feature/hub/hub_cubit.dart';

import '../config/export.dart';

class KiloMeterWidget extends StatelessWidget {
  final Color? color;
  final String? distance;

  const KiloMeterWidget({super.key, this.color, this.distance});

  @override
  Widget build(BuildContext context) {


    return Container(
      height: 3.3.h,
      padding: PagePadding.all(2.w),
      decoration: ContainerDecoration.boxDecoration(
        bg: color ?? APPColors.appPrimaryColor2.withOpacity(0.15),
        border: color ?? APPColors.appPrimaryColor2.withOpacity(0.15),
        width: 0,
        radius: 30,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svgs.pin_filled.svg(width: 1.3.h),
          SizedBox(
            width: 0.5.w,
          ),
          RabbleText.subHeaderText(
            text: '$distance meters away',
            color: APPColors.appPrimaryColor2,
            fontFamily: cPoppins,
            height: 0.3,
            fontWeight: FontWeight.w500,
            fontSize: 7.2.sp,
          ),
        ],
      ),
    );
  }
}
