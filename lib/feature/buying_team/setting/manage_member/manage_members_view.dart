import 'package:rabble/config/export.dart';

class ManageMembersView extends StatelessWidget {
  ManageMembersView({Key? key}) : super(key: key);

  final StreamController<int> _controller = StreamController.broadcast();
  final StreamController<bool> _privateGroupStream =
      StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    Map teamData = ModalRoute.of(context)!.settings.arguments as Map;
    TeamData data = teamData['teamData'];
    String myId = teamData['myId'];
    String memberId = teamData['memberId'];

    TeamViewCubit cubit = teamData['bloc'];
    String percentage = teamData['percentage'];
    int remainingDays = teamData['deadline'] != null && teamData['deadline'] != '0'
        ? DateFormatUtil.remainingDays(teamData['deadline'])
        : 0;
    return CubitProvider<RabbleBaseState, TeamViewCubit>(
        create: (context) => cubit,
        builder: (context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bgColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(9.h),
              child: RabbleAppbar(
                backTitle: kBack,
                title: kBuyingTeams,
                leadingWidth: 21.w,
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                StreamBuilder<int>(
                    initialData: 0,
                    stream: _controller.stream,
                    builder: (context, snapshot) {
                      return Container(
                        margin: PagePadding.horizontalSymmetric(7.w),
                        padding: PagePadding.all(0.5.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: APPColors.appWhite,
                          border:
                              Border.all(width: 2, color: APPColors.appWhite),
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
                        child: Column(
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 40.w,
                                    child: ManageMemberTabView(
                                      title: kTeamSettings,
                                      isSelected:
                                          snapshot.data == 0 ? true : false,
                                      icon: Assets.svgs.userEdit,
                                      onTap: () => toggle(snapshot.data!),
                                    ),
                                  ),
                                  ManageMemberTabView(
                                    title: kManageMembers,
                                    isSelected:
                                        snapshot.data == 1 ? true : false,
                                    icon: Assets.svgs.multi_profileuser,
                                    onTap: () => toggle(snapshot.data!),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                StreamBuilder<int>(
                    initialData: 0,
                    stream: _controller.stream,
                    builder: (context, snapshot) {
                      if (snapshot.data == 0) {
                        return Expanded(child: TeamSettingView(data, myId,cubit,percentage,remainingDays,deadLine: teamData['deadline'].toString(),memberId:memberId));
                      } else {
                        return Expanded(child: ManageTeamView(data,cubit));
                      }
                    }),
              ],
            ),
          );
        });
  }

  dynamic toggle(int value) {
    if (value == 0) {
      _controller.sink.add(1);
    } else {
      _controller.sink.add(0);
    }
  }

  dynamic togglePrivateGrp(bool value) {
    if (value) {
      _privateGroupStream.sink.add(false);
    } else {
      _privateGroupStream.sink.add(true);
    }
  }
}
