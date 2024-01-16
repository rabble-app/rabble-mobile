import '../../../config/export.dart';

class MessagesListWidget extends StatelessWidget {
  final List<TeamChatData> list;

  const MessagesListWidget(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          TeamChatData teamChatData = list[index];
          return MessageItemWidget(teamChatData);
        });
  }
}
