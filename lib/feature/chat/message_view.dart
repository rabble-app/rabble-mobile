import 'package:rabble/feature/producer/widget/producer_item_shimmer.dart';

import '../../config/export.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, ChatRoomCubit>(
        create: (context) => ChatRoomCubit()..fetchTeamChatList(),
        builder: (context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.appBlack,
            body: Column(
              children: [
                SearchWidget(
                  title: kSearch,
                  searchCubit: SearchCubit(),
                  callBack: () {
                    NavigatorHelper().navigateTo('/search_product_view');
                  },
                ),
                SizedBox(height: 1.5.h),
                state.primaryBusy
                    ? Expanded(
                      child: Container(
                          color: APPColors.bgColor,
                          child: ListView.builder(
                              itemCount: 50,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return const ProducerItemShimmer();
                              }),
                        ),
                    )
                    : Expanded(
                      child: Container(
                          color: APPColors.bgColor,
                          height: context.allHeight,
                          child: BehaviorSubjectBuilder<List<TeamChatData>>(
                              subject: bloc.teamChatListSubject$,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return EmptyStateWidget(
                                      heading: kJoinTeamandbuytogether,
                                      subHeading:
                                          kDiscovergreatproductsfromsmall,
                                      svg: Assets.svgs.message_empty,
                                      btnHeading: 'Join Teams',
                                      callback: () {
                                        NavigatorHelper().navigateTo(
                                            '/all_buying_teams_view', {});
                                      });
                                }
                                if (snapshot.data!.isEmpty) {
                                  return Expanded(
                                    child: EmptyStateWidget(
                                        heading: kJoinTeamandbuytogether,
                                        subHeading:
                                            kDiscovergreatproductsfromsmall,
                                        svg: Assets.svgs.message_empty,
                                        btnHeading: 'Join Teams',
                                        callback: () {
                                          NavigatorHelper().navigateTo(
                                              '/all_buying_teams_view', {});
                                        }),
                                  );
                                }
                                return  MessagesListWidget(snapshot.data!);
                              })),
                    )
              ],
            ),
          );
        });
  }
}
