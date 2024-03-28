import 'package:rabble/core/config/export.dart';

class FrequencyCardView extends StatelessWidget {
  FrequencyCardView({
    Key? key,
    required this.title,
    this.subTitle,
    this.icon,
    this.labelColor,
    this.onTap,
    this.isSelected = false,
    this.isCustom,
    required this.index,
    required this.cubit,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final Function? onTap;
  final IconData? icon;
  final Color? labelColor;
  final int index;
  final FrequencyCubit cubit;

  final bool? isSelected;
  final bool? isCustom;
  BehaviorSubject<Map> customFrequencyController = BehaviorSubject();

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, FrequencyCubit>(
        create: (context) => cubit,
        builder: (context, state, bloc) {
          return BehaviorSubjectBuilder<Map>(
              subject: customFrequencyController,
              builder: (context, snapshot) {
                return InkWell(
                  onTap: () {
                    if (!isCustom!) {
                      onTap!.call();
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: PagePadding.customHorizontalVerticalSymmetric(
                            4.w, 2.3.h),
                        margin: PagePadding.verticalSymmetric(0.7.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected!
                              ? APPColors.appPrimaryColor
                              : APPColors.appWhite,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  isSelected!
                                      ? Icon(
                                          Icons.check_circle_outline,
                                          color: APPColors.appBlack,
                                          size: 20.sp,
                                        )
                                      : SizedBox(
                                          width: 3.w,
                                        ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RabbleText.subHeaderText(
                                        text: title,
                                        textAlign: TextAlign.start,
                                        color: labelColor ??
                                            APPColors.appTextPrimary,
                                        fontSize: 12.sp,
                                        fontFamily: cPoppins,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      RabbleText.subHeaderText(
                                        text: subTitle ?? '',
                                        fontFamily: cPoppins,
                                        fontSize: 8.sp,
                                        color: APPColors.appTextPrimary,
                                        fontWeight: FontWeight.w600,
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      index == bloc.frequencyDataSubject$.value.length - 1
                          ? Container(
                              height: 8.h,
                              margin: PagePadding.verticalSymmetric(0.7.h),
                              child: RabbleButton.tertiaryFilled(
                                bgColor: APPColors.appWhite,
                                onPressed: () async {
                                  List<FrequencyData> tempList =
                                      bloc.frequencyDataSubject$.value;
                                  print(
                                      'Size ${tempList.length} and index $index');

                                  NavigatorHelper()
                                      .navigateTo('/add_custom_frequency_view')
                                      .then((value) async {
                                    print(value.toString());

                                    if (tempList.length < 5) {
                                      FrequencyData frequencyData =
                                          FrequencyData(
                                              heading: kCustom,
                                              subHeading:
                                              getCustomFrequencyText(
                                                      int.parse(
                                                          value['value']), value['key']),
                                              isSelected: true,
                                              isCustom: true);

                                      int epochTime =
                                          await bloc.calculateWeekToEpoch(
                                              value['value'], value['key']);

                                      frequencyData.frequecnyEpoch =
                                          epochTime.toString();

                                      frequencyData.isSelected = true;

                                      tempList.add(frequencyData);
                                      bloc.frequencyDataSubject$.sink
                                          .add(tempList);

                                      bloc.onSelectedFrequency(
                                          frequencyData, 4);
                                    } else {
                                      FrequencyData frequencyData =
                                          tempList[index];

                                      int epochTime =
                                          await bloc.calculateWeekToEpoch(
                                              value['value'], value['key']);

                                      frequencyData.frequecnyEpoch =
                                          epochTime.toString();

                                      frequencyData.isSelected = true;

                                      frequencyData.subHeading =
                                          getCustomFrequencyText(
                                              int.parse(value['value']),value['key']);

                                      tempList[tempList.indexWhere((element) =>
                                              element.heading ==
                                              frequencyData.heading)] =
                                          frequencyData;

                                      bloc.frequencyDataSubject$.sink
                                          .add(tempList);

                                      bloc.onSelectedFrequency(
                                          frequencyData, index);
                                    }

                                    customFrequencyController.sink.add(value);
                                  });
                                },
                                child: Row(
                                  children: [
                                    Assets.svgs.frequency.svg(),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    RabbleText.subHeaderText(
                                      text: kCustomFrequency,
                                      fontSize: 12.sp,
                                      fontFamily: cPoppins,
                                      color: APPColors.appBlue,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                              ))
                          : const SizedBox.shrink()
                    ],
                  ),
                );
              });
        });
  }

  String getCustomFrequencyText(int value, String timeUnit) {
    String result = 'Every ';

    if (timeUnit == 'Week') {
      if (value == 1) {
        result += '$value Week';
      } else if (value >= 4) {
        int months = value ~/ 4;  // Integer division to get number of full months.
        int remainingWeeks = value % 4;  // Remaining weeks after extracting full months.

        if (months > 0) {
          result += (months == 1) ? '$months Month' : '$months Months';
        }

        if (remainingWeeks > 0) {
          if (months > 0) {
            result += ' and ';
          }
          result += '$remainingWeeks Week${remainingWeeks > 1 ? 's' : ''}';
        }
      } else {
        result += '$value Weeks';
      }
    } else if (timeUnit == 'Month') {
      result += (value == 1) ? '$value Month' : '$value Months';
    }

    return result;
  }

}
