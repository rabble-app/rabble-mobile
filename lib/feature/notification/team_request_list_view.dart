import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';
import 'package:rabble/feature/notification/team_request_cubit.dart';

import '../producer/widget/producer_item_shimmer.dart';

class TeamRequestListView extends StatelessWidget {
  const TeamRequestListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, TeamRequestTabCubit>(
        create: (context) => TeamRequestTabCubit(),
        builder: (context, state, bloc) {
          return state.primaryBusy
              ? ListView.builder(
                  itemCount: 50,
                  shrinkWrap: true,
                  padding: PagePadding.onlyRight(3.w),
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return const ProducerItemShimmer();
                  })
              : BehaviorSubjectBuilder<List<RequestSendData>>(
                  subject: bloc.requestListSubject$,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return EmptyStateWidget(
                          isBasket: true,
                          heading: kNoNewRequests,
                          subHeading: kNotificationEmptyDetail,
                          svg: Assets.svgs.request_empty,
                          btnHeading: '',
                          callback: () {});
                    }

                    List<RequestSendData> requestList = snapshot.data!;
                    if (requestList.isEmpty) {
                      return EmptyStateWidget(
                          isBasket: true,
                          heading: kNoNewRequests,
                          subHeading: kNotificationEmptyDetail,
                          svg: Assets.svgs.request_empty,
                          btnHeading: '',
                          callback: () {});
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: BehaviorSubjectBuilder<UserModel>(
                                subject: bloc.currentUserDataSubject$,
                                builder: (context, currentUser) {
                                  if (!snapshot.hasData) return const Empty();
                                  UserModel userData = currentUser.data!;
                                  return Padding(
                                    padding:
                                        PagePadding.custom(4.w, 4.w, 5.w, 2.w),
                                    child: ListView.builder(
                                        itemCount: requestList.length,
                                        itemBuilder:
                                            (BuildContext ctx, int index) {
                                          RequestSendData requestData =
                                              requestList[index];

                                          if (requestData.userId ==
                                              userData.id) {
                                            return InkWell(
                                              onTap: () {
                                                Map map = {
                                                  'teamId': requestData.teamId,
                                                  'type': '1',
                                                  'teamName':
                                                      requestData.team!.name
                                                };

                                                Navigator.pushNamed(context,
                                                        '/threshold_view',
                                                        arguments: map)
                                                    .then((value) {
                                                  // if (value != null) {
                                                  //   callBackIfUpdated.call();
                                                  // }
                                                });
                                              },
                                              child: Container(
                                                margin: PagePadding.onlyBottom(2.w),
                                                decoration: ContainerDecoration
                                                    .boxDecoration(
                                                        bg: Colors.transparent,
                                                        border:
                                                            APPColors.bg_grey25,
                                                        radius: 8,
                                                        width: 1),
                                                child: Padding(
                                                  padding: PagePadding.all(3.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            context.allHeight *
                                                                0.2,
                                                        width:
                                                            context.allWidth *
                                                                0.9,
                                                        child: Stack(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child: SizedBox(
                                                                width: context
                                                                        .allWidth *
                                                                    0.9,
                                                                height: context
                                                                        .allHeight *
                                                                    0.23,
                                                                child:
                                                                    RabbleImageLoader(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  imageUrl: requestData
                                                                          .team!
                                                                          .imageUrl ??
                                                                      '',
                                                                  isRound:
                                                                      false,
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 10,
                                                              right: 10,
                                                              child: requestData
                                                                          .status ==
                                                                      'PENDING'
                                                                  ? Container(
                                                                      height:
                                                                          3.h,
                                                                      padding: PagePadding
                                                                          .horizontalSymmetric(
                                                                              2.w),
                                                                      decoration:
                                                                          ContainerDecoration
                                                                              .boxDecoration(
                                                                        bg: APPColors
                                                                            .appBlack,
                                                                        border:
                                                                            APPColors.appBlack,
                                                                        radius:
                                                                            30,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child: RabbleText
                                                                            .subHeaderText(
                                                                          text:
                                                                              'Request Sent',
                                                                          color:
                                                                              APPColors.appPrimaryColor,
                                                                          fontFamily:
                                                                              cPoppins,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              7.sp,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      width:
                                                                          18.w,
                                                                      height:
                                                                          3.h,
                                                                      decoration:
                                                                          ContainerDecoration
                                                                              .boxDecoration(
                                                                        bg: APPColors
                                                                            .appRedLight2,
                                                                        border:
                                                                            APPColors.appRedLight2,
                                                                        radius:
                                                                            30,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child: RabbleText
                                                                            .subHeaderText(
                                                                          text:
                                                                              'Cancelled',
                                                                          color:
                                                                              APPColors.appRedLight,
                                                                          fontFamily:
                                                                              cPoppins,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              7.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ),
                                                            Positioned(
                                                              top: 0,
                                                              right: 0,
                                                              left: 0,
                                                              bottom: 0,
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: SizedBox(
                                                                  width: context
                                                                          .allWidth *
                                                                      0.6,
                                                                  child: RabbleText
                                                                      .subHeaderText(
                                                                    text:
                                                                        '${requestData.team!.name} ${requestData.team!.postalCode.toString().substring(0, 3)}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: APPColors
                                                                        .appPrimaryColor,
                                                                    fontFamily:
                                                                        cGosha,
                                                                    height: 1,
                                                                    fontSize:
                                                                        30.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      RabbleText.subHeaderText(
                                                        text:
                                                            'Your request to join ',
                                                        color:
                                                            APPColors.bg_grey27,
                                                        fontFamily: cPoppins,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 9.sp,
                                                      ),
                                                      SizedBox(
                                                        height: 0.5.h,
                                                      ),
                                                      RabbleText.subHeaderText(
                                                        text: requestData
                                                                .team!.name ??
                                                            '',
                                                        color:
                                                            APPColors.appBlack4,
                                                        fontFamily: cGosha,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 13.sp,
                                                      ),
                                                      SizedBox(
                                                        height: 0.5.h,
                                                      ),
                                                      RabbleText.subHeaderText(
                                                        text: requestData
                                                                .introduction ??
                                                            '',
                                                        color: APPColors
                                                            .appTextPrimary,
                                                        fontFamily: cPoppins,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 11.sp,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          await bloc
                                                              .onUpdateTeam(
                                                                  requestData
                                                                      .teamId,
                                                                  requestData
                                                                      .id,
                                                                  'REJECTED',context);

                                                        },
                                                        child: Container(
                                                          height: 4.7.h,
                                                          decoration: ContainerDecoration
                                                              .boxDecoration(
                                                                  bg: APPColors
                                                                      .appTextPrimary,
                                                                  border: APPColors
                                                                      .appTextPrimary,
                                                                  radius: 8,
                                                                  width: 1),
                                                          child: Center(
                                                            child: RabbleText
                                                                .subHeaderText(
                                                              text:
                                                                  'Cancel Request',
                                                              fontSize: 13.sp,
                                                              height: 1,
                                                              fontFamily:
                                                                  cGosha,
                                                              color: APPColors
                                                                  .bgColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return RequestItemWidget(
                                              requestData,
                                              joinCallBack: (RequestSendData
                                                  request) async {
                                                    await bloc.onUpdateTeam(
                                                        request.teamId,
                                                        request.id,
                                                        'APPROVED',context);

                                              },
                                              removeCallBack: (RequestSendData
                                                  request) async {
                                                    await bloc.onUpdateTeam(
                                                        request.teamId,
                                                        request.id,
                                                        'REJECTED',context);

                                              },
                                              teamName: requestData.team!.name!,
                                            );
                                          }
                                        }),
                                  );
                                }))
                      ],
                    );
                  });
        });
  }
}
