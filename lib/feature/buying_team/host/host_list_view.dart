import 'package:rabble/config/export.dart';
import 'package:rabble/feature/buying_team/widget/buying_team_item_shimmer.dart';

class HostListView extends StatelessWidget {
  const HostListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, HostTeamCubit>(
        create: (context) => HostTeamCubit(),
        builder: (ctx, state, bloc) {
          return state.primaryBusy
              ? ListView.builder(
              itemCount: 10,
              padding: PagePadding.custom(1.w, 0, 3.w, 5.w),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const BuyingTeamItemShimmer();
              })
              : BehaviorSubjectBuilder<List<BuyingTeamDetail>>(
              subject: bloc.hostTeamListSubject$,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return EmptyStateWidget(
                      heading: kYourHostedBuyingTeams,
                      subHeading: kNoHostedBuyingTeam,
                      svg: Assets.svgs.host_empty,
                      btnHeading: '',
                      callback: () {});
                }

                if (snapshot.data!.isEmpty) {
                  return EmptyStateWidget(
                      heading: kYourHostedBuyingTeams,
                      subHeading: kNoHostedBuyingTeam,
                      svg: Assets.svgs.host_empty,
                      btnHeading: '',
                      callback: () {});
                }

                return Padding(
                  padding: PagePadding.custom(1.5.w, 0, 3.w, 5.w),
                  child: Column(
                    children: [
                      RabbleText.subHeaderText(
                        text: 'This is a list of teams you are the host of',
                        color: APPColors.appBlack,
                        fontFamily: cPoppins,
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),

                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            physics: snapshot.data!.length == 1
                                ? ClampingScrollPhysics()
                                : ScrollPhysics(),
                            padding: PagePadding.onlyBottom(
                                context.allHeight * 0.09),
                            itemBuilder: (context, index) {
                              BuyingTeamDetail data =
                              snapshot.data![index];

                              return BuyingTeamItemWidget(
                                isVertical: true,
                                teamId: data.id,
                                teamName: data.name,
                                image: data.imageUrl,
                                postalCode: data.postalCode ?? '',
                                busniessName: data.producer!.businessName,
                                frequency:
                                Conversation.getFrequencyText(
                                    data.frequency!.toInt()),
                                category:
                                data.producer!.categories != null &&
                                    data.producer!.categories!
                                        .isNotEmpty &&
                                    data.producer!.categories!.first
                                        .category !=
                                        null
                                    ? data.producer!.categories!.first
                                    .category!.name
                                    : '',
                                nextDelivery:
                                'Next delivery ${data.nextDeliveryDate != null
                                    ? '${int.parse(DateFormatUtil.countDays(
                                    data.nextDeliveryDate!)) < 7
                                    ? "in ${DateFormatUtil.countDays(
                                    data.nextDeliveryDate!)} ${int.parse(DateFormatUtil.countDays(data.nextDeliveryDate!)) < 2 ? "day" : "days"}"
                                    : DateFormatUtil.formatDate(data.nextDeliveryDate!, 'dd MMM yyyy')} '
                                    : 'date TBD'}',
                                producerName:
                                '${data.host!.firstName ?? ''} ${data.host!
                                    .lastName ?? ''}',
                                totalTeamMembers: data.members == null
                                    ? '0'
                                    : data.members!.length.toString(),
                                hostName:
                                '${data.host!.firstName ?? ''} ${data.host!
                                    .lastName ?? ''}',
                                callBackIfUpdated: () {
                                  bloc.fetchHost();
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
