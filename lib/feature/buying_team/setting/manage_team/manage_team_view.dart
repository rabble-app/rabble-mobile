import 'package:rabble/config/export.dart';

import '../../../../domain/entities/RequestSendModel.dart';

class ManageTeamView extends StatelessWidget {
  final TeamData teamData;
  final TeamViewCubit cubit;

  ManageTeamView(this.teamData, this.cubit, {Key? key}) : super(key: key);
  final TeamMemberCubit teamMemberCubit = TeamMemberCubit();

  @override
  Widget build(BuildContext context) {
    List<RequestSendData>? requestList = teamData.requests ?? [];
    List<Members>? memberList = teamData.members ?? [];

    teamMemberCubit.teamMemberSubject$.sink.add(memberList);
    teamMemberCubit.teamRequestSubject$.sink.add(requestList);

    return CubitProvider<RabbleBaseState, TeamMemberCubit>(
        create: (context) => teamMemberCubit..fetchUserData(),
        builder: (context, state, bloc) {
          return Container(
            padding: PagePadding.all(5.w),
            child: Column(
              children: [
                requestList.isEmpty
                    ? const SizedBox.shrink()
                    : InkWell(
                        onTap: () {
                          Map data = {
                            'request': requestList,
                            'teamName': teamData.name,
                            'bloc': cubit
                          };
                          NavigatorHelper()
                              .navigateTo('/my_team_request_list_view', data);
                        },
                        child: TeamSettingCustomView(
                          icon: Assets.svgs.request
                              .svg(color: APPColors.appTextPrimary),
                          title: 'New requests to join team',
                          trailing: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 4.w,
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor: APPColors.appBlack,
                                  child: RabbleText.subHeaderText(
                                    text: requestList.length.toString(),
                                    fontFamily: cGosha,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold,
                                    color: APPColors.appPrimaryColor,
                                  ),
                                ),
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
                Expanded(
                  child: BehaviorSubjectBuilder<UserModel>(
                      subject: bloc.userDataSubject$,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Empty();
                        UserModel userData = snapshot.data!;
                        return BehaviorSubjectBuilder<List<Members>>(
                            subject: bloc.teamMemberSubject$,
                            builder: (context, snapshot) {
                              print(snapshot.data!.length);
                              if (!snapshot.hasData) {
                                return EmptyStateWidget(
                                    heading: 'No Members in Your Team?',
                                    subHeading: 'Get started by inviting your colleagues and friends to join your team. Click the button below to access your phonebook contact list and start inviting them to collaborate and achieve greatness together.',
                                    svg: Assets.svgs.member_empty,
                                    btnHeading: '',
                                    callback: () {
                                      NavigatorHelper().navigateTo('/contact_view', teamData);

                                    });
                              }
                              if (snapshot.data!.isEmpty ) {
                                return EmptyStateWidget(
                                    heading: 'No Members in Your Team?',
                                    subHeading: 'Get started by inviting your colleagues and friends to join your team. Click the button below to access your phonebook contact list and start inviting them to collaborate and achieve greatness together.',
                                    svg: Assets.svgs.member_empty,
                                    btnHeading:
                                        'Invite Contacts',
                                    callback: () {
                                      NavigatorHelper().navigateTo('/contact_view', teamData);

                                    });
                              }

                              if (snapshot.data!.length==1 &&  snapshot.data!.where((element) => element.userId == teamData.hostId)!=null) {
                                return EmptyStateWidget(
                                    heading: 'No Members in Your Team?',
                                    subHeading: 'Get started by inviting your colleagues and friends to join your team. Click the button below to access your phonebook contact list and start inviting them to collaborate and achieve greatness together.',
                                    svg: Assets.svgs.member_empty,
                                    btnHeading:
                                    'Invite Contacts',
                                    callback: () {
                                      NavigatorHelper().navigateTo('/contact_view', teamData);

                                    });
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return snapshot.data![index].userId == teamData.hostId
                                      ? const SizedBox.shrink()
                                      : MemberProfileView(
                                          isNormalPage: false,
                                          teamName: teamData.name,
                                          imageUrl: teamData.imageUrl,
                                          isHost:
                                              userData.id == teamData.hostId,
                                          orderId: teamData.id!,
                                          data: snapshot.data![index],
                                          callBackRemove: (val) {
                                            var tempList = snapshot.data!;
                                            tempList.remove(val);
                                            bloc.teamMemberSubject$.sink
                                                .add(tempList);
                                          },
                                        );
                                },
                              );
                            });
                      }),
                ),
              ],
            ),
          );
        });
  }
}
