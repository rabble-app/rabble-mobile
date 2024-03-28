import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';

class MyTeamRequestListView extends StatelessWidget {
  MyTeamRequestListView({super.key});


  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;

    List<RequestSendData>? requestList = data['request'];

    TeamViewCubit cubit = data['bloc'];

    cubit.myRequestListSubject$.sink.add(requestList!);

    return CubitProvider<RabbleBaseState, TeamViewCubit>(
        create: (context) => cubit,
        builder: (context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bgColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(9.h),
              child: RabbleAppbar(
                backTitle: kBack,
                title: 'Manage Requests',
                leadingWidth: 20.w,
              ),
            ),
            body: SafeArea(
              child: BehaviorSubjectBuilder<List<RequestSendData>>(
                  subject: bloc.myRequestListSubject$,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Empty();
                    if (snapshot.data!.isEmpty) return const Empty();
                    return Padding(
                      padding: PagePadding.all(3.w),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return RequestItemWidget(
                              snapshot.data![index],
                              joinCallBack: (RequestSendData request) async {
                                bool res = await bloc.onUpdateTeam(
                                    request.teamId, request.id, 'APPROVED');
                                if (res) {
                                  List<RequestSendData> requestList = snapshot.data!;
                                  requestList.remove(request);
                                  bloc.myRequestListSubject$.add(requestList);
                                }
                              },
                              removeCallBack: (RequestSendData request) async {
                                bool res = await bloc.onUpdateTeam(
                                    request.teamId, request.id, 'REJECTED');
                                if (res) {
                                  List<RequestSendData> requestList = snapshot.data!;
                                  requestList.remove(request);
                                  bloc.myRequestListSubject$.add(requestList);
                                }
                              },
                              teamName: data['teamName'],
                            );
                          }),
                    );
                  }),
            ),
          );
        });
  }
}
