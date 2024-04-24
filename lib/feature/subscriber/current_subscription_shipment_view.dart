import 'package:rabble/core/config/export.dart';
import 'package:rabble/feature/buying_team/setting/quite_team_sheet.dart';
import 'package:rabble/feature/subscriber/subscription_cubit.dart';

class CurrentSubscriptionShipmentView extends StatelessWidget {
  CurrentSubscriptionShipmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    TeamData teamData = data['teamData'];
    CurrentOrderData currentOrderData = data['order'];
    String myId = data['myId'];
    String card = data['card'];
    String memberId = data['memberId'];

    String percentage = DateFormatUtil.calculatePercentage(
        int.parse(currentOrderData.accumulatedAmount!.round().toString()),
        int.parse(currentOrderData.minimumTreshold!.round().toString()));

    int remainingDays = data['deadline'] != null && data['deadline'] != '0'
        ? DateFormatUtil.remainingDays(data['deadline'])
        : 0;


    return CubitProvider<RabbleBaseState, SubscriptionCubit>(
        create: (context) => SubscriptionCubit(),
        builder: (context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bgColor,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(9.h),
                child: RabbleAppbar(
                  backgroundColor: APPColors.bg_app_primary,
                  title: kYS,
                  leadingWidth: 21.w,
                )),
            body: BehaviorSubjectBuilder<UserModel>(
                subject: bloc.userDataSubject$,
                builder: (context, snapshot) {
                  return RabbleFullScreenProgressIndicator(
                    enabled: state.primaryBusy,
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: ContainerDecoration
                                      .leftRightBottomRadiusDecoration(
                                          border: Colors.transparent, width: 0),
                                  child: SizedBox(
                                    width: context.allWidth,
                                    height: context.allWidth * 0.5,
                                    child: RabbleImageLoader(
                                      fit: BoxFit.cover,
                                      imageUrl: teamData.imageUrl ?? '',
                                      isRound: false,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    height: context.allHeight * 0.09,
                                    margin: PagePadding.custom(2.w, 2.w, 0, 0),
                                    padding:
                                        PagePadding.custom(4.w, 4.w, 3.w, 3.w),
                                    child: RabbleButton.tertiaryFilled(
                                      buttonSize: ButtonSize.large,
                                      bgColor: APPColors.appPrimaryColor,
                                      onPressed: () {
                                        NavigatorHelper()
                                            .navigateTo('/my_checkout', data);
                                      },
                                      child: RabbleText.subHeaderText(
                                        text: teamData.count!.order! > 1
                                            ? kYB
                                            : KUO,
                                        fontSize: 13.sp,
                                        fontFamily: 'Gosha',
                                        color: APPColors.appBlack,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Padding(
                              padding: PagePadding.horizontalSymmetric(4.w),
                              child: Column(
                                children: [
                                  /* const ViewAllWidget(
                            title: kAddToShipment,
                            showViewAllBtn: true,
                          ),
                           ProductWidget(
                            isHorizontal: true,
                            showHeading: false,
                            callBackEmpty: (){

                            },
                          ),*/
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  teamData.nextDeliveryDate != null
                                      ? ShippingCardCustom(
                                          label: kNextShippingDate,
                                          value:
                                              teamData.nextDeliveryDate != null
                                                  ? DateFormatUtil.formatDate(
                                                      teamData.nextDeliveryDate,
                                                      'dd MMM yyyy')
                                                  : '',
                                          icon: Assets.svgs.truck_blue.svg(),
                                        )
                                      : const SizedBox.shrink(),
                                  ShippingCardCustom(
                                    label: kShipTo,
                                    value:
                                        '${teamData.host!.shipping!.buildingNo! ?? ''} ${teamData.host!.shipping!.address! ?? ''} ${teamData.host!.shipping!.city! ?? ''}',
                                    icon: Assets.svgs.pin
                                        .svg(color: APPColors.appBlue),
                                  ),
                                  ShippingCardCustom(
                                    label: kDeliveryEvery,
                                    value:
                                        '${teamData.epochToTotalWeeks(int.parse(teamData.frequency.toString()))} Week',
                                    icon: Assets.svgs.convertshape
                                        .svg(color: APPColors.appBlue),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      NavigatorHelper()
                                          .navigateTo('/all_cards');
                                    },
                                    child: ShippingCardCustom(
                                        label: kPayment,
                                        value: card ?? '',
                                        icon: Assets.svgs.payCard
                                            .svg(color: APPColors.appBlue),
                                        trailingValue: sVisaDetails,
                                        trailing: RabbleText.subHeaderText(
                                            text: 'Edit',
                                            fontFamily: cGosha,
                                            fontWeight: FontWeight.bold,
                                            fontSize: context.allWidth * 0.040,
                                            color: APPColors.appBlue)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            bottomNavigationBar: Container(
              height: context.allHeight * 0.2,
              margin: PagePadding.custom(4.w, 4.w, 0, 0),
              child: Column(
                children: [
                  remainingDays > 5
                      ? BehaviorSubjectBuilder<bool>(
                          subject: bloc.skipDeliverySubject$,
                          initialData: false,
                          builder: (context, snapshot) {
                            return !snapshot.data!
                                ? state.secondaryBusy
                                    ? Container(
                                        margin: PagePadding.onlyTop(6.w),
                                        child:
                                            const RabbleSecondaryScreenProgressIndicator(
                                          enabled: true,
                                        ),
                                      )
                                    : ContinueButtonWidget(
                                        backgroundColor: APPColors.appWhite,
                                        labelColor: APPColors.appBlue,
                                        callBack: () {
                                          //change here
                                          bloc.skipNextDeliver(memberId);
                                        },
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const PagePadding.all(0),
                                        label: kSkipNextDelivery,
                                      )
                                : const SizedBox.shrink();
                          })
                      : const SizedBox.shrink(),
                  state.tertiaryBusy
                      ? Container(
                          margin: PagePadding.onlyTop(6.w),
                          child: const RabbleSecondaryScreenProgressIndicator(
                            enabled: true,
                          ),
                        )
                      : ContinueButtonWidget(
                          backgroundColor: Colors.transparent,
                          callBack: () {
                            CustomBottomSheet.showQuitBottomModelSheet(
                                context,
                                QuiteTeam(
                                  canLeave: int.parse(percentage) < 100 &&
                                      remainingDays > 0 && teamData.count!.order! == 1,
                                  showHeading: true,
                                  isHost: teamData.hostId ==
                                      bloc.userDataSubject$.value.id,
                                  subheading:
                                      'Are you sure you want to shut down this team?',
                                  des:
                                      ' By quitting this team you will be shutting it down for all members. Please make sure you have notified them in advance.',
                                  callBackDelete: () async {
                                    await bloc.quiteTeam(myId);
                                  },
                                  date: data['deadline'].toString(),
                                ),
                                true,
                                int.parse(percentage) < 100 &&
                                    remainingDays > 0 && teamData.count!.order! == 1,
                                isRemove: true,
                                date: data['deadline'].toString());
                          },
                          width: MediaQuery.of(context).size.width,
                          padding: const PagePadding.all(0),
                          label: kQuitTeam,
                          labelColor: APPColors.appRed,
                        )
                ],
              ),
            ),
          );
        });
  }

  dynamic quitTeamDialog(BuildContext context, SubscriptionCubit bloc,
      String? id, String teamName) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (c) {
          return AlertDialog(
            title: Center(
              child: RabbleText.subHeaderText(
                text: 'Team Quiting Alert!',
                fontWeight: FontWeight.bold,
                fontFamily: cGosha,
                fontSize: 14.sp,
                textAlign: TextAlign.left,
                color: APPColors.appPrimaryColor,
              ),
            ),
            content: Wrap(
              children: [
                Center(
                  child: RabbleText.subHeaderText(
                    text: 'are you sure, you want to Quit $teamName?',
                    fontWeight: FontWeight.normal,
                    fontFamily: cPoppins,
                    fontSize: 10.sp,
                    textAlign: TextAlign.left,
                    color: APPColors.appWhite,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          width: 27.w,
                          height: 6.h,
                          color: APPColors.appPrimaryColor,
                          child: RabbleText.subHeaderText(
                            text: 'Quite',
                            fontSize: 10.sp,
                            fontFamily: cPoppins,
                            color: APPColors.appBlack4,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onTap: () async {
                          await bloc.quiteTeam(id!);
                        }),
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 27.w,
                        height: 6.h,
                        color: Colors.white,
                        child: RabbleText.subHeaderText(
                          text: 'Cancel',
                          fontSize: 10.sp,
                          fontFamily: cPoppins,
                          color: APPColors.appBlack4,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () => Navigator.of(c).pop(),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
