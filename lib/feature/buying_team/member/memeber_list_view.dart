import 'package:rabble/core/config/export.dart';
import 'package:rabble/feature/buying_team/widget/buying_team_item_shimmer.dart';
import 'package:rabble/domain/entities/UserTeamModel.dart' as userTeamModel;

class MemberListView extends StatelessWidget {
  const MemberListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, MemberTeamCubit>(
        create: (context) => MemberTeamCubit(),
        builder: (context, state, bloc) {
          return state.primaryBusy
              ? ListView.builder(
                  itemCount: 10,
                  padding: PagePadding.custom(1.w, 0, 3.w, 5.w),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const BuyingTeamItemShimmer();
                  })
              : BehaviorSubjectBuilder<List<userTeamModel.HostTeamData>>(
                  subject: bloc.memberTeamListSubject$,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return EmptyStateWidget(
                          heading: kNotMemberAnyTeam,
                          subHeading: kNoMemberHint,
                          svg: Assets.svgs.member_empty,
                          btnHeading: '',
                          callback: () {});
                    }
                    if (snapshot.data!.isEmpty) {
                      return EmptyStateWidget(
                          heading: kNotMemberAnyTeam,
                          subHeading: kNoMemberHint,
                          svg: Assets.svgs.member_empty,
                          btnHeading: 'Show Buying Teams Near Me',
                          callback: () {
                            if (PostalCodeService()
                                .postalCodeGlobalSubject
                                .value
                                .isNotEmpty) {
                              NavigatorHelper()
                                  .navigateTo('/all_buying_teams_view', {});
                            } else {
                              globalBloc.showWarningSnackBar(
                                  duration: const Duration(milliseconds: 1500),
                                  content: Row(
                                    children: [
                                      RabbleText.subHeaderText(
                                        text: 'Please add your postcode',
                                        textAlign: TextAlign.start,
                                        fontFamily: cPoppins,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                        color: Color(0xffB54708),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          globalBloc.hideSnackBar(main: true);

                                          NavigatorHelper().navigateTo(
                                              '/add_postal_code_view');
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              width: 5.5.w,
                                              height: 3.8.h,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    APPColors.appBlack,
                                                child: Icon(
                                                  Icons.add_outlined,
                                                  size: 15,
                                                  color:
                                                      APPColors.appPrimaryColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            RabbleText.subHeaderText(
                                              text: 'Add postcode',
                                              fontFamily: cPoppins,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
                            }
                          });
                    }

                    return Padding(
                      padding: PagePadding.custom(1.5.w, 0, 3.w, 5.w),
                      child: Column(
                        children: [
                          RabbleText.subHeaderText(
                            text:
                                'This is a list of teams you are the member of',
                            color: APPColors.appBlack,
                            fontFamily: cPoppins,
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  userTeamModel.HostTeamData data =
                                      snapshot.data![index];

                                  return BuyingTeamItemWidget(
                                    isVertical: true,
                                    teamId: data.id,
                                    image: data.team!.imageUrl,
                                    teamName: data.team!.name,
                                    postalCode: data.team!.postalCode ?? '',
                                    busniessName:
                                        data.team!.producer!.businessName,
                                    status: bloc.getStatus(data.team!.members!),
                                    callBack: () {
                                      if (data.team!.basket!.isEmpty) {
                                        ProducerDetail producerDetail =
                                            ProducerDetail(
                                                imageUrl: data
                                                    .team!.producer!.imageUrl,
                                                id: data.team!.producer!.id,
                                                businessName: data.team!
                                                    .producer!.businessName,
                                                businessAddress:
                                                    data.team!.producer!
                                                        .businessAddress,
                                                website: data
                                                    .team!.producer!.website,
                                                categories: data.team!.producer!
                                                    .categories!,
                                                count: data.team!.count);

                                        Map body = {
                                          'type': true,
                                          'data': producerDetail,
                                          'id':producerDetail.id,
                                          'team': TeamData(
                                            id: data.team!.id,
                                            name: data.team!.name,
                                            producer: data.team!.producer,
                                            producerId: data.team!.producerId,
                                          )
                                        };

                                        BuyingTeamCreationService().addTeamCreationData(mFrequency, data.team!.frequency!.toInt());

                                        RabbleStorage.setInivitationData(
                                            json.encode(InvitationData(
                                                producerInfo:
                                                    data.team!.producer,
                                                teamId: data.teamId,
                                                teamName: data.team!.name)));

                                        NavigatorHelper()
                                            .navigateTo('/producer', body);
                                      }
                                      else {
                                        Map map = {
                                          'teamId': data.team!.id,
                                          'type': '1',
                                          'teamName': data.team!.name
                                        };

                                        Navigator.pushNamed(
                                                context, '/threshold_view',
                                                arguments: map)
                                            .then((value) {
                                          bloc.fetchMemberTeams();
                                        });
                                      }
                                    },
                                    frequency: Conversation.getFrequencyText(
                                        data.team!.frequency!.toInt()),
                                    category: data.team!.producer!.categories !=
                                                null &&
                                            data.team!.producer!.categories!
                                                .isNotEmpty &&
                                            data.team!.producer!.categories!
                                                    .first.category !=
                                                null
                                        ? data.team!.producer!.categories!.first
                                            .category!.name
                                        : '',
                                    nextDelivery:
                                        'Next delivery ${data.team!.nextDeliveryDate != null ? '${int.parse(DateFormatUtil.countDays(data.team!.nextDeliveryDate!)) < 7 ? "in ${DateFormatUtil.countDays(data.team!.nextDeliveryDate!)} ${int.parse(DateFormatUtil.countDays(data.team!.nextDeliveryDate!)) < 2 ? "day" : "days"}" : DateFormatUtil.formatDate(data.team!.nextDeliveryDate!, 'dd MMM yyyy')} ' : 'date TBD'}',
                                    producerName:
                                        '${data.team!.host!.firstName ?? ''} ${data.team!.host!.lastName ?? ''}',
                                    totalTeamMembers: data.team!.members == null
                                        ? '0'
                                        : data.team!.members!.length.toString(),
                                    hostName:
                                        '${data.team!.host!.firstName ?? ''} ${data.team!.host!.lastName ?? ''}',
                                    callBackIfUpdated: () {
                                      bloc.fetchMemberTeams();
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
                  });
        });
  }
}
