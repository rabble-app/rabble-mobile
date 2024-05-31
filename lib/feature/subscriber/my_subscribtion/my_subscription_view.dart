import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';

import '../../../domain/entities/MySubscriptionModel.dart' as My;
import '../../../domain/entities/UserTeamModel.dart';
import '../../buying_team/widget/buying_team_item_shimmer.dart';

class MySubscriptionsView extends StatelessWidget {
  const MySubscriptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, AllBuyingTeamsCubit>(
        create: (context) => AllBuyingTeamsCubit()..fetchUserData()..fetchMuSubscribtion(),
        builder: (context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bg_app_primary,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(9.h),
                child: RabbleAppbar(
                  leadingWidth: 21.w,
                  backgroundColor: APPColors.bg_app_primary,
                  title: kYourSubscriptions,
                )),
            body: state.primaryBusy
                ? ListView.builder(
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return const BuyingTeamItemShimmer();
                    })
                : BehaviorSubjectBuilder<List<My.MySubscriptionData>>(
                    subject: bloc.mySubscriptionListSubject$,
                    builder: (context, snapshot) {
                      print('snapshot.data ${snapshot.data}');

                      if (snapshot.data == null && !state.primaryBusy) {
                        return Container(
                          padding: PagePadding.onlyBottom(10.w),
                          child: EmptyStateWidget(
                              heading: kNotMemberAnyTeam,
                              subHeading: kNoMemberHint,
                              svg: Assets.svgs.member_empty,
                              isBasket: true,
                              btnHeading: kShowingBuyingTeamNearYou,
                              callback: () {}),
                        );
                      }

                      if (snapshot.data!.isEmpty) {
                        return Container(
                          padding: PagePadding.onlyBottom(10.w),
                          child: EmptyStateWidget(
                              heading: kNotMemberAnyTeam,
                              subHeading: kNoMemberHint,
                              svg: Assets.svgs.member_empty,
                              isBasket: true,
                              btnHeading: kShowingBuyingTeamNearYou,
                              callback: () {
                                NavigatorHelper()
                                    .navigateTo('/all_buying_teams_view', {});
                              }),
                        );
                      }

                      return Padding(
                        padding: PagePadding.custom(2.w, 1.w, 0, 0),
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              My.MySubscriptionData data =
                                  snapshot.data![index];
                              return BuyingTeamItemWidget(
                                isVertical: false,
                                teamId: data.team!.id,
                                teamName: data.team!.name ?? '',
                                postalCode: data.team!.postalCode ?? '',
                                image: data.team!.imageUrl ?? '',
                                busniessName: data.team!.producer!.businessName,
                                status: bloc.userDataSubject$.value.id ==
                                        data.team!.hostId
                                    ? ''
                                    : getStatus(
                                        snapshot.data![index].team!.members,
                                        snapshot.data![index].team!.requests,
                                        bloc),
                                frequency: Conversation.getFrequencyText(
                                    data.team!.frequency!.toInt()),
                                category:
                                    data.team!.producer!.categories != null &&
                                            data.team!.producer!.categories!
                                                .isNotEmpty &&
                                            data.team!.producer!.categories!
                                                    .first.category !=
                                                null
                                        ? data.team!.producer!.categories!.first
                                            .category!.name
                                        : '',
                                nextDelivery:
                                DateFormatUtil.getNextDeliveryDate(
                                    data.team!.nextDeliveryDate, data.team!.frequency!.toInt()),
                                producerName:
                                    '${data.team!.host!.firstName ?? ''} ${data.team!.host!.lastName ?? ''}',
                                totalTeamMembers: data.team!.members == null
                                    ? '0'
                                    : data.team!.members!.length.toString(),
                                hostName:
                                    '${data.team!.host!.firstName ?? ''} ${data.team!.host!.lastName ?? ''}',
                                callBack: () {
                                  if (data.team!.orders!.isNotEmpty) {
                                    if (data
                                        .team!.orders!.first.basket!.isEmpty) {
                                      ProducerDetail producerDetail =
                                          ProducerDetail(
                                              imageUrl:
                                                  data.team!.producer!.imageUrl,
                                              id: data.team!.producer!.id,
                                              businessName: data
                                                  .team!.producer!.businessName,
                                              businessAddress: data.team!
                                                  .producer!.businessAddress,
                                              website:
                                                  data.team!.producer!.website,
                                              categories: data
                                                  .team!.producer!.categories!,
                                              count:
                                                  data.team!.producer!.count);

                                      Map body = {
                                        'type': true,
                                        'data': producerDetail,
                                        'id': producerDetail.id,
                                        'team': TeamData(
                                          id: data.team!.id,
                                          name: data.team!.name,
                                          producerId: data.team!.producerId,
                                        )
                                      };
                                      BuyingTeamCreationService()
                                          .addTeamCreationData(mFrequency,
                                              data.team!.frequency!.toInt());

                                      RabbleStorage().setInivitationData(
                                          json.encode(InvitationData(
                                              producerInfo: data.team!.producer,
                                              teamId: data.team!.id,
                                              teamName: data.team!.name)));

                                      NavigatorHelper()
                                          .navigateTo('/producer', body);
                                    } else {
                                      Map map = {
                                        'teamId': data.team!.id,
                                        'type': '1',
                                        'teamName': data.team!.name
                                      };

                                      Navigator.pushNamed(
                                              context, '/threshold_view',
                                              arguments: map)
                                          .then((value) {});
                                    }
                                  } else {
                                    Map map = {
                                      'teamId': data.team!.id,
                                      'type': '1',
                                      'teamName': data.team!.name
                                    };

                                    Navigator.pushNamed(
                                            context, '/threshold_view',
                                            arguments: map)
                                        .then((value) {});
                                  }
                                },
                                callBackIfUpdated: () {
                                  bloc.fetchAllBuyingTeamsForPostalCode();
                                },
                              );
                            }),
                      );
                    }),
          );
        });
  }

  getStatus(List<Members>? members, List<RequestSendData>? requests,
      AllBuyingTeamsCubit bloc) {
    Members? member = members!.firstWhere(
        (element) => element.userId == bloc.userDataSubject$.value.id,
        orElse: () => Members());
    if (member != null && member.id != null) {
      return member.status;
    } else {
      if (requests != null) {
        RequestSendData? request = requests.firstWhere(
            (element) => element.userId == bloc.userDataSubject$.value.id,
            orElse: () => RequestSendData());
        if (request != null && request.id != null) {
          return request.status;
        } else
          return '';
      }

      return '';
    }
  }
}
