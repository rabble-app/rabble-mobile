import '../../../config/export.dart';

class MemberProfileView extends StatelessWidget {
  const MemberProfileView(
      {Key? key,
      this.data,
      this.callBackRemove,
      this.teamName,
      required this.isHost,
      required this.orderId,
      required this.isNormalPage,
      this.imageUrl})
      : super(key: key);

  final Members? data;
  final String? teamName;
  final String? imageUrl;
  final bool isHost;
  final bool isNormalPage;
  final String orderId;
  final Function(Members)? callBackRemove;

  @override
  Widget build(BuildContext context) {
    List<String> text = teamName!.split(' ');

    String firstCharName1 = '';
    String firstCharName2 = '';

    String combination = '';

    if (text.isNotEmpty) {
      firstCharName1 = text[0];
      firstCharName2 = text.length > 1 ? text[1] : " "; // Change 2 to 1

      combination =
          '${firstCharName1.length > 0 ? firstCharName1[0] : '' ?? ''}${firstCharName2.length > 0 ? firstCharName2[0] : '' ?? ''}';
    }

    return Container(
      margin: PagePadding.onlyTop(2.h),
      child: Column(
        children: [
          Row(
            children: [
              imageUrl!.isNotEmpty
                  ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.width * 0.12,

                child: RabbleImageLoader(
                        imageUrl: imageUrl!,
                        isRound: true,
                        roundValue: 18,
                      ),
                  )
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: MediaQuery.of(context).size.width * 0.12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: APPColors.appBlack,
                      ),
                      child: Center(
                        child: RabbleText.subHeaderText(
                          text: combination,
                          fontWeight: FontWeight.bold,
                          color: APPColors.appPrimaryColor,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
              SizedBox(
                width: 3.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RabbleText.subHeaderText(
                    text: '$teamName',
                    color: APPColors.appBlack4,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  // Container(
                  //   width: 27.w,
                  //   padding: PagePadding.all(1.w),
                  //   decoration: ContainerDecoration.boxDecoration(
                  //       bg: data!.isSelected!
                  //           ? APPColors.appGreen2
                  //           : APPColors.appRedLight,
                  //       border: data!.isSelected!
                  //           ? APPColors.appGreen2
                  //           : APPColors.appRedLight,
                  //       radius: 30,
                  //       width: 1),
                  //   child: RabbleText.subHeaderText(
                  //     text: data!.isSelected! ? kPaymentSuccess : kPaymentFailure,
                  //     color: data!.isSelected!
                  //         ? APPColors.appPrimaryColor2
                  //         : APPColors.appRedLight2,
                  //     fontSize: 8.sp,
                  //   ),
                  // )
                ],
              ),
              const Spacer(),
              isNormalPage
                  ? isHost
                      ? Container(
                          width: 12.w,
                          height: 2.8.h,
                          decoration: ContainerDecoration.boxDecoration(
                            bg: APPColors.appYellow,
                            border: APPColors.appYellow,
                            radius: 24,
                          ),
                          child: Center(
                            child: RabbleText.subHeaderText(
                              text: kHost2,
                              color: APPColors.appBlack,
                              height: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                            ),
                          ),
                        )
                      : const SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        CustomBottomSheet.showAccountBottomModelSheet(
                          context,
                          TeamMemberDetailView(
                            data: data,
                            isHost: isHost,
                            teamName: teamName,
                            orderId: orderId,
                            callBackRemove: (val) {
                              callBackRemove!.call(val);
                            },
                          ),
                          false,
                        );
                      },
                      child: Container(
                        width: 8.5.w,
                        height: 5.7.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: APPColors.appWhite,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 3.0,
                              spreadRadius: 1.0,
                              offset: const Offset(
                                  0, 0), // Offset in the x and y direction
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.more_horiz,
                            color: APPColors.appBlue,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          SizedBox(
            height: 1.5.h,
          ),
          const Divider(
            color: APPColors.bg_grey12,
            thickness: 0.5,
            height: 1,
          )
        ],
      ),
    );
  }
}
