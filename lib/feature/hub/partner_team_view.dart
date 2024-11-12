import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rabble/core/literals/network_literals.dart';
import 'package:rabble/feature/buying_team/team/team_view_shimmer.dart';
import 'package:rabble/feature/hub/hub_cubit.dart';
import 'package:rabble/feature/hub/widget/deliver_address_widget.dart';

import '../../core/config/export.dart';

class PartnerTeamView extends StatelessWidget {
  final String partnerId;

  PartnerTeamView({super.key, required this.partnerId});

  final StreamController<bool> _expandableStream = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, HubCubit>(
        create: (context) => HubCubit()..fetchTeamDetail(partnerId),
        builder: (context, state, bloc) {
          return state.primaryBusy
              ? TeamViewShimmer()
              : BehaviorSubjectBuilder<TeamData>(
                  subject: bloc.teamDataSubject$,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Empty();

                    TeamData teamData = snapshot.data!;
                    return BehaviorSubjectBuilder<UserModel>(
                        subject: bloc.currentUserDataSubject$,
                        builder: (context, userDataSnap) {
                          if (!snapshot.hasData) return const Empty();
                          return Scaffold(
                            backgroundColor: APPColors.bgColor,
                            body: BehaviorSubjectBuilder<CurrentOrderData>(
                                subject: bloc.currentOrderSubject$,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return const Empty();

                                  CurrentOrderData currentOrderData =
                                      snapshot.data!;

                                  return Column(
                                    children: [
                                      Container(
                                        color: APPColors.appBlack,
                                        padding:
                                            PagePadding.custom(0, 0, 6.h, 2.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                if (Navigator.canPop(context)) {
                                                  NavigatorHelper().pop();
                                                } else {
                                                  NavigatorHelper()
                                                      .navigateAnClearAll(
                                                          '/home');
                                                }
                                              },
                                              child: Padding(
                                                padding: PagePadding.onlyLeft(
                                                  3.w,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Assets.svgs.arrowLeft
                                                        .svg(height: 2.5.h),
                                                    SizedBox(
                                                      width: 1.5.w,
                                                    ),
                                                    RabbleText.subHeaderText(
                                                      text: kBack,
                                                      color: APPColors
                                                          .appPrimaryColor,
                                                      fontFamily: cGosha,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            CustomShareWidget(
                                              title: kShare,
                                              onTap: () async {
                                                String link = await bloc
                                                    .generateDeepLink(teamData);
                                                Share.share(
                                                  'Check out this partner team on Rabble! ${teamData.name} $link',
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          physics:
                                              const ClampingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              Container(
                                                height:
                                                    context.allHeight * 0.25,
                                                color: APPColors.appBlack4,
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      left: 0,
                                                      bottom: 5,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: SizedBox(
                                                          width:
                                                              context.allWidth *
                                                                  0.75,
                                                          child: RabbleText
                                                              .subHeaderText(
                                                            text:
                                                                '${teamData.name}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: APPColors
                                                                .appPrimaryColor,
                                                            fontFamily: cGosha,
                                                            height: 1.3,
                                                            fontSize:
                                                                '${teamData.name}'
                                                                            .length >
                                                                        55
                                                                    ? 22.sp
                                                                    : 25.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Assets.svgs.hub_box.svg(
                                                        width:
                                                            context.allWidth),
                                                  ],
                                                ),
                                              ),
                                              HostInfoWidget(
                                                showMemmbers: true,
                                                label: 'Hub Host',
                                                avatar: teamData.imageUrl ?? '',
                                                user:
                                                    '${teamData.partner?.name}',
                                                firstName:
                                                    teamData.partner?.name ??
                                                        '',
                                                lastName:
                                                    teamData.partner?.name ??
                                                        '',
                                                associateMembers:
                                                    teamData.members!,
                                                delivers:
                                                    teamData.frequency!.toInt(),
                                                currentUserId: '1',
                                                introText:
                                                    '${teamData.partner?.name} is partnering with ${teamData.producer?.businessName} and Rabble to bring everyone in ${teamData.postalCode!.length <= 3 ? "" : teamData.postalCode!.substring(0, teamData.postalCode!.length - 3)} the opportunity to access sustainable products, at wholesale prices, shipped direct from ${teamData.producer?.businessName} to ${teamData.partner?.name} ${Conversation.getFrequencyText2(teamData.frequency!.toInt()).toLowerCase()}. ',
                                                hostId: teamData.hostId ?? '',
                                                memberSince: '',
                                                percentage: '',
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              const Divider(
                                                thickness: 0.5,
                                                height: 0.5,
                                                color: APPColors.bg_grey25,
                                              ),
                                              CollectionDetailWidget(
                                                  teamData.partner),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              if (teamData.nextDeliveryDate !=
                                                  null)
                                                Padding(
                                                  padding: PagePadding.custom(
                                                      2.h, 2.h, 1.h, 0),
                                                  child: DeliveryAddressCustom(
                                                    isMember: bloc.isMember(
                                                        teamData.members,
                                                        userDataSnap.data!.id!),
                                                    partnerName:
                                                        teamData.partner?.name,
                                                    label: getLabel(
                                                        teamData,
                                                        currentOrderData,
                                                        bloc,
                                                        userDataSnap.data),
                                                    countDay: DateFormatUtil
                                                        .countDays2(teamData
                                                            .nextDeliveryDate),
                                                    value: getValue(
                                                        teamData,
                                                        currentOrderData,
                                                        bloc,
                                                        userDataSnap.data),
                                                    status: getStatusDelivery(
                                                        teamData,
                                                        currentOrderData,
                                                        bloc,
                                                        userDataSnap.data),
                                                    imageBgColor:
                                                        APPColors.bgColor,
                                                  ),
                                                ),
                                              if (bloc.isMember(
                                                  teamData.members,
                                                  userDataSnap.data!.id!))
                                                Padding(
                                                  padding: PagePadding.custom(
                                                      2.h, 2.h, 0.5.h, 0),
                                                  child:
                                                      ThresholdMetCustomWidget(
                                                    producerName: teamData
                                                            .producer
                                                            ?.businessName ??
                                                        '',
                                                    milestoneTowards: DateFormatUtil
                                                        .amountFormatter(
                                                            currentOrderData
                                                                .minimumTreshold!
                                                                .toDouble()),
                                                    completedMilestone:
                                                        DateFormatUtil
                                                            .amountFormatter(
                                                                currentOrderData
                                                                    .accumulatedAmount!
                                                                    .toDouble()),
                                                    totalDays: DateFormatUtil
                                                        .countDays(
                                                      currentOrderData.deadline!
                                                          .toString(),
                                                    ),
                                                    totalMembers: teamData
                                                        .members!.length
                                                        .toString(),
                                                    percentage: getPercentage(
                                                        currentOrderData),
                                                  ),
                                                ),
                                              if (bloc.isMember(
                                                  teamData.members,
                                                  userDataSnap.data!.id!))
                                                Padding(
                                                  padding: PagePadding.custom(
                                                      2.h, 2.h, 0.5.h, 0),
                                                  child: Container(
                                                    decoration:
                                                        ContainerDecoration
                                                            .boxDecoration(
                                                                bg:
                                                                    APPColors
                                                                        .bgColor,
                                                                border: APPColors
                                                                    .bg_grey25,
                                                                radius: 8,
                                                                width: 1,
                                                                showShadow:
                                                                    true),
                                                    child: Padding(
                                                      padding: PagePadding.all(
                                                          1.5.h),
                                                      child: Column(
                                                        children: [
                                                          BehaviorSubjectBuilder<
                                                                  Members>(
                                                              subject:
                                                                  bloc.isMyTeam,
                                                              builder: (context,
                                                                  myTeamSnap) {
                                                                if (myTeamSnap
                                                                    .hasData) {
                                                                  return StreamBuilder<
                                                                          bool>(
                                                                      initialData:
                                                                          false,
                                                                      stream: _expandableStream
                                                                          .stream,
                                                                      builder:
                                                                          (context,
                                                                              s) {
                                                                        return Container(
                                                                          padding: PagePadding.custom(
                                                                              0,
                                                                              0,
                                                                              2.5.w,
                                                                              0),
                                                                          child:
                                                                              BasketWidget(
                                                                            heading:
                                                                                kYourBasket,
                                                                            orderCount:
                                                                                teamData.count!.order!.toInt(),
                                                                            image:
                                                                                userDataSnap.data!.imageUrl ?? '',
                                                                            name:
                                                                                '${userDataSnap.data!.firstName} ${userDataSnap.data!.lastName}',
                                                                            basket:
                                                                                bloc.getMyOrder(currentOrderData.basket!, userDataSnap.data!.id),
                                                                            callBackExpanded:
                                                                                (val) {
                                                                              _expandableStream.sink.add(val ? false : true);
                                                                            },
                                                                          ),
                                                                        );
                                                                      });
                                                                }

                                                                return const SizedBox
                                                                    .shrink();
                                                              }),
                                                          SizedBox(
                                                            height: 1.w,
                                                          ),
                                                          if (currentOrderData
                                                              .collection!
                                                              .isNotEmpty)
                                                            RabbleButton
                                                                .tertiaryFilled(
                                                              buttonSize:
                                                                  ButtonSize
                                                                      .large,
                                                              bgColor: APPColors
                                                                  .appPrimaryColor,
                                                              child: RabbleText
                                                                  .subHeaderText(
                                                                text:
                                                                    kQRCODETORECEIVEORDER,
                                                                fontSize: 12.sp,
                                                                color: APPColors
                                                                    .appBlack4,
                                                                fontFamily:
                                                                    cGosha,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                NavigatorHelper().navigateTo(
                                                                    '/qrCode',
                                                                    currentOrderData
                                                                        .collection!
                                                                        .first
                                                                        .qrCode);
                                                              },
                                                            ),
                                                          SizedBox(
                                                            height: 1.2.h,
                                                          ),
                                                          RabbleButton
                                                              .tertiaryFilled(
                                                            buttonSize:
                                                                ButtonSize
                                                                    .large,
                                                            bgColor: APPColors
                                                                .appWhite,
                                                            child: RabbleText
                                                                .subHeaderText(
                                                              text: kYS,
                                                              fontSize: 12.sp,
                                                              color: APPColors
                                                                  .appBlue,
                                                              fontFamily:
                                                                  cGosha,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            onPressed: () {
                                                              Members member = teamData
                                                                  .members!
                                                                  .firstWhere((element) =>
                                                                      element
                                                                          .userId ==
                                                                      userDataSnap
                                                                          .data!
                                                                          .id);
                                                              Map dataaa = {
                                                                'teamData':
                                                                    teamData,
                                                                'order':
                                                                    currentOrderData,
                                                                'myId': bloc
                                                                    .isMyTeam
                                                                    .value
                                                                    .id,
                                                                'memberId':
                                                                    member.id,
                                                                'card': member
                                                                        .user!
                                                                        .cardLastFourDigits ??
                                                                    '',
                                                                'deadline':
                                                                    currentOrderData
                                                                        .deadline,
                                                                'status':
                                                                    currentOrderData
                                                                        .status,
                                                                'type': '1'
                                                              };

                                                              NavigatorHelper()
                                                                  .navigateTo(
                                                                      '/subscription_shipment_view',
                                                                      dataaa);
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              teamData.members!.length > 1 &&
                                                      bloc.isMember(
                                                          teamData.members,
                                                          userDataSnap
                                                              .data!.id!) &&
                                                      int.parse(getPercentage(
                                                              currentOrderData)) >=
                                                          100
                                                  ? Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Container(
                                                        padding: PagePadding
                                                            .horizontalSymmetric(
                                                                3.5.w),
                                                        child: RabbleText
                                                            .subHeaderText(
                                                          text: 'Team Orders',
                                                          fontFamily: cPoppins,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 11.sp,
                                                          color:
                                                              APPColors.appBlue,
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox.shrink(),
                                              if (teamData.members!.length >
                                                      1 &&
                                                  bloc.isMember(
                                                      teamData.members,
                                                      userDataSnap.data!.id!) &&
                                                  int.parse(getPercentage(
                                                          currentOrderData)) >=
                                                      100) ...[
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Container(
                                                  padding: PagePadding
                                                      .horizontalSymmetric(
                                                          3.5.w),
                                                  child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      itemCount: teamData
                                                          .members!.length,
                                                      primary: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        Members otherMateData =
                                                            teamData.members![
                                                                index];
                                                        return otherMateData.userId !=
                                                                    userDataSnap
                                                                        .data!
                                                                        .id &&
                                                                bloc.getQuantity(
                                                                    currentOrderData
                                                                        .basket!,
                                                                    otherMateData
                                                                        .userId)
                                                            ? StreamBuilder<
                                                                    bool>(
                                                                initialData:
                                                                    false,
                                                                stream:
                                                                    _expandableStream
                                                                        .stream,
                                                                builder:
                                                                    (context,
                                                                        s) {
                                                                  return BasketWidget(
                                                                    showImage:
                                                                        true,
                                                                    image: otherMateData
                                                                        .user!
                                                                        .imageUrl!,
                                                                    heading: teamData.hostId ==
                                                                            userDataSnap.data!.id
                                                                        ? ' ${otherMateData.user!.firstName} ${otherMateData.user!.lastName}'
                                                                        : ' ${otherMateData.user!.firstName} ${otherMateData.user!.lastName!.length >= 1 ? otherMateData.user!.lastName![0] : ''}',
                                                                    name:
                                                                        '${otherMateData.user!.firstName} ${otherMateData.user!.lastName}',
                                                                    basket: bloc.getMyOrder(
                                                                        currentOrderData
                                                                            .basket!,
                                                                        otherMateData
                                                                            .userId),
                                                                    callBackExpanded:
                                                                        (val) {
                                                                      _expandableStream
                                                                          .sink
                                                                          .add(val
                                                                              ? false
                                                                              : true);
                                                                    },
                                                                  );
                                                                })
                                                            : const SizedBox
                                                                .shrink();
                                                      }),
                                                ),
                                              ],
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              if (bloc.isMember(
                                                  teamData.members,
                                                  userDataSnap.data!.id!))
                                                const Divider(
                                                  thickness: 0.5,
                                                  height: 0.5,
                                                  color: APPColors.bg_grey25,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            bottomNavigationBar: !bloc.isMember(
                                    teamData.members, userDataSnap.data!.id!)
                                ? Container(
                                    padding:
                                        PagePadding.custom(2.h, 2.h, 0, 3.h),
                                    color: Colors.transparent,
                                    child: RabbleButton.tertiaryFilled(
                                      buttonSize: ButtonSize.large,
                                      bgColor: APPColors.appPrimaryColor,
                                      child: RabbleText.subHeaderText(
                                        text: kJoinRabbleHub,
                                        fontSize: 12.sp,
                                        color: APPColors.appBlack4,
                                        fontFamily: cGosha,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      onPressed: () async {
                                        ProducerDetail producerDetail =
                                            ProducerDetail(
                                                imageUrl:
                                                    teamData.producer!.imageUrl,
                                                id: teamData.producer!.id,
                                                businessName: teamData
                                                    .producer!.businessName,
                                                businessAddress: teamData
                                                    .producer!.businessAddress,
                                                website:
                                                    teamData.producer!.website,
                                                categories: teamData
                                                    .producer!.categories!,
                                                count:
                                                    teamData.producer!.count);

                                        Map body = {
                                          'type': true,
                                          'data': producerDetail,
                                          'id': producerDetail.id,
                                          'team': TeamData(
                                            id: teamData.id,
                                            name: teamData.name,
                                            producer: teamData.producer,
                                            producerId: teamData.producerId,
                                          ),
                                          'flow': 'partner'
                                        };

                                        NavigatorHelper()
                                            .navigateTo('/producer', body);
                                      },
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          );
                        });
                  });
        });
  }

  getPercentage(CurrentOrderData currentOrderData) {
    String percentage = DateFormatUtil.calculatePercentage(
        int.parse(currentOrderData.accumulatedAmount!.round().toString()),
        int.parse(currentOrderData.minimumTreshold!.round().toString()));

    if (percentage != '0') {
      return percentage;
    } else {
      double totalPrice = currentOrderData.basket!.fold(
          0,
          (previous, element) =>
              previous +
              double.parse((element.price! * element.quantity!).toString()));

      return DateFormatUtil.calculatePercentage(
          int.parse(totalPrice.round().toString()),
          int.parse(currentOrderData.minimumTreshold!.round().toString()));
    }
  }

  getLabel(TeamData teamData, CurrentOrderData currentOrderData, HubCubit bloc,
      UserModel? data) {
    if (!bloc.isMember(teamData.members, data!.id.toString()) &&
        DateFormatUtil.countDays2(currentOrderData.deadline.toString()) ==
            '0') {
      return 'Next Delivery Date';
    }

    if (!bloc.isMember(teamData.members, data.id.toString()) &&
        DateFormatUtil.countDays2(currentOrderData.deadline.toString()) !=
            '0') {
      return 'Delivery Date';
    }

    if (bloc.isMember(teamData.members, data.id.toString()) &&
        DateFormatUtil.countDays(currentOrderData.deadline.toString()) == '0' &&
        (currentOrderData.confirmationStatus == 'CONFIRMED' ||
            currentOrderData.confirmationStatus == 'PARTIAL') &&
        currentOrderData.collection!.isNotEmpty &&
        currentOrderData.collection?.first.status == 'COLLECTED') {
      String days =
          DateFormatUtil.countDays2(currentOrderData.deadline.toString())
              .replaceAll('-', '');
      return 'You are $days ${days == '1' ? 'day' : 'days'} late';
    }

    if (bloc.isMember(teamData.members, data.id.toString()) &&
        DateFormatUtil.countDays2(currentOrderData.deadline.toString()) ==
            '0' &&
        (currentOrderData.confirmationStatus == 'CONFIRMED' ||
            currentOrderData.confirmationStatus == 'PARTIAL')) {
      return 'Order Delivered';
    }

    if (bloc.isMember(teamData.members, data.id.toString()) &&
        DateFormatUtil.countDays2(currentOrderData.deadline.toString()) !=
            '0' &&
        (currentOrderData.confirmationStatus == 'CONFIRMED' ||
            currentOrderData.confirmationStatus == 'PARTIAL')) {
      return 'Delivery Date';
    }

    if (currentOrderData.collection!.isNotEmpty &&
        currentOrderData.collection?.first.status == 'COLLECTED') {
      return 'Next Delivery Date';
    }

    return 'Delivery Date';
  }

  getStatusDelivery(TeamData teamData, CurrentOrderData currentOrderData,
      HubCubit bloc, UserModel? data) {
    return currentOrderData.confirmationStatus == 'CONFIRMED' ||
        currentOrderData.confirmationStatus == 'PARTIAL' &&
            (currentOrderData.collection!.isEmpty ||
                currentOrderData.collection?.first.status != 'COLLECTED') &&
            DateFormatUtil.countDays2(currentOrderData.deadline!.toString()) !=
                '0';
  }

  getValue(TeamData teamData, CurrentOrderData currentOrderData, HubCubit bloc,
      UserModel? data) {
    int countDays =
        int.parse(DateFormatUtil.countDays2(teamData.nextDeliveryDate));

    print("countDays $countDays");
    if (countDays >= 1) {
      return DateFormatUtil.formatDate(
          teamData.nextDeliveryDate, 'dd MMM yyyy');
    }

    if (countDays <= 0 &&
        bloc.isMember(teamData.members, data!.id.toString()) &&
        (currentOrderData.confirmationStatus == 'CONFIRMED' ||
            currentOrderData.confirmationStatus == 'PARTIAL')) {
      return 'Please pick up your goods';
    }
    return DateFormatUtil.formatDate(teamData.nextDeliveryDate, 'dd MMM yyyy');
  }
}
