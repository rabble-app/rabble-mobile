import 'package:rabble/config/export.dart';

class AllBuyingTeamsView extends StatelessWidget {
  const AllBuyingTeamsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;

    return CubitProvider<RabbleBaseState, AllBuyingTeamsCubit>(
        create: (context) =>
            AllBuyingTeamsCubit()..fetchUserData().. fetchAllYourBuyingTeams(data['id']!=null? data['id']! : ''),
        builder: (context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bg_app_primary,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(8.h),
                child: RabbleAppbar(
                  leadingWidth: 25.w,
                  title: data['id'] != null ? data['name'] : kBuyingTeams,
                )),
            body: BehaviorSubjectBuilder<List<BuyingTeamDetail>>(
                subject: bloc.allTeamListSubject$,
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.isEmpty) {
                    return EmptyStateWidget(
                        heading: kNotMemberAnyTeam,
                        subHeading: kNoMemberHint,
                        svg: Assets.svgs.member_empty,
                        btnHeading: '',
                        callback: () {

                        });
                  }

                  return BehaviorSubjectBuilder<UserModel>(
                    subject: bloc.userDataSubject$,
                    builder: (context, userSnapshot) {
                      return Padding(
                        padding: PagePadding.custom(2.w, 0, 0, 0),
                        child: SingleChildScrollView(
                          controller: bloc.scrollController,
                          child: Column(
                            children: [
                              BuyingTeamWidget(
                                id: userSnapshot.hasData
                                    ? userSnapshot.data!.id
                                    : '',
                                isHorizontal: false,
                                showViewAll: false,
                                heading: '',
                                showLoader: state.primaryBusy,
                                teamList: snapshot.hasData ? snapshot.data! : [],
                                callBackIfUpdated: () {
                                  if(data['id']!=null) {
                                    bloc.fetchAllYourBuyingTeams(data['id']!=null? data['id']! : '');
                                  }else{
                                    bloc.fetchAllBuyingTeamsForPostalCode();
                                  }
                                },
                              ),
                              if(state.tertiaryBusy)
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      transform: Matrix4.translationValues(0, -6.h, 0),
                                      child: const RabbleSecondaryScreenProgressIndicator(
                                          enabled: true),
                                    ))
                            ],
                          ),
                        ),
                      );
                    }
                  );
                }),
          );
        });
  }
}
