import 'package:rabble/domain/entities/RequestSendModel.dart';
import 'package:rabble/domain/entities/hub/AllPartnerTeamsModel.dart';
import 'package:rabble/domain/entities/mock/mock_hub_model.dart';
import 'package:rabble/feature/hub/hub_cubit.dart';
import 'package:rabble/feature/producer/widget/producer_item_shimmer.dart';

import '../../../core/config/export.dart';

class HubListWidget extends StatelessWidget {
  final bool? isHorizontal;
  final bool? showViewAll;
  final String? id;

  const HubListWidget(
      {super.key, this.isHorizontal, this.showViewAll = true, this.id});

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, ExploreCubit>(
        create: (context) => ExploreCubit()..fetchPartners(),
        builder: (context, state, bloc) {
          return state.secondaryBusy && isHorizontal!
              ? SizedBox(
                  height: context.allHeight * 0.33,
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const ProducerItemShimmer();
                      }),
                )
              : state.secondaryBusy && !isHorizontal!
                  ? ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const ProducerItemShimmer();
                      })
                  : BehaviorSubjectBuilder<List<PartnersTeamData>>(
                      subject: bloc.partnerListSubject$,
                      builder: (context, snapshot) {
                        return isHorizontal!
                            ? Column(
                                children: [
                                  if (showViewAll! && snapshot.data!.isNotEmpty)
                                    Container(
                                      margin:
                                          PagePadding.custom(3.w, 3.w, 0, 0),
                                      child: ViewAllWidget(
                                        title: kRabbleHubs,
                                        showViewAllBtn: true,
                                        callback: () {
                                          NavigatorHelper()
                                              .navigateTo('/AllPartnersTeams');
                                        },
                                      ),
                                    ),
                                  SizedBox(
                                    height: context.allHeight * 0.35,
                                    width: context.allWidth,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data?.length,
                                        physics: const ClampingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          PartnersTeamData? partnerData =
                                              snapshot.data?[index];
                                          bloc.calculateDistanceFromPostalCode(
                                              partnerData!.postalCode ?? '',
                                              index);

                                          return HubWidget(
                                            teamId: partnerData.id,
                                            isHorizontal: isHorizontal,
                                            teamName:
                                                '${partnerData.name}',
                                            frequency:
                                                Conversation.getFrequencyText(
                                                    partnerData.frequency!
                                                        .toInt()),
                                            totalTeamMembers: partnerData
                                                .members?.length
                                                .toString(),
                                            category: partnerData
                                                .producer
                                                ?.categories
                                                ?.first
                                                .category
                                                ?.name,
                                            nextDelivery: DateFormatUtil
                                                .getNextDeliveryDate(
                                                    partnerData
                                                        .nextDeliveryDate,
                                                    partnerData.frequency!
                                                        .toInt()),
                                            isVertical: false,
                                            postalCode: partnerData.postalCode,
                                            callBack: () {
                                              NavigatorHelper()
                                                  .navigateTo('/PartnerTeam');
                                            },
                                            callBackIfUpdated: () {},
                                          );
                                        }),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  PartnersTeamData? partnerData =
                                      snapshot.data?[index];

                                  bloc.calculateDistanceFromPostalCode(
                                      partnerData!.postalCode ?? '', index);

                                  return HubWidget(
                                    teamId: partnerData.id,
                                    isHorizontal: isHorizontal,
                                    teamName:
                                        '${partnerData.name}',
                                    frequency: Conversation.getFrequencyText(
                                        partnerData.frequency!.toInt()),
                                    totalTeamMembers:
                                        partnerData.members?.length.toString(),
                                    category: partnerData.producer!.categories!.isNotEmpty? partnerData.producer?.categories
                                        ?.first.category?.name:'',
                                    nextDelivery:
                                        DateFormatUtil.getNextDeliveryDate(
                                            partnerData.nextDeliveryDate,
                                            partnerData.frequency!.toInt()),
                                    isVertical: false,
                                    callBack: () {
                                      NavigatorHelper()
                                          .navigateTo('/PartnerTeam');
                                    },
                                    callBackIfUpdated: () {},
                                  );
                                });
                      });
        });
  }
}
