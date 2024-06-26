import 'package:rabble/core/config/export.dart';

class HostInfoWidget extends StatelessWidget {
  const HostInfoWidget({
    super.key,
    required this.avatar,
    required this.user,
    required this.associateMembers,
    required this.delivers,
    required this.introText,
    required this.memberSince,
    required this.percentage,
    required this.showMemmbers,
    required this.firstName,
    required this.lastName,
    this.currentUserId,
    required this.hostId,
    this.label,
  });

  final String user;
  final String firstName;
  final String lastName;
  final String avatar, memberSince;
  final int delivers;
  final String? currentUserId;
  final String percentage;
  final bool showMemmbers;
  final String hostId;
  final String? label;

  final String introText;
  final List<Members> associateMembers;

  @override
  Widget build(BuildContext context) {
    String combination = '${firstName.trim()} ${lastName.trim()}'.initials;

    return Padding(
      padding: PagePadding.custom(3.w, 3.w, 2.h, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  avatar.isNotEmpty &&
                          avatar !=
                              'https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/img.png'
                      ? SizedBox(
                          width: 65,
                          height: 65,
                          child: RabbleImageLoader(
                              isRound: true, imageUrl: avatar ?? ''),
                        )
                      : SizedBox(
                          width: 65,
                          height: 65,
                          child: CircleAvatar(
                            backgroundColor: APPColors.appBlack,
                            child: RabbleText.subHeaderText(
                              text: combination,
                              fontSize: 17.sp,
                              color: APPColors.appPrimaryColor,
                            ),
                          ),
                        ),
                  Container(
                    height: 2.8.h,
                    transform: Matrix4.translationValues(0, -10, 0),
                    padding: PagePadding.horizontalSymmetric(1.5.w),
                    decoration: ContainerDecoration.boxDecoration(
                      bg: APPColors.appYellow,
                      border: APPColors.appYellow,
                      radius: 24,
                    ),
                    child: Center(
                      child: RabbleText.subHeaderText(
                        text: label ?? kHost2,
                        color: APPColors.appBlack,
                        height: 1,
                        fontFamily: cPoppins,
                        fontWeight: FontWeight.w600,
                        fontSize: 8.sp,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 3.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: showMemmbers ? 43.w : 55.w,
                            margin: PagePadding.onlyTop(1.h),
                            child: RabbleText.subHeaderText(
                              text: user,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              color: APPColors.appBlack4,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            height: 0.8.h,
                          ),
                          Row(
                            children: [
                              Assets.svgs.truck_filled.svg(
                                  width: 4.w,
                                  height: 2.h,
                                  color: APPColors.appBlue),
                              SizedBox(
                                width: 2.w,
                              ),
                              RabbleText.subHeaderText(
                                text:
                                    'Delivers ${Conversation.getFrequencyText2(delivers)}',
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w500,
                                color: APPColors.bg_grey27,
                                fontFamily: cPoppins,
                                fontSize: 9.sp,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      showMemmbers
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                associateMembers.isNotEmpty &&
                                        associateMembers.any((element) =>
                                            element.userId != hostId)
                                    ? RabbleText.subHeaderText(
                                        text: kMembers,
                                        fontSize: 9.sp,
                                        fontFamily: cPoppins,
                                        fontWeight: FontWeight.w500,
                                        color: APPColors.appTextPrimary,
                                      )
                                    : const SizedBox.shrink(),
                                associateMembers.isNotEmpty
                                    ? SizedBox(
                                        height: 0.3.h,
                                      )
                                    : const SizedBox.shrink(),
                                associateMembers.isNotEmpty
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.26,
                                        height: 40,
                                        child: MemberList(
                                            associateMembers, currentUserId!),
                                      )
                                    : const SizedBox.shrink()
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 0.3.h,
          ),
          Container(
            margin: PagePadding.onlyLeft(2.w),
            child: RabbleText.subHeaderText(
              text: introText,
              fontSize: 11.sp,
              fontFamily: cPoppins,
              fontWeight: FontWeight.w400,
              height: 1.3,
              color: APPColors.appBlack4,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

class MemberList extends StatelessWidget {
  final List<Members> memebers;
  final String currentUserId;

  MemberList(this.memebers, this.currentUserId);

  @override
  Widget build(BuildContext context) {
    List<Widget> positionedWidgets = [];

    for (Members member in memebers) {
      int index = memebers.indexOf(member);
      double overlap = 0.1 * MediaQuery.of(context).size.width;

      if (currentUserId != member.userId) {
        Widget positionedWidget = Positioned(
          left: index * (60 - overlap),
          child: index < 3
              ? member.user!.imageUrl!.isNotEmpty &&
                      member.user!.imageUrl! !=
                          'https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/img.png'
                  ? SizedBox(
                      width: 35,
                      height: 35,
                      child: RabbleImageLoader(
                        imageUrl: member.user!.imageUrl!,
                        isRound: true,
                        roundValue: 15,
                      ),
                    )
                  : SizedBox(
                      width: 35,
                      height: 35,
                      child: CircleAvatar(
                        backgroundColor: APPColors.appBlack,
                        child: RabbleText.subHeaderText(
                          text:
                              '${member.user!.firstName!.trim()} ${member.user!.lastName!.trim()}'
                                  .initials,
                          fontSize: 9.sp,
                          fontFamily: cGosha,
                          fontWeight: FontWeight.w400,
                          color: APPColors.appPrimaryColor,
                        ),
                      ),
                    )
              : index == 3
                  ? SizedBox(
                      width: 35,
                      height: 35,
                      child: CircleAvatar(
                        backgroundColor: APPColors.appBlack,
                        child: Center(
                          child: RabbleText.subHeaderText(
                            text: '+${memebers.length - 3}',
                            fontSize: 10.sp,
                            fontFamily: cGosha,
                            fontWeight: FontWeight.w400,
                            color: APPColors.appPrimaryColor,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
        );

        positionedWidgets.add(positionedWidget);
      }
    }

    return Stack(
      children: positionedWidgets,
    );
  }
}
