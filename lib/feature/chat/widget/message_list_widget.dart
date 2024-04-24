import '../../../config/export.dart';

class MessagesListWidget extends StatelessWidget {
  final List<TeamChatData> list;
  final ChatRoomCubit bloc;

  const MessagesListWidget(this.list, this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          TeamChatData teamChatData = list[index];
          return MessageItemWidget(teamChatData,bloc);
        });
  }
}
