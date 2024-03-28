import '../../../core/config/export.dart';

class TeamMemberDetailView extends StatelessWidget {
  TeamMemberDetailView(
      {Key? key, this.data, this.callBackRemove, this.teamName, required this.isHost, this.orderId})
      : super(key: key);
  final Members? data;
  final bool isHost;
  final String? teamName;
  final String? orderId;
  final Function(Members)? callBackRemove;

  @override
  Widget build(BuildContext context) {

    List<String> text = data !=null? '${data!.user!.firstName} ${data!.user!.lastName}'.split(' ') : teamName!.split(' ');

    String firstCharName1 = '';
    String firstCharName2 = '';

    String combination = '';

    if (text.isNotEmpty) {
      firstCharName1 = text[0];
      firstCharName2 = text.length > 1 ? text[1] : " "; // Change 2 to 1

      combination =
      '${firstCharName1.length > 0 ? firstCharName1[0] : '' ?? ''}${firstCharName2.length > 0 ? firstCharName2[0] : '' ?? ''}';
    }

    return CubitProvider<RabbleBaseState, BuyingTeamCubit>(
        create: (BuildContext context) => BuyingTeamCubit(),
        builder: (BuildContext context, RabbleBaseState state,
            BuyingTeamCubit bloc) {
          return ToucheDetector(
            child: Container(
              padding: PagePadding.verticalHorizontalSymmetric(5.w),
              color: APPColors.bgColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.5.h,
                  ),
                  InkWell(
                    onTap: () {
                      NavigatorHelper().pop();
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 7.w,
                      height: 4.5.h,
                      child: const CircleAvatar(
                        backgroundColor: APPColors.appTextPrimary,
                        child: Icon(
                          Icons.close,
                          color: APPColors.appWhite,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding: PagePadding.custom(2.w, 2.w, 3.w, 3.w),
                    decoration: ContainerDecoration.boxDecoration(
                        bg: Colors.transparent,
                        border: APPColors.bg_grey25,
                        width: 1,
                        radius: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 12.w,
                          height: 7.h,
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
                              text:
                                  '${data!.user!.firstName ?? ''} ${data!.user!.lastName ?? ''}',
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
                            //     text: data!.isSelected!
                            //         ? kPaymentSuccess
                            //         : kPaymentFailure,
                            //     color: data!.isSelected!
                            //         ? APPColors.appPrimaryColor2
                            //         : APPColors.appRedLight2,
                            //     fontSize: 8.sp,
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  state.secondaryBusy
                      ? const Center(
                          child: RabbleSecondaryScreenProgressIndicator(
                            enabled: true,
                          ),
                        )
                      : Center(
                          child: Container(
                            margin: PagePadding.custom(0, 0, 0, 2.w),
                            child: RabbleButton.tertiaryFilled(
                              buttonSize: ButtonSize.large,
                              bgColor: APPColors.appPrimaryColor,
                              onPressed: () async {
                                await bloc.nudgeTeamMember(
                                    teamName!, data!.user!.phone!,orderId!);
                              },
                              child: RabbleText.subHeaderText(
                                text: kNudgeToUpdate,
                                fontSize: 12.sp,
                                fontFamily: 'Gosha',
                                color: APPColors.appBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 1.h,
                  ),
                  !isHost?   InkWell(
                    onTap: () async {
                      await bloc.removeFromTeam(data!.id!);
                      callBackRemove!.call(data!);
                    },
                    child: state.tertiaryBusy
                        ? const Center(
                            child: RabbleSecondaryScreenProgressIndicator(
                              enabled: true,
                            ),
                          )
                        : Center(
                            child: RabbleText.subHeaderText(
                              text: kRemoveFromTeam,
                              fontSize: 12.sp,
                              height: 1.4,
                              fontFamily: cGosha,
                              fontWeight: FontWeight.bold,
                              color: APPColors.appRedLight,
                            ),
                          ),
                  ):const SizedBox.shrink(),
                  SizedBox(
                    height: 2.5.h,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
