import 'package:rabble/core/config/export.dart';
import 'package:rabble/feature/buying_team/setting/quite_team_sheet.dart';

class TeamSettingView extends StatelessWidget {
  final TeamData teamData;
  final String myId;
  final TeamViewCubit cubit;
  final String percentage;
  final String deadLine;
  final String memberId;
  final int remainingDays;

  TeamSettingView(
      this.teamData, this.myId, this.cubit, this.percentage, this.remainingDays,
      {Key? key, required this.deadLine, required this.memberId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit.privateGroupStream.sink.add(teamData.isPublic ?? false);
    cubit.teamData$.sink.add(teamData);

    return CubitProvider<RabbleBaseState, TeamViewCubit>(
        create: (BuildContext context) => cubit,
        builder:
            (BuildContext context, RabbleBaseState state, TeamViewCubit bloc) {
          return Container(
            padding: PagePadding.custom(5.w, 5.w, 0, 0),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  RabbleText.subHeaderText(
                    text: kTeamInfo,
                    color: APPColors.appBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  TeamSettingCustomView(
                    icon: Assets.svgs.multi_profileuser
                        .svg(color: APPColors.appBlack4),
                    title: kTeamName,
                    trailing: InkWell(
                      onTap: () {
                        Map data = {
                          'teamName': teamData.name,
                          'teamId': teamData.id,
                          'producerName': teamData.producer!.businessName ?? '',
                        };
                        NavigatorHelper()
                            .navigateTo('/edit_team_name_view', data)
                            .then((value) {
                          if (value != null) {
                            TeamData teamData = bloc.teamDataSubject$.value;
                            teamData.name = value;
                            bloc.teamDataSubject$.sink.add(teamData);
                          }
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RabbleText.subHeaderText(
                            text: kEdit,
                            fontFamily: cGosha,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: APPColors.appBlue,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: APPColors.appBlue,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                  ),
                  TeamSettingCustomView(
                    icon: Assets.svgs.userEdit.svg(),
                    title: kTeamIntroduction,
                    trailing: InkWell(
                      onTap: () {
                        Map data = {
                          'teamName': teamData.description ?? '',
                          'teamId': teamData.id,
                          mFrequency: teamData.frequency,
                          mProducerName: teamData.producer!.businessName ?? '',
                        };

                        NavigatorHelper()
                            .navigateTo('/edit_team_intro_view', data)
                            .then((value) {
                          if (value != null) {
                            TeamData teamData = bloc.teamDataSubject$.value;
                            teamData.description = value;
                            bloc.teamDataSubject$.sink.add(teamData);
                          }
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RabbleText.subHeaderText(
                            text: kEdit,
                            fontFamily: cGosha,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: APPColors.appBlue,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: APPColors.appBlue,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  RabbleText.subHeaderText(
                    text: kTeamSettings,
                    color: APPColors.appBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  BehaviorSubjectBuilder<bool>(
                      initialData: teamData.isPublic,
                      subject: bloc.privateGroupStream,
                      builder: (context, s) {
                        return TeamSettingCustomView(
                          icon: Assets.svgs.lock.svg(),
                          title: !s.data! ? 'Make Group Public' : kPrivateGrp,
                          trailing: SizedBox(
                            height: 2.h,
                            child: state.primaryBusy
                                ? SizedBox(
                                    width: 2.5.h,
                                    height: 2.5.h,
                                    child: const Center(
                                      child:
                                          RabbleSecondaryScreenProgressIndicator(
                                        enabled: true,
                                      ),
                                    ),
                                  )
                                : Transform.scale(
                                    scale: 1,
                                    child: Switch(
                                        trackOutlineColor:
                                            MaterialStateProperty.all<Color>(
                                                s.data!
                                                    ? APPColors.appPrimaryColor
                                                    : Colors.transparent),
                                        value: s.data!,
                                        activeColor: APPColors.appWhite,
                                        inactiveThumbColor: APPColors.appWhite,
                                        inactiveTrackColor: APPColors.bg_grey28,
                                        activeTrackColor:
                                            APPColors.appPrimaryColor,
                                        onChanged: (val) async {
                                          bloc.privateGroupStream.sink.add(val);

                                          Map<String, dynamic> body = {
                                            'isPublic': val
                                          };

                                          await bloc.updateTeamData(
                                              teamData.id!, body);
                                        }),
                                  ),
                          ),
                        );
                      }),
                  int.parse(percentage) >= 100
                      ? state.secondaryBusy
                          ? const Center(
                              child: RabbleSecondaryScreenProgressIndicator(
                                enabled: true,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                bloc.nudgeTeam(teamData.id!);
                              },
                              child: TeamSettingCustomView(
                                icon: Assets.svgs.alarm.svg(),
                                title: kNudgeToCollect,
                                trailing: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RabbleText.subHeaderText(
                                      text: kNudge,
                                      fontFamily: cGosha,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: APPColors.appBlue,
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Assets.svgs.notification.svg()
                                  ],
                                ),
                              ),
                            )
                      : const SizedBox.shrink(),
                  BehaviorSubjectBuilder<TeamData>(
                      subject: bloc.teamData$,
                      builder: (context, snapshot) {
                        return InkWell(
                          onTap: () {
                            Map data = {
                              'teamFrequency': snapshot.data!.frequency ?? '',
                              'teamId': snapshot.data!.id,
                              'producerName':
                                  snapshot.data!.producer!.businessName ?? '',
                            };

                            NavigatorHelper()
                                .navigateTo('/edit_frequency_view', data)
                                .then((value) {
                              if (value != null) {
                                TeamData tempData = snapshot.data!;
                                print("value 123 $value");
                                tempData.frequency = value['freequnecy'];
                                tempData.description = value['desc'];
                                bloc.teamData$.sink.add(tempData);
                              }
                            });
                          },
                          child: TeamSettingCustomView(
                            icon: Assets.svgs.convertshape.svg(),
                            title: kShipmentFrq,
                            subTitle: getCustomFrequencyText(
                                int.parse(snapshot.data!.frequency.toString())),
                            trailing: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RabbleText.subHeaderText(
                                  text: kEdit,
                                  fontFamily: cGosha,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: APPColors.appBlue,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: APPColors.appBlue,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  int.parse(percentage) >= 100 &&
                          remainingDays >= 5 &&
                          teamData.count!.order! > 1
                      ? InkWell(
                          onTap: () {
                            Map data = {
                              'teamNextDate': teamData.nextDeliveryDate ?? '',
                              'teamId': teamData.id
                            };
                            NavigatorHelper().navigateTo(
                                '/edit_next_shipment_date_view', data);
                          },
                          child: TeamSettingCustomView(
                            icon: Assets.svgs.calendarEdit.svg(),
                            title: kAdjustDate,
                            trailing: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RabbleText.subHeaderText(
                                  text: kEdit,
                                  fontFamily: cGosha,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: APPColors.appBlue,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: APPColors.appBlue,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    height: context.allHeight * 0.13,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        CustomBottomSheet.showQuitBottomModelSheet(
                            context,
                            QuiteTeam(
                              canLeave: int.parse(percentage) < 100 &&
                                  remainingDays > 0 &&
                                  teamData.count!.order! == 1,
                              showHeading: true,
                              isHost: teamData.hostId ==
                                  bloc.currentUserDataSubject$.value.id,
                              subheading:
                                  'Are you sure you want to shut down this team?',
                              des:
                                  ' By quitting this team you will be shutting it down for all members. Please make sure you have notified them in advance.',
                              callBackDelete: () async {
                                await bloc.quiteTeam(myId);
                              },
                              date: deadLine,
                            ),
                            true,
                            int.parse(percentage) < 100 &&
                                remainingDays > 0 &&
                                teamData.count!.order! == 1,
                            isRemove: true,
                            date: deadLine);
                      },
                      child: state.tertiaryBusy
                          ? const Center(
                              child: RabbleSecondaryScreenProgressIndicator(
                                enabled: true,
                              ),
                            )
                          : RabbleText.subHeaderText(
                              text: kQuitTeam,
                              fontSize: 14.sp,
                              height: 1.4,
                              fontFamily: cGosha,
                              fontWeight: FontWeight.bold,
                              color: APPColors.appRedLight,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  int epochToTotalDays(int epochTimestamp) {
    return epochTimestamp ~/
        (24 * 60 * 60); // Convert the timestamp to days directly
  }

  String getCustomFrequencyText(int frequency) {
    int value = DateFormatUtil().epochToTotalWeeks(frequency);

    String result = ' ';

    if (value == 1) {
      result += '$value Week';
    } else if (value >= 4) {
      int months =
          value ~/ 4; // Integer division to get the number of full months.
      int remainingWeeks =
          value % 4; // Remaining weeks after extracting full months.

      if (months > 0) {
        result += (months == 1) ? '$months Month' : '$months Month\'s';
      }

      if (remainingWeeks > 0) {
        if (months > 0) {
          result += ' and ';
        }
        result += '$remainingWeeks Week${remainingWeeks > 1 ? '\'s' : ''}';
      }
    } else {
      result += '$value Week\'s';
    }

    return result;
  }
}
