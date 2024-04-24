import '../../../core/config/export.dart';

class EditNextShipmentDateView extends StatelessWidget {
  const EditNextShipmentDateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map teamData = ModalRoute.of(context)!.settings.arguments as Map;

    return CubitProvider<RabbleBaseState, FrequencyCubit>(
        create: (context) => FrequencyCubit(),
        builder: (Context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bgColor,
            body: Column(
              children: [
                Container(
                  width: 100.w,
                  height: 12.h,
                  color: APPColors.appBlack,
                  padding: PagePadding.onlyTop(
                    4.h,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      InkWell(
                        onTap: () {
                          if(!state.secondaryBusy) {
                            NavigatorHelper().pop();
                          }
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: 7.w,
                          height: 5.h,
                          child: CircleAvatar(
                            backgroundColor: APPColors.appPrimaryColor,
                            child: const Icon(
                              Icons.close,
                              color: APPColors.appBlack4,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      RabbleText.subHeaderText(
                        text: kEditNextShipmentDate,
                        color: APPColors.appPrimaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: PagePadding.horizontalSymmetric(4.w),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 2.h,
                          ),
                          RabbleText.subHeaderText(
                            text: kCurrentShipmentDate,
                            fontFamily: 'Gosha',
                            color: APPColors.appBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            height: 9.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: APPColors.appWhite,
                              border: Border.all(
                                  width: 2, color: APPColors.appWhite),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                  offset: const Offset(
                                      0, 3), // Offset in the x and y direction
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 3.w,
                                ),
                                Container(
                                  height: 6.h,
                                  width: 12.w,
                                  padding: PagePadding.all(2.w),
                                  decoration: ContainerDecoration.boxDecoration(
                                      bg: APPColors.bg_grey26,
                                      border: APPColors.bg_grey26,
                                      width: 1,
                                      radius: 8),
                                  child: Assets.svgs.truck_blue.svg(),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                RabbleText.subHeaderText(
                                  text: teamData['teamNextDate']
                                          .toString()
                                          .isNotEmpty
                                      ? DateFormatUtil.formatDate(
                                          teamData['teamNextDate'],
                                          'dd MMM yyyy')
                                      : '',
                                  color: APPColors.appBlack,
                                  fontSize: 10.sp,
                                  fontFamily: cPoppins,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          RabbleText.subHeaderText(
                            text: kEditNewShipmentDate,
                            fontFamily: 'Gosha',
                            color: APPColors.appBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          CustomCalendar(teamData['teamNextDate'],
                              selectedDateCallBack: (DateTime selectedDate) {
                            bloc.selectedDateFormat$.sink.add(selectedDate);
                          }),
                          SizedBox(
                            height: 6.h,
                          ),
                          BehaviorSubjectBuilder(
                              subject: bloc.selectedDateFormat$,
                              builder: (context, snapshot) {
                                return RabbleButton.tertiaryFilled(
                                  buttonSize: ButtonSize.large,
                                  bgColor: APPColors.appPrimaryColor,
                                  onPressed: state.secondaryBusy
                                      ? null
                                      : () {
                                          if (!snapshot.hasData) {
                                            NavigatorHelper().pop();
                                          } else {
                                            Map<String, dynamic> body = {
                                              'nextDeliveryDate': snapshot.data!
                                                  .toIso8601String()
                                            };
                                            bloc
                                                .updateTeamData(
                                                    teamData['teamId']!, body)
                                                .then((value) {
                                              NavigatorHelper().pop();
                                            });
                                          }
                                        },
                                  child: state.secondaryBusy
                                      ? const Center(
                                          child:
                                              RabbleSecondaryScreenProgressIndicator(
                                            enabled: true,
                                          ),
                                        )
                                      : RabbleText.subHeaderText(
                                          text: kSaveUpdate,
                                          fontSize: 14.sp,
                                          fontFamily: 'Gosha',
                                          color: APPColors.appBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                );
                              }),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
