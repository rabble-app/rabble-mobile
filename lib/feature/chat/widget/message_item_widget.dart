import '../../../config/export.dart';

class MessageItemWidget extends StatelessWidget {
  final TeamChatData teamChatData;
  final ChatRoomCubit bloc;

  const MessageItemWidget(this.teamChatData, this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Map map = {
          'teamName': teamChatData.team!.name,
          'teamId': teamChatData.team!.id,
        };
        NavigatorHelper().navigateTo('/chat_room', map).then((value){
          bloc.fetchTeamChatList();
        });
      },
      child: Padding(
        padding: PagePadding.custom(4.w, 4.w, 5.w, 0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: context.allWidth * 0.18,
                    height: context.allHeight * 0.08,
                    child: RabbleImageLoader(
                      fit: BoxFit.cover,
                      imageUrl: teamChatData.team!.imageUrl!,
                      isRound: false,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                SizedBox(
                  width: context.allWidth * 0.58,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.w,
                      ),
                      RabbleText.subHeaderText(
                        text: teamChatData.team!.name,
                        fontFamily: cGosha,
                        color: APPColors.appBlack4,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: 1.w,
                      ),
                      SizedBox(
                        width: context.allWidth * 0.58,
                        child: RabbleText.subHeaderText(
                          text: teamChatData.team!.chats!.isEmpty
                              ? 'Start the conversation'
                              : '${teamChatData.team!.chats!.last.user!.firstName}: ${teamChatData.team!.chats!.last.text}',
                          textAlign: TextAlign.start,
                          fontFamily: cPoppins,
                          color: APPColors.appBlack4,
                          fontSize: 8.5.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.w,
                    ),
                    if (teamChatData.team!.chats!.isNotEmpty)
                      RabbleText.subHeaderText(
                        text: teamChatData.team!.chats!.last.createdAt != null
                            ? DateFormatUtil.formatMessageTime(DateTime.parse(
                                teamChatData.team!.chats!.last.createdAt
                                    .toString()))
                            : '',
                        fontFamily: cPoppins,
                        color: APPColors.appTextPrimary,
                        fontSize: 7.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    SizedBox(
                      height: 2.w,
                    ),
                    // Container(
                    //   width: context.allWidth * 0.065,
                    //   height: context.allWidth * 0.065,
                    //   decoration: const BoxDecoration(
                    //     color: APPColors.appBlack,
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: Center(
                    //     // Added Center widget to ensure the text is in the center
                    //     child: RabbleText.subHeaderText(
                    //       text: '3',
                    //       fontSize: 9.sp,
                    //       height: 1.3,
                    //       // Adjusted the height to its default value
                    //       color: APPColors.appPrimaryColor,
                    //       fontFamily: cPoppins,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            const Divider(
              color: APPColors.bg_grey25,
              thickness: 0.5,
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
