import 'package:rabble/domain/entities/distance_model.dart';
import 'package:rabble/domain/entities/mock/mock_hub_model.dart';
import 'package:rabble/feature/hub/hub_cubit.dart';

import '../config/export.dart';

class KiloMeterWidget extends StatefulWidget {
  final Color? color;
  final MockHubModel? mockHubModel;

  const KiloMeterWidget({super.key, this.color, this.mockHubModel});

  @override
  State<KiloMeterWidget> createState() => _KiloMeterWidgetState();
}

class _KiloMeterWidgetState extends State<KiloMeterWidget> {
  late HubCubit bloc;

  @override
  void initState() {
    bloc = context.read<HubCubit>();
    bloc.calculateDistanceFromPostalCode(widget.mockHubModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BehaviorSubjectBuilder<DistanceModel>(
        subject: bloc.distanceSubject$,
        builder: (context, snapshot) {
          print('here');

          if (bloc.state.tertiaryBusy) {
            return SizedBox(
                width: 2.h,
                height: 2.h,
                child: const RabbleSecondaryScreenProgressIndicator(
                    enabled: true));
          }
          if (!snapshot.hasData) return const Empty();
          if (snapshot.data?.metres == null) return const Empty();

          DistanceModel distanceModel = snapshot.data!;

          return Container(
            height: 3.3.h,
            padding: PagePadding.all(2.w),
            decoration: ContainerDecoration.boxDecoration(
              bg: widget.color ?? APPColors.appPrimaryColor2.withOpacity(0.15),
              border:
                  widget.color ?? APPColors.appPrimaryColor2.withOpacity(0.15),
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
                  text: '${distanceModel.metres?.ceil()} meters away',
                  color: APPColors.appPrimaryColor2,
                  fontFamily: cPoppins,
                  height: 0.3,
                  fontWeight: FontWeight.w500,
                  fontSize: 7.2.sp,
                ),
              ],
            ),
          );
        });
  }
}
