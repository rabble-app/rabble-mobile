import '../../../config/export.dart';

class EditTeamIntroductionView extends StatelessWidget {
  EditTeamIntroductionView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Map teamData =  ModalRoute.of(context)!.settings.arguments as Map;

    return CubitProvider<RabbleBaseState, BuyingTeamCubit>(
        create: (BuildContext context) => BuyingTeamCubit(),
        builder: (BuildContext context, RabbleBaseState state,
            BuyingTeamCubit bloc) {
          return ToucheDetector(
            child: PersonaliseGroupView(isEdit: true,teamDesc: teamData['teamName'],teamId: teamData['teamId'],frequency: teamData[mFrequency],producerName: teamData[mProducerName],),
          );
        });
  }
}
