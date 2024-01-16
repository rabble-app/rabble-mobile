import 'package:rabble/config/export.dart';

class MyBuyingTeamWidget extends StatefulWidget {
  const MyBuyingTeamWidget( {Key? key}) : super(key: key);

  @override
  State<MyBuyingTeamWidget> createState() => _MyBuyingTeamWidgetState();
}

class _MyBuyingTeamWidgetState extends State<MyBuyingTeamWidget> {

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, BuyingTeamCubit>(
        create: (context) => BuyingTeamCubit(fetchBuyingTeam: true),
        builder: (context, state, bloc) {
          return state.secondaryBusy
              ? const SizedBox.shrink()
              : BehaviorSubjectBuilder<String>(
                subject: PostalCodeService().postalCodeGlobalSubject,
                builder: (BuildContext context,
                    AsyncSnapshot<String> buyingTeamSnapshot) {
                  return Column(
                      children: [
                        ViewAllWidget(
                          title: '$kYour $kBuyingTeams',
                          showViewAllBtn: true,
                          callback: () {},
                        ),
                        BehaviorSubjectBuilder<List<BuyingTeamDetail>>(
                            subject: bloc.buyingTeamListSubject$,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return const Empty();
                              List<BuyingTeamDetail> buyingTeamList =
                                  snapshot.data!;
                              if (buyingTeamList.isEmpty) return  Empty(msg: '$kNoBuygintTeamNear ${buyingTeamSnapshot.data}',);

                              return SizedBox(
                                height: 43.h,
                                child:  ListView.builder(
                                    itemCount: buyingTeamList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return MyBuyingTeamItemWidget(
                                          buyingTeamDetail: buyingTeamList[index],);
                                    }),
                              );
                            })
                      ],
                    );
                }
              );
        });
  }
}
