import 'package:rabble/core/config/export.dart';

class ExistingBuyingTeamsView extends StatelessWidget {
  const ExistingBuyingTeamsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;

    return CubitProvider<RabbleBaseState, AllBuyingTeamsCubit>(
        create: (context) => AllBuyingTeamsCubit(),
        builder: (context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bg_app_primary,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(8.h),
                child: RabbleAppbar(
                  leadingWidth: 25.w,
                  title: kBuyingTeams,
                )),
            body: BehaviorSubjectBuilder<UserModel>(
                subject: bloc.userDataSubject$,
                builder: (context, userSnapshot) {
                  return Padding(
                    padding: PagePadding.custom(2.w, 0, 0, 0),
                    child: SingleChildScrollView(
                      child: BuyingTeamWidget(
                        id: userSnapshot.hasData ? userSnapshot.data!.id : '',
                        isHorizontal: false,
                        showViewAll: false,
                        heading: '',
                        showLoader: state.primaryBusy,
                        teamList: data['teams'],
                        callBackIfUpdated: () {
                          bloc.checkTeamExist(
                              context, data['name'], data['producerId']);
                        },
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
