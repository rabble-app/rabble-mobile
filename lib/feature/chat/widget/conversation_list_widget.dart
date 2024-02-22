

import '../../../config/export.dart';

class ConversationListWidget extends StatelessWidget {
  final List<ConversationData> conversationList;
  final String myId;

  const ConversationListWidget(this.conversationList, this.myId, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: conversationList.length,
        shrinkWrap: true,
        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: PagePadding.horizontalSymmetric(2.w),
        itemBuilder: (context, index) {
          ConversationData conversationData = conversationList[index];
          return conversationData.userId == myId
              ? SenderChip(data: conversationData)
          :ReceiverChip(
                  index: index, data: conversationData,
                );

        });
  }
}
