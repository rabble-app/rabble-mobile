import 'package:rabble/domain/entities/TeamDetailChatModel.dart';

import '../../core/config/export.dart';

class TeamListView extends StatelessWidget {
  const TeamListView({super.key});

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    List<ChatMembers> teamList = data['list'];
    return Scaffold(
      backgroundColor: APPColors.bgColor,
      body: Column(
        children: [
          RabbleAppbar(
            leadingWidth: 25.w,
            title: data['name'],
          ),
          Expanded(
              child: ListView.builder(
            itemCount: teamList.length,
            padding: PagePadding.all(3.w),
            itemBuilder: (context, index) {
              ChatMembers memberData = teamList[index];
              return MemberProfileView(
                imageUrl: memberData.user!.imageUrl,
                isNormalPage: true,
                teamName:
                    '${memberData.user!.firstName ?? ''} ${memberData.user!.lastName!.length >= 1 ? data['hostId'] == memberData.user!.id ? memberData.user!.lastName : memberData.user!.lastName![0] : ''}',
                isHost: data['hostId'] == memberData.user!.id,
                orderId: '',
              );
            },
          ))
        ],
      ),
    );
  }
}
