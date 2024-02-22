import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/TeamDetailChatModel.dart';

class ChatRoomAppbar extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? backTitle;
  final String? teamId;
  final String? hostId;
  final List<Widget>? action;
  final Color? backgroundColor;
  final bool? hideLeading;
  final double? leadingWidth;
  final Widget? icon;
  final List<ChatMembers> memeberList;
  final VoidCallback callBack;

  const ChatRoomAppbar({
    Key? key,
    this.title,
    this.subTitle,
    this.backTitle,
    this.icon,
    this.hostId,
    this.action,
    this.backgroundColor,
    this.hideLeading,
    this.leadingWidth,
    required this.memeberList,
    required this.callBack, this.teamId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: APPColors.appBlack,
      height: context.allHeight * 0.13,
      padding: PagePadding.onlyTop(6.h),
      child: Stack(
        children: [
          InkWell(
            onTap: () async {
              callBack.call();
            },
            child: Padding(
              padding: PagePadding.custom(0, 3.w, 4.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Assets.svgs.arrowLeft.svg(height: 2.5.h),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  RabbleText.subHeaderText(
                    text: backTitle ?? kBack,
                    color: APPColors.appPrimaryColor,
                    fontFamily: cGosha,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Map map = {
                'teamId': teamId,
                'type': '1',
                'teamName': title
              };

              Navigator.pushNamed(context, '/threshold_view',
                  arguments: map);
            },
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: context.allWidth * 0.5,
                    margin: PagePadding.onlyTop(1.w),
                    child: RabbleText.subHeaderText(
                      text: title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontFamily: cPoppins,
                      color: APPColors.appPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: context.allWidth * 0.5,
                    child: RabbleText.subHeaderText(
                      text: subTitle,
                      maxLines: 1,
                      fontFamily: cPoppins,
                      color: APPColors.appPrimaryColor1,
                      fontWeight: FontWeight.w600,
                      fontSize: 8.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (memeberList.isNotEmpty)
            GestureDetector(
              onTap: () {
                Map data = {
                  'list': memeberList,
                  'name': title,
                  'hostId': hostId,
                };
                NavigatorHelper().navigateTo('/team_list_view', data);
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: PagePadding.onlyTop(3.w),
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.035,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: memeberList.length,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        ChatMembers memberData = memeberList[index];
                        List<String> text =
                            '${memberData.user!.firstName ?? ''} ${memberData.user!.lastName ?? ''}'
                                .split(' ');

                        String firstCharName1 = '';
                        String firstCharName2 = '';

                        String combination2 = '';

                        if (text.isNotEmpty) {
                          firstCharName1 = text[0];
                          firstCharName2 =
                              text.length > 1 ? text[1] : " "; // Change 2 to 1


                          combination2 =
                              '${firstCharName1.length > 0 ? firstCharName1[0] : '' ?? ''}${firstCharName2.length > 0 ? firstCharName2[0] : '' ?? ''}';
                        }

                        if (index < 3) {
                          return memberData.user!.imageUrl!.isNotEmpty
                              ? Container(
                                  width: context.allWidth * 0.08,
                                  height: context.allWidth * 0.08,
                                  transform: Matrix4.translationValues(
                                      double.parse((-7 * index).toString()),
                                      0,
                                      0),
                                  child: RabbleImageLoader(
                                    imageUrl: memberData.user!.imageUrl!,
                                    isRound: true,
                                    roundValue: 15,
                                  ))
                              : Container(
                                  transform: Matrix4.translationValues(
                                      double.parse((-7 * index).toString()),
                                      0,
                                      0),
                                  width: context.allWidth * 0.08,
                                  height: context.allWidth * 0.08,
                                  decoration: ContainerDecoration.boxDecoration(
                                      bg: APPColors.appBlack,
                                      border: APPColors.appGrey,
                                      radius: 40,
                                      width: 0.2),
                                  child: Center(
                                    child: RabbleText.subHeaderText(
                                      text: combination2,
                                      fontSize: 10.sp,
                                      fontFamily: cGosha,
                                      fontWeight: FontWeight.w500,
                                      color: APPColors.appPrimaryColor,
                                    ),
                                  ),
                                );
                        } else {
                          return Container(
                            transform: Matrix4.translationValues(
                                double.parse((-7 * index).toString()), 0, 0),
                            width: context.allWidth * 0.08,
                            height: context.allWidth * 0.08,
                            decoration: ContainerDecoration.boxDecoration(
                                bg: APPColors.appBlack,
                                border: APPColors.appBlack,
                                radius: 40),
                            child: Center(
                              child: RabbleText.subHeaderText(
                                text: '+${memeberList.length - 2}',
                                fontSize: 10.sp,
                                fontFamily: cGosha,
                                fontWeight: FontWeight.w500,
                                color: APPColors.appPrimaryColor,
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ),
            )
        ],
      ),
    );
  }
}
