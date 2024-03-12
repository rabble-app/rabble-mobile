import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';
import 'team_view_shimmer.dart';

class TeamView extends StatelessWidget {
  TeamView({Key? key}) : super(key: key);

  final StreamController<bool> _expandableStream = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;

    return CubitProvider<RabbleBaseState, TeamViewCubit>(
        create: (Context) => TeamViewCubit(teamId: data['teamId']),
        builder: (Context, state, bloc) {
          return BehaviorSubjectBuilder<bool>(
              subject: bloc.isUpdate,
              builder: (context, snapshot) {
                return PopScope(
                  onPopInvoked: (bool status) async {
                    if (data['type'] != null && data['type'] == '0') {
                      String status =
                          await RabbleStorage.getLoginStatus() ?? "0";

                      if (status == '1') {
                        NavigatorHelper().navigateAnClearAll('/home');
                      } else {
                        NavigatorHelper().navigateAnClearAll('/splash');
                      }
                    } else {
                      if (snapshot.data!) {
                        // Navigate back with a result
                        Navigator.pop(context, true);
                      }
                    }
                  },
                  child: Scaffold(
                    backgroundColor: state.primaryBusy
                        ? APPColors.appWhite
                        : APPColors.appBlack,
                    body: state.primaryBusy
                        ? TeamViewShimmer()
                        : BehaviorSubjectBuilder<TeamData>(
                            subject: bloc.teamDataSubject$,
                            builder: (context, teamDataSnap) {
                              return BehaviorSubjectBuilder<UserModel>(
                                  subject: bloc.currentUserDataSubject$,
                                  builder: (context, userDataSnap) {
                                    return BehaviorSubjectBuilder<
                                            CurrentOrderData>(
                                        subject: bloc.currentOrderSubject$,
                                        builder: (context, currentOrderSnap) {
                                          return currentOrderSnap.hasData
                                              ? Column(
                                                  children: [
                                                    CreationTeamAppbar(
                                                      backTitle: kBack,
                                                      title: teamDataSnap
                                                          .data!.name,
                                                      backRoute: data['type'] !=
                                                                  null &&
                                                              data['type'] ==
                                                                  '0'
                                                          ? 'home'
                                                          : null,
                                                      action: [
                                                        CustomShareWidget(
                                                          title: kShare,
                                                          onTap: () async {
                                                            var link = await bloc
                                                                .generateDeepLink(
                                                                    teamDataSnap
                                                                        .data!);
                                                            Share.share(
                                                              'Check out this buying team on Rabble! ${teamDataSnap.data!.name} $link',
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        color:
                                                            APPColors.appBlack,
                                                        child:
                                                            SingleChildScrollView(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          physics:
                                                              ClampingScrollPhysics(),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.3,
                                                                  child: teamDataSnap
                                                                              .data!
                                                                              .imageUrl !=
                                                                          null
                                                                      ? RabbleImageLoader(
                                                                          isRound:
                                                                              false,
                                                                          imageUrl:
                                                                              teamDataSnap.data!.imageUrl ?? '')
                                                                      : Container(
                                                                          width:
                                                                              14.w,
                                                                          height:
                                                                              9.h,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                APPColors.appBlack,
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                RabbleText.subHeaderText(
                                                                              text: '${teamDataSnap.data!.host!.firstName ?? ''}${teamDataSnap.data!.host!.lastName ?? ''}'.length > 2 ? '${teamDataSnap.data!.host!.firstName ?? ''}${teamDataSnap.data!.host!.lastName ?? ''}'.substring(0, 2) : 'NA',
                                                                              fontWeight: FontWeight.bold,
                                                                              color: APPColors.appPrimaryColor,
                                                                              fontSize: 13.sp,
                                                                            ),
                                                                          ),
                                                                        )),
                                                              BehaviorSubjectBuilder(
                                                                  subject: bloc
                                                                      .isMyRequest,
                                                                  builder: (context,
                                                                      requestSnap) {
                                                                    return Container(
                                                                      color: APPColors
                                                                          .bgColor,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          MemberDescriptionViewComplete(
                                                                            showMemmbers:
                                                                                bloc.showMembers(teamDataSnap.data!),
                                                                            avatar:
                                                                                teamDataSnap.data!.host!.imageUrl ?? '',
                                                                            user:
                                                                                '${teamDataSnap.data!.host!.firstName ?? ''} ${teamDataSnap.data!.host!.lastName ?? ''}',
                                                                            firstName:
                                                                                teamDataSnap.data!.host!.firstName ?? '',
                                                                            lastName:
                                                                                teamDataSnap.data!.host!.lastName ?? '',
                                                                            associateMembers:
                                                                                teamDataSnap.data!.members!,
                                                                            delivers:
                                                                                teamDataSnap.data!.frequency!.toInt(),
                                                                            memberSince:
                                                                                DateFormatUtil.formatDate(teamDataSnap.data!.createdAt!, 'dd MMM yyyy'),
                                                                            currentUserId:
                                                                                teamDataSnap.data!.hostId,
                                                                            introText:
                                                                                teamDataSnap.data!.description ?? '',
                                                                            percentage:
                                                                                DateFormatUtil.calculatePercentage(int.parse(currentOrderSnap.data!.accumulatedAmount!.round().toString()), int.parse(currentOrderSnap.data!.minimumTreshold!.toString())),
                                                                            hostId:
                                                                                teamDataSnap.data!.hostId!,
                                                                          ),

                                                                          // const CustomizedTeamStrengthBox(
                                                                          //   teamStrength: sTeamStrength,
                                                                          //   amountSaved: sAmountSaved,
                                                                          //   vansPrevented: sVans,
                                                                          // ),

                                                                          ((requestSnap.hasData && requestSnap.data != null && requestSnap.data!.status == 'APPROVED') || teamDataSnap.data!.members!.where((element) => element.userId == userDataSnap.data!.id).isNotEmpty)
                                                                              ? GestureDetector(
                                                                                  onTap: () {

                                                                                    Map map = {
                                                                                      'teamName': teamDataSnap.data!.name,
                                                                                      'teamId': teamDataSnap.data!.id,
                                                                                    };
                                                                                    NavigatorHelper().navigateTo('/chat_room', map).then((value) {
                                                                                      if (value != null) {
                                                                                        if (value is ConversationData) {

                                                                                          TeamData teamData = teamDataSnap.data!;
                                                                                          teamData.chats!.add(value);
                                                                                          bloc.teamDataSubject$.sink.add(teamData);
                                                                                        }
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                    height: context.allHeight * 0.09,
                                                                                    width: context.allWidth,
                                                                                    margin: PagePadding.custom(3.5.w, 3.5.w, 5.w, 0),
                                                                                    decoration: ContainerDecoration.boxDecoration(bg: APPColors.appWhite, border: APPColors.appWhite, width: 1, radius: 8, showShadow: true),
                                                                                    child: Stack(
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 17.w,
                                                                                          height: 2.2.h,
                                                                                          transform: Matrix4.translationValues(10, -10, 0),
                                                                                          decoration: ContainerDecoration.boxDecoration(
                                                                                            bg: APPColors.borderColor2,
                                                                                            border: APPColors.borderColor2,
                                                                                            radius: 24,
                                                                                          ),
                                                                                          child: Center(
                                                                                            child: RabbleText.subHeaderText(
                                                                                              text: 'Message',
                                                                                              color: APPColors.appBlue,
                                                                                              height: 1,
                                                                                              fontFamily: cGosha,
                                                                                              fontWeight: FontWeight.w700,
                                                                                              fontSize: 8.sp,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Align(
                                                                                          alignment: Alignment.center,
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              SizedBox(
                                                                                                width: 3.w,
                                                                                              ),
                                                                                              CircleAvatar(
                                                                                                backgroundColor: APPColors.appPrimaryColor,
                                                                                                radius: 5.w,
                                                                                                child: Assets.svgs.tabmessages.svg(width: 5.w, color: APPColors.appBlack),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 4.w,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: context.allWidth * 0.55,
                                                                                                child: RabbleText.subHeaderText(
                                                                                                  textAlign: TextAlign.start,
                                                                                                  text: teamDataSnap.data!.chats!.isEmpty
                                                                                                      ? teamDataSnap.data!.hostId == userDataSnap.data!.id
                                                                                                          ? 'Message your team'
                                                                                                          : 'Message your host'
                                                                                                      :  teamDataSnap.data!.chats!.last.userId == userDataSnap.data!.id
                                                                                                          ? 'You: ${teamDataSnap.data!.chats!.last.text}'
                                                                                                          : '${teamDataSnap.data!.chats!.last.user!.firstName}: ${teamDataSnap.data!.chats!.last.text}',
                                                                                                  fontSize: 10.sp,
                                                                                                  color: APPColors.appBlack4,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  fontFamily: cPoppins,
                                                                                                ),
                                                                                              ),
                                                                                              Spacer(),
                                                                                              teamDataSnap.data!.chats!.isEmpty
                                                                                                  ? Assets.svgs.arrow_right.svg()
                                                                                                  : RabbleText.subHeaderText(
                                                                                                      text: teamDataSnap.data!.chats!.last.createdAt != null ? DateFormatUtil.formatMessageTime(DateTime.parse(teamDataSnap.data!.chats!.last.createdAt.toString())) : '',
                                                                                                      fontSize: 9.sp,
                                                                                                      color: APPColors.appTextPrimary,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontFamily: cPoppins,
                                                                                                    ),
                                                                                              SizedBox(
                                                                                                width: 3.w,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : SizedBox.shrink(),

                                                                          Container(
                                                                            // color: APPColors.offWhite
                                                                            //     .withOpacity(0.1),
                                                                            padding: PagePadding.custom(
                                                                                3.5.w,
                                                                                3.5.w,
                                                                                0,
                                                                                2.w),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: 1.5.h,
                                                                                ),
                                                                                ((requestSnap.hasData && requestSnap.data != null && requestSnap.data!.status == 'APPROVED') || teamDataSnap.data!.members!.where((element) => element.userId == userDataSnap.data!.id).isNotEmpty)
                                                                                    ? Column(
                                                                                        children: [
                                                                                          ShippingCardCustom(
                                                                                            isTeamPage: true,
                                                                                            label: '',
                                                                                            value: 'Next delivery ${currentOrderSnap.data!.deliveryDate != null ? '${int.parse(DateFormatUtil.countDays(currentOrderSnap.data!.deliveryDate!)) < 7 ? "in ${DateFormatUtil.countDays(currentOrderSnap.data!.deliveryDate!)} days" : DateFormatUtil.formatDate(currentOrderSnap.data!.deliveryDate!, 'dd MMM yyyy')} ' : 'date TBD'}',
                                                                                            icon: Assets.svgs.truck_blue.svg(),
                                                                                          ),
                                                                                          ShippingCardCustom(
                                                                                            isTeamPage: true,
                                                                                            label: 'Collection Address',
                                                                                            value: teamDataSnap.data!.host!.shipping != null ? '${teamDataSnap.data!.host!.shipping!.buildingNo! ?? ''} ${teamDataSnap.data!.host!.shipping!.address! ?? ''} ${teamDataSnap.data!.host!.shipping!.city! ?? ''}' : '',
                                                                                            icon: Assets.svgs.pin.svg(color: APPColors.appBlue),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 1.5.h,
                                                                                          ),
                                                                                          ThresholdMetCustomWidget(
                                                                                            producerName: '${teamDataSnap.data!.producer!.businessName ?? ''}',
                                                                                            milestoneTowards: DateFormatUtil.amountFormatter(currentOrderSnap.data!.minimumTreshold!.toDouble()),
                                                                                            completedMilestone: DateFormatUtil.amountFormatter(currentOrderSnap.data!.accumulatedAmount!.toDouble()),
                                                                                            totalDays: DateFormatUtil.countDays(
                                                                                              currentOrderSnap.data!.deadline!.toString(),
                                                                                            ),
                                                                                            totalMembers: teamDataSnap.data!.members!.length.toString(),
                                                                                            percentage: DateFormatUtil.calculatePercentage(int.parse(currentOrderSnap.data!.accumulatedAmount!.round().toString()), int.parse(currentOrderSnap.data!.minimumTreshold!.round().toString())),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 2.h,
                                                                                          ),
                                                                                          if (currentOrderSnap.data!.partionedProducts!.isNotEmpty)
                                                                                            BehaviorSubjectBuilder<List<List<TempBoxData>>>(
                                                                                                subject: bloc.allTempBoxList,
                                                                                                builder: (BuildContext context, purchaseUserSnapshot) {
                                                                                                  return PortionedProductWidget(
                                                                                                    heading: '${currentOrderSnap.data!.partionedProducts!.first.product!.orderUnit!} of ${currentOrderSnap.data!.partionedProducts!.first.product!.unitsOfMeasure!.toLowerCase()} ${currentOrderSnap.data!.partionedProducts!.first.product!.orderSubUnit!.toLowerCase()}s',
                                                                                                    subHeading: 'This is a ${currentOrderSnap.data!.partionedProducts!.first.product!.totalThresholdQuantity} ${currentOrderSnap.data!.partionedProducts!.first.product!.orderSubUnit!.toLowerCase()} ${currentOrderSnap.data!.partionedProducts!.first.product!.orderUnit!.toLowerCase()}. The box is ordered once all cartons are sold to the team',
                                                                                                    items: currentOrderSnap.data!.partionedProducts!,
                                                                                                    purchaseUser: purchaseUserSnapshot.hasData ? purchaseUserSnapshot.data! : [],
                                                                                                  );
                                                                                                }),
                                                                                          SizedBox(
                                                                                            height: 2.h,
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                    : const SizedBox.shrink(),
                                                                                ((requestSnap.hasData && requestSnap.data != null && requestSnap.data!.status == 'APPROVED') || teamDataSnap.data!.members!.where((element) => element.userId == userDataSnap.data!.id).isNotEmpty)
                                                                                    ? Column(
                                                                                        children: [
                                                                                          Container(
                                                                                            decoration: BoxDecoration(
                                                                                              border: Border.all(
                                                                                                color: APPColors.greyText.withOpacity(0.2),
                                                                                              ),
                                                                                              borderRadius: BorderRadius.circular(2.w),
                                                                                            ),
                                                                                            child: Column(
                                                                                              children: [
                                                                                                BehaviorSubjectBuilder<Members>(
                                                                                                    subject: bloc.isMyTeam,
                                                                                                    builder: (context, myTeamSnap) {
                                                                                                      if (myTeamSnap.hasData) {
                                                                                                        return StreamBuilder<bool>(
                                                                                                            initialData: false,
                                                                                                            stream: _expandableStream.stream,
                                                                                                            builder: (context, s) {
                                                                                                              return Container(
                                                                                                                padding: PagePadding.custom(3.5.w, 3.5.w, 3.5.w, 1.w),
                                                                                                                child: BasketWidget(
                                                                                                                  orderCount: teamDataSnap.data!.count!.order!.toInt(),
                                                                                                                  image: userDataSnap.data!.imageUrl ?? '',
                                                                                                                  name: '${userDataSnap.data!.firstName} ${userDataSnap.data!.lastName}',
                                                                                                                  basket: bloc.getMyOrder(currentOrderSnap.data!.basket!, userDataSnap.data!.id),
                                                                                                                  callBackExpanded: (val) {
                                                                                                                    _expandableStream.sink.add(val ? false : true);
                                                                                                                  },
                                                                                                                ),
                                                                                                              );
                                                                                                            });
                                                                                                      }

                                                                                                      return const SizedBox.shrink();
                                                                                                    }),
                                                                                                teamDataSnap.data!.members!.length > 1
                                                                                                    ? Container(
                                                                                                        height: 0.2,
                                                                                                        color: APPColors.appTextGrey,
                                                                                                      )
                                                                                                    : const SizedBox.shrink(),
                                                                                                teamDataSnap.data!.members!.length > 1
                                                                                                    ? SizedBox(
                                                                                                        height: 2.h,
                                                                                                      )
                                                                                                    : const SizedBox.shrink(),
                                                                                                teamDataSnap.data!.members!.length > 1
                                                                                                    ? Align(
                                                                                                        alignment: Alignment.centerLeft,
                                                                                                        child: Container(
                                                                                                          padding: PagePadding.horizontalSymmetric(3.5.w),
                                                                                                          child: RabbleText.subHeaderText(
                                                                                                            text: 'Team Orders',
                                                                                                            fontFamily: cPoppins,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                            fontSize: 11.sp,
                                                                                                            color: APPColors.appBlue,
                                                                                                          ),
                                                                                                        ),
                                                                                                      )
                                                                                                    : const SizedBox.shrink(),
                                                                                                teamDataSnap.data!.members!.length > 1
                                                                                                    ? SizedBox(
                                                                                                        height: 2.h,
                                                                                                      )
                                                                                                    : const SizedBox.shrink(),
                                                                                                Container(
                                                                                                  padding: PagePadding.horizontalSymmetric(3.5.w),
                                                                                                  child: ListView.builder(
                                                                                                      padding: EdgeInsets.zero,
                                                                                                      itemCount: teamDataSnap.data!.members!.length,
                                                                                                      primary: true,
                                                                                                      physics: const NeverScrollableScrollPhysics(),
                                                                                                      shrinkWrap: true,
                                                                                                      itemBuilder: (context, index) {
                                                                                                        print('userDataSnap.data!.id ${userDataSnap.data!.id}');
                                                                                                        Members otherMateData = teamDataSnap.data!.members![index];
                                                                                                        return otherMateData.userId != userDataSnap.data!.id && bloc.getQuantity(currentOrderSnap.data!.basket!, otherMateData.userId)
                                                                                                            ? StreamBuilder<bool>(
                                                                                                                initialData: false,
                                                                                                                stream: _expandableStream.stream,
                                                                                                                builder: (context, s) {
                                                                                                                  return BasketWidget(
                                                                                                                    showImage: false,
                                                                                                                    image: otherMateData.user!.imageUrl!,
                                                                                                                    heading: teamDataSnap.data!.hostId == userDataSnap.data!.id ? ' ${otherMateData.user!.firstName} ${otherMateData.user!.lastName}' : ' ${otherMateData.user!.firstName} ${otherMateData.user!.lastName!.length >= 1 ? otherMateData.user!.lastName![0] : ''}',
                                                                                                                    name: '${otherMateData.user!.firstName} ${otherMateData.user!.lastName}',
                                                                                                                    basket: bloc.getMyOrder(currentOrderSnap.data!.basket!, otherMateData.userId),
                                                                                                                    callBackExpanded: (val) {
                                                                                                                      _expandableStream.sink.add(val ? false : true);
                                                                                                                    },
                                                                                                                  );
                                                                                                                })
                                                                                                            : const SizedBox.shrink();
                                                                                                      }),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 4.h,
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                    : const SizedBox.shrink(),
                                                                                ((requestSnap.hasData && requestSnap.data != null && requestSnap.data!.status == 'APPROVED') || teamDataSnap.data!.members!.where((element) => element.userId == userDataSnap.data!.id).isNotEmpty)
                                                                                    ? Column(
                                                                                        children: [
                                                                                          RabbleButton.tertiaryFilled(
                                                                                            buttonSize: ButtonSize.large,
                                                                                            bgColor: APPColors.appWhite,
                                                                                            child: RabbleText.subHeaderText(
                                                                                              text: kYS,
                                                                                              fontSize: 12.sp,
                                                                                              color: APPColors.appBlue,
                                                                                              fontFamily: cGosha,
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              Members member = teamDataSnap.data!.members!.firstWhere((element) => element.userId == userDataSnap.data!.id);
                                                                                              Map dataaa = {
                                                                                                'teamData': teamDataSnap.data,
                                                                                                'order': currentOrderSnap.data,
                                                                                                'myId': bloc.isMyTeam.value.id,
                                                                                                'memberId': member.id,
                                                                                                'card': member.user!.cardLastFourDigits ?? '',
                                                                                                'deadline': currentOrderSnap.data!.deadline,
                                                                                              };

                                                                                              NavigatorHelper().navigateTo('/subscription_shipment_view', dataaa);
                                                                                            },
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 2.h,
                                                                                          ),
                                                                                          teamDataSnap.data!.hostId == userDataSnap.data!.id
                                                                                              ? RabbleButton.tertiaryFilled(
                                                                                                  buttonSize: ButtonSize.large,
                                                                                                  bgColor: APPColors.appPrimaryColor,
                                                                                                  child: RabbleText.subHeaderText(
                                                                                                    text: 'Invite a contact to ${teamDataSnap.data!.name}',
                                                                                                    fontSize: 12.sp,
                                                                                                    color: APPColors.appBlack,
                                                                                                    fontFamily: cGosha,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    NavigatorHelper().navigateTo('/contact_view', teamDataSnap.data);
                                                                                                  },
                                                                                                )
                                                                                              : const SizedBox.shrink(),
                                                                                          SizedBox(
                                                                                            height: 2.h,
                                                                                          ),
                                                                                          teamDataSnap.data!.hostId == userDataSnap.data!.id
                                                                                              ? RabbleButton.tertiaryFilled(
                                                                                                  buttonSize: ButtonSize.large,
                                                                                                  bgColor: APPColors.appBlue,
                                                                                                  child: RabbleText.subHeaderText(
                                                                                                    text: kManageMyTeam,
                                                                                                    fontSize: 12.sp,
                                                                                                    color: APPColors.appWhite,
                                                                                                    fontFamily: cGosha,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    Members member = teamDataSnap.data!.members!.firstWhere((element) => element.userId == userDataSnap.data!.id);
                                                                                                    Map data = {
                                                                                                      'teamData': teamDataSnap.data,
                                                                                                      'myId': bloc.isMyTeam.value.id,
                                                                                                      'bloc': bloc,
                                                                                                      'memberId': member.id,
                                                                                                      'deadline': currentOrderSnap.data!.deadline,
                                                                                                      'percentage': DateFormatUtil.calculatePercentage(int.parse(currentOrderSnap.data!.accumulatedAmount!.round().toString()), int.parse(currentOrderSnap.data!.minimumTreshold!.toString()))
                                                                                                    };
                                                                                                    NavigatorHelper().navigateTo('/manage_members_view', data);
                                                                                                  },
                                                                                                )
                                                                                              : const SizedBox.shrink(),
                                                                                        ],
                                                                                      )
                                                                                    : Container(
                                                                                        margin: PagePadding.onlyTop(context.allHeight / 5),
                                                                                        child: RabbleButton.tertiaryFilled(
                                                                                          buttonSize: ButtonSize.large,
                                                                                          bgColor: requestSnap.data != null && requestSnap.data!.status == 'PENDING' ? APPColors.bg_grey25 : APPColors.appPrimaryColor,
                                                                                          child: RabbleText.subHeaderText(
                                                                                            text: requestSnap.data != null && requestSnap.data!.status == 'PENDING' ? 'Request Pending' : kRequestToJoin,
                                                                                            fontSize: 12.sp,
                                                                                            color: requestSnap.data != null && requestSnap.data!.status == 'PENDING' ? APPColors.bg_grey27 : APPColors.appBlack,
                                                                                            fontFamily: cGosha,
                                                                                            fontWeight: FontWeight.bold,
                                                                                          ),
                                                                                          onPressed: () async {
                                                                                            if (requestSnap.data == null) {
                                                                                              String status = await RabbleStorage.getLoginStatus() ?? "0";

                                                                                              if (status == '1') {
                                                                                                NavigatorHelper().navigateTo('/request_to_join_view', teamDataSnap.data).then((value) {
                                                                                                  if (value != null && value) {
                                                                                                    bloc.isUpdate.sink.add(true);
                                                                                                    bloc.fetchTeamDetail();
                                                                                                  }
                                                                                                });
                                                                                              } else {
                                                                                                NavigatorHelper().navigateAnClearAll('/splash');
                                                                                              }
                                                                                            }
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                SizedBox(
                                                                                  height: 2.h,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  })
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox.shrink();
                                        });
                                  });
                            }),
                  ),
                );
              });
        });
  }
}
