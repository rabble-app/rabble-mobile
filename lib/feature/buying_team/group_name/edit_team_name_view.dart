import '../../../config/export.dart';

class EditNameView extends StatelessWidget {
  EditNameView({Key? key}) : super(key: key);

  final TextEditingController _groupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map teamData =  ModalRoute.of(context)!.settings.arguments as Map;

    return CubitProvider<RabbleBaseState, BuyingTeamCubit>(
        create: (BuildContext context) => BuyingTeamCubit(),
        builder: (BuildContext context, RabbleBaseState state,
            BuyingTeamCubit bloc) {
          return CreateGroupNameView(isEdit: true,teamName: teamData['teamName'],teamId: teamData['teamId'],producerName: teamData['producerName'],);
        });
  }
}
