import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';
import 'package:rabble/domain/entities/hub/AllPartnerTeamsModel.dart';
import 'package:rabble/domain/entities/mock/mock_hub_model.dart';

import '../producer/widget/producer_item_shimmer.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> with WidgetsBindingObserver {
  late ExploreCubit exploreCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    exploreCubit = ExploreCubit();
    //  getDeepLinkData();
    WidgetsBinding.instance.addObserver(this);
    if (Platform.isIOS) {
      SystemChannels.lifecycle.setMessageHandler((message) async {
        if (message == 'AppLifecycleState.resumed') {
          didChangeAppLifecycleState(AppLifecycleState.resumed);
        }
        return '';
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(10.sp);
    return Scaffold(
        backgroundColor: APPColors.bgColor,
        body: BehaviorSubjectBuilder<bool>(
            subject: PostalCodeService().ispostalCodeChangedGlobalSubject,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data!) {
                exploreCubit.fetchPostalCode();
              }
              return BehaviorSubjectBuilder<String>(
                  subject: PostalCodeService().postalCodeGlobalSubject,
                  builder: (context, postalCodeSnap) {
                    return CubitProvider<RabbleBaseState, ExploreCubit>(
                        create: (context) => exploreCubit..fetchPostalCode(),
                        builder: (context, state, bloc) {
                          return postalCodeSnap.data!.isEmpty
                              ? Container(
                                  color: APPColors.bgColor,
                                  child: const PostalCodeEmptyWidget())
                              : BehaviorSubjectBuilder<List<BuyingTeamDetail>>(
                                  subject: bloc.allTeamListSubject$,
                                  builder: (context, snapshot) {
                                    return SingleChildScrollView(
                                      physics: snapshot.hasData
                                          ? const ClampingScrollPhysics()
                                          : const ScrollPhysics(),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100.w,
                                            color: APPColors.appBlack,
                                            child: Column(
                                              children: [
                                                SearchWidget(
                                                  title: kSearch,
                                                  searchCubit: SearchCubit(),
                                                  callBack: () async {
                                                    String status =
                                                        await RabbleStorage()
                                                                .getLoginStatus() ??
                                                            "0";
                                                    if (status != '0') {
                                                      NavigatorHelper().navigateTo(
                                                          '/search_product_view');
                                                    } else {
                                                      openLoginSheet();
                                                    }
                                                  },
                                                ),
                                                SizedBox(height: 1.5.h),
                                              ],
                                            ),
                                          ),
                                          state.primaryBusy
                                              ? ListView.builder(
                                                  itemCount: 50,
                                                  shrinkWrap: true,
                                                  padding:
                                                      PagePadding.onlyRight(
                                                          3.w),
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return const ProducerItemShimmer();
                                                  })
                                              : Column(
                                                  children: [
                                                    BehaviorSubjectBuilder<
                                                            bool>(
                                                        subject: bloc
                                                            .visibleShareWidgetSubject,
                                                        builder: (context,
                                                            shareSnapshot) {
                                                          if (!shareSnapshot
                                                              .hasData) {
                                                            return const SizedBox
                                                                .shrink();
                                                          }
                                                          if (shareSnapshot
                                                              .data!) {
                                                            return Container(
                                                              margin:
                                                                  PagePadding
                                                                      .custom(
                                                                          4.w,
                                                                          3.5.w,
                                                                          5.w,
                                                                          0),
                                                              padding:
                                                                  PagePadding
                                                                      .all(0.5
                                                                          .w),
                                                              decoration:
                                                                  ContainerDecoration
                                                                      .boxDecoration(
                                                                bg: APPColors
                                                                    .appWhite,
                                                                border: APPColors
                                                                    .appWhite,
                                                                width: 1,
                                                                radius: 8,
                                                                showShadow:
                                                                    true,
                                                              ),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Share.share(
                                                                      'Hey, I thought you might like Rabble, the team buying platform for high quality, sustainable products at heavily discounted prices\nhttps://apps.apple.com/app/rabble/id6450045487',
                                                                      subject:
                                                                          'Share Rabble with your friends and local community');
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      PagePadding
                                                                          .all(3
                                                                              .w),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            5.h,
                                                                        height:
                                                                            5.h,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                APPColors.appPrimaryColor,
                                                                            shape: BoxShape.circle),
                                                                        child:
                                                                            Center(
                                                                          child: Assets.svgs.share.svg(
                                                                              width: 2.5.h,
                                                                              height: 2.5.h,
                                                                              color: APPColors.appBlack),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            2.w,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          RabbleText
                                                                              .subHeaderText(
                                                                            text:
                                                                                'Share Rabble with your friends',
                                                                            fontFamily:
                                                                                cGosha,
                                                                            color:
                                                                                APPColors.appTextPrimary,
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                          RabbleText
                                                                              .subHeaderText(
                                                                            text:
                                                                                'Invite Friends',
                                                                            fontFamily:
                                                                                cPoppins,
                                                                            fontSize:
                                                                                12.sp,
                                                                            textDecoration:
                                                                                TextDecoration.underline,
                                                                            color:
                                                                                APPColors.appBlue,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      const Spacer(),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          bloc.visibleShareWidgetSubject
                                                                              .sink
                                                                              .add(!shareSnapshot.data!);
                                                                          RabbleStorage()
                                                                              .setStatusShareWidget('1');
                                                                        },
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              APPColors.bg_grey27,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          return const SizedBox
                                                              .shrink();
                                                        }),
                                                    snapshot.data!.isEmpty
                                                        ? Container(
                                                            color: APPColors
                                                                .bgColor,
                                                            padding: PagePadding
                                                                .onlyBottom(
                                                                    1.h),
                                                            child: Column(
                                                              children: [
                                                                BehaviorSubjectBuilder<
                                                                        List<
                                                                            ProducerDetail>>(
                                                                    subject: bloc
                                                                        .producerListSubject$,
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return const Empty();
                                                                      }
                                                                      return Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                5.w,
                                                                          ),
                                                                          if (snapshot
                                                                              .data!
                                                                              .isNotEmpty) ...[
                                                                            Container(
                                                                              margin: PagePadding.custom(3.w, 3.w, 0, 0),
                                                                              child: ViewAllWidget(
                                                                                title: sMeetTP,
                                                                                showViewAllBtn: true,
                                                                                callback: () {
                                                                                  NavigatorHelper().navigateTo('/producer_list_view', '');
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              margin: PagePadding.custom(3.w, 3.w, 2.w, 0),
                                                                              child: RabbleText.subHeaderText(
                                                                                text: 'Suppliers offering fresh, quality products.',
                                                                                fontSize: 11.sp,
                                                                                textAlign: TextAlign.start,
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 1.1,
                                                                                fontFamily: cPoppins,
                                                                                color: APPColors.bg_grey27,
                                                                              ),
                                                                            )
                                                                          ],
                                                                          ListView.builder(
                                                                              itemCount: snapshot.data!.length,
                                                                              physics: const NeverScrollableScrollPhysics(),
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              itemBuilder: (context, index) {
                                                                                var data = snapshot.data![index];
                                                                                return ProducerItemWidget(
                                                                                  producerDetail: data,
                                                                                );
                                                                              }),
                                                                        ],
                                                                      );
                                                                    }),
                                                                BehaviorSubjectBuilder<
                                                                        List<
                                                                            PartnersTeamData>>(
                                                                    subject: bloc
                                                                        .partnerListSubject$,
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (!snapshot
                                                                          .hasData)
                                                                        return const Empty();
                                                                      return Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            margin: PagePadding.custom(
                                                                                3.w,
                                                                                3.w,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                ViewAllWidget(
                                                                              title: '$kRabbleHubs In ${postalCodeSnap.data!.length <= 3 ? "" : postalCodeSnap.data!.substring(0, postalCodeSnap.data!.length - 3)}',
                                                                              showViewAllBtn: true,
                                                                              callback: () {
                                                                                NavigatorHelper().navigateTo('/AllPartnersTeams');
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin: PagePadding.custom(
                                                                                3.w,
                                                                                3.w,
                                                                                2.w,
                                                                                0),
                                                                            child:
                                                                                RabbleText.subHeaderText(
                                                                              text: 'Buying teams fulfilled through local businesses.',
                                                                              fontSize: 11.sp,
                                                                              textAlign: TextAlign.start,
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 1.1,
                                                                              fontFamily: cPoppins,
                                                                              color: APPColors.bg_grey27,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                0.5.h,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                context.allHeight * 0.35,
                                                                            width:
                                                                                context.allWidth,
                                                                            child: ListView.builder(
                                                                                scrollDirection: Axis.horizontal,
                                                                                itemCount: snapshot.data?.length,
                                                                                physics: const ClampingScrollPhysics(),
                                                                                itemBuilder: (context, index) {
                                                                                  PartnersTeamData? partnerData = snapshot.data?[index];
                                                                                  bloc.calculateDistanceFromPostalCode(partnerData!.postalCode ?? '', index);

                                                                                  return HubWidget(
                                                                                    teamId: partnerData.id,
                                                                                    isHorizontal: true,
                                                                                    teamName: '${partnerData.name}',
                                                                                    frequency: Conversation.getFrequencyText(partnerData.frequency!.toInt()),
                                                                                    totalTeamMembers: partnerData.members?.length.toString(),
                                                                                    category: partnerData.producer?.categories?.first.category?.name,
                                                                                    nextDelivery: DateFormatUtil.getNextDeliveryDate(partnerData.nextDeliveryDate, partnerData.frequency!.toInt()),
                                                                                    isVertical: false,
                                                                                    postalCode: partnerData.postalCode,
                                                                                    callBack: () {
                                                                                      NavigatorHelper().navigateTo('/PartnerTeam');
                                                                                    },
                                                                                    callBackIfUpdated: () {},
                                                                                  );
                                                                                }),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    })
                                                              ],
                                                            ),
                                                          )
                                                        : Container(
                                                            color: APPColors
                                                                .bgColor,
                                                            padding: PagePadding
                                                                .onlyBottom(
                                                                    1.h),
                                                            child: Column(
                                                              children: [
                                                                BehaviorSubjectBuilder<
                                                                        List<
                                                                            ProducerDetail>>(
                                                                    subject: bloc
                                                                        .producerListSubject$,
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (!snapshot
                                                                          .hasData)
                                                                        return const Empty();

                                                                      return Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                5.w,
                                                                          ),
                                                                          if (snapshot
                                                                              .data!
                                                                              .isNotEmpty) ...[
                                                                            Container(
                                                                              margin: PagePadding.custom(3.w, 3.w, 0, 0),
                                                                              child: ViewAllWidget(
                                                                                title: sMeetTP,
                                                                                showViewAllBtn: true,
                                                                                callback: () {
                                                                                  NavigatorHelper().navigateTo('/producer_list_view', '');
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              margin: PagePadding.custom(3.w, 3.w, 2.w, 0),
                                                                              child: RabbleText.subHeaderText(
                                                                                text: 'Suppliers offering fresh, quality products.',
                                                                                fontSize: 11.sp,
                                                                                textAlign: TextAlign.start,
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 1.1,
                                                                                fontFamily: cPoppins,
                                                                                color: APPColors.bg_grey27,
                                                                              ),
                                                                            )
                                                                          ],
                                                                          SizedBox(
                                                                            height:
                                                                                context.allHeight * 0.40,
                                                                            child: ListView.builder(
                                                                                itemCount: snapshot.data!.length,
                                                                                physics: const ClampingScrollPhysics(),
                                                                                scrollDirection: Axis.horizontal,
                                                                                itemBuilder: (context, index) {
                                                                                  var data = snapshot.data![index];
                                                                                  return ProducerItemWidget(
                                                                                    producerDetail: data,
                                                                                  );
                                                                                }),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    }),
                                                                BehaviorSubjectBuilder<
                                                                        List<
                                                                            BuyingTeamDetail>>(
                                                                    subject: bloc
                                                                        .allTeamListSubject$,
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return const Empty();
                                                                      }
                                                                      return Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            margin: PagePadding.custom(
                                                                                3.w,
                                                                                3.w,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                ViewAllWidget(
                                                                              title: '$kBuyingTeams In ${postalCodeSnap.data}',
                                                                              showViewAllBtn: true,
                                                                              callback: () {
                                                                                NavigatorHelper().navigateTo('/all_buying_teams_view', {});
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin: PagePadding.custom(
                                                                                3.w,
                                                                                3.w,
                                                                                2.w,
                                                                                0),
                                                                            child:
                                                                                RabbleText.subHeaderText(
                                                                              text: 'Local buying teams organised by customers like you.',
                                                                              fontSize: 11.sp,
                                                                              textAlign: TextAlign.start,
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 1.1,
                                                                              fontFamily: cPoppins,
                                                                              color: APPColors.bg_grey27,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                0.5.h,
                                                                          ),
                                                                          BehaviorSubjectBuilder<UserModel>(
                                                                              subject: bloc.userDataSubject$,
                                                                              builder: (context, userDataSnap) {
                                                                                return SizedBox(
                                                                                  height: context.allHeight * 0.42,
                                                                                  child: ListView.builder(
                                                                                      scrollDirection: Axis.horizontal,
                                                                                      itemCount: snapshot.data!.length,
                                                                                      physics: const ClampingScrollPhysics(),
                                                                                      itemBuilder: (context, index) {
                                                                                        var data = snapshot.data![index];
                                                                                        return BuyingTeamItemWidget(
                                                                                          isVertical: false,
                                                                                          teamId: data.id,
                                                                                          image: data.imageUrl ?? '',
                                                                                          teamName: data.name,
                                                                                          postalCode: data.postalCode ?? '',
                                                                                          busniessName: data.producer!.businessName,
                                                                                          status: userDataSnap.data?.id == data.hostId ? '' : getStatus(snapshot.data![index].members, snapshot.data![index].requests, userDataSnap.data?.id),
                                                                                          frequency: Conversation.getFrequencyText(data.frequency!.toInt()),
                                                                                          category: data.producer!.categories != null && data.producer!.categories!.isNotEmpty && data.producer!.categories!.first.category != null ? data.producer!.categories!.first.category!.name : '',
                                                                                          nextDelivery: DateFormatUtil.getNextDeliveryDate(data.nextDeliveryDate, data.frequency!.toInt()),
                                                                                          producerName: '${data.host!.firstName ?? ''} ${data.host!.lastName ?? ''}',
                                                                                          totalTeamMembers: data.members == null ? '0' : data.members!.length.toString(),
                                                                                          hostName: '${data.host!.firstName ?? ''} ${data.host!.lastName ?? ''}',
                                                                                          callBackIfUpdated: () {
                                                                                            bloc.fetchHomeData();
                                                                                          },
                                                                                          callBack: () {
                                                                                            if (data.basket!.isEmpty) {
                                                                                              ProducerDetail producerDetail = ProducerDetail(imageUrl: data.producer!.imageUrl, id: data.producer!.id, businessName: data.producer!.businessName, businessAddress: data.producer!.businessAddress, website: data.producer!.website, categories: data.producer!.categories!, count: data.producer!.count);

                                                                                              Map body = {
                                                                                                'type': true,
                                                                                                'data': producerDetail,
                                                                                                'id': producerDetail.id,
                                                                                                'team': TeamData(
                                                                                                  id: data.id,
                                                                                                  name: data.name,
                                                                                                  producerId: data.producerId,
                                                                                                )
                                                                                              };
                                                                                              BuyingTeamCreationService().addTeamCreationData(mFrequency, data.frequency?.toInt());
                                                                                              RabbleStorage().setInivitationData(json.encode(InvitationData(producerInfo: data.producer, teamId: data.id, teamName: data.name)));

                                                                                              NavigatorHelper().navigateTo('/producer', body);
                                                                                            } else {
                                                                                              Map map = {
                                                                                                'teamId': data.id,
                                                                                                'type': '1',
                                                                                                'teamName': data.name
                                                                                              };

                                                                                              Navigator.pushNamed(context, '/threshold_view', arguments: map).then((value) {
                                                                                                //       widget.callBackIfUpdated.call();
                                                                                              });
                                                                                            }
                                                                                          },
                                                                                        );
                                                                                      }),
                                                                                );
                                                                              }),
                                                                        ],
                                                                      );
                                                                    }),
                                                                SizedBox(
                                                                  height: 3.h,
                                                                ),
                                                                BehaviorSubjectBuilder<
                                                                        List<
                                                                            PartnersTeamData>>(
                                                                    subject: bloc
                                                                        .partnerListSubject$,
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (!snapshot
                                                                          .hasData)
                                                                        return const Empty();
                                                                      return Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            margin: PagePadding.custom(
                                                                                3.w,
                                                                                3.w,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                ViewAllWidget(
                                                                              title: '$kRabbleHubs In ${postalCodeSnap.data!.length <= 3 ? "" : postalCodeSnap.data!.substring(0, postalCodeSnap.data!.length - 3)}',
                                                                              showViewAllBtn: true,
                                                                              callback: () {
                                                                                NavigatorHelper().navigateTo('/AllPartnersTeams');
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin: PagePadding.custom(
                                                                                3.w,
                                                                                3.w,
                                                                                2.w,
                                                                                0),
                                                                            child:
                                                                                RabbleText.subHeaderText(
                                                                              text: 'Buying teams fulfilled through local businesses.',
                                                                              fontSize: 11.sp,
                                                                              textAlign: TextAlign.start,
                                                                              fontWeight: FontWeight.w400,
                                                                              height: 1.1,
                                                                              fontFamily: cPoppins,
                                                                              color: APPColors.bg_grey27,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                0.5.h,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                context.allHeight * 0.35,
                                                                            width:
                                                                                context.allWidth,
                                                                            child: ListView.builder(
                                                                                scrollDirection: Axis.horizontal,
                                                                                itemCount: snapshot.data?.length,
                                                                                physics: const ClampingScrollPhysics(),
                                                                                itemBuilder: (context, index) {
                                                                                  PartnersTeamData? partnerData = snapshot.data?[index];
                                                                                  bloc.calculateDistanceFromPostalCode(partnerData!.postalCode ?? '', index);

                                                                                  return HubWidget(
                                                                                    teamId: partnerData.id,
                                                                                    isHorizontal: true,
                                                                                    teamName: '${partnerData.name}',
                                                                                    frequency: Conversation.getFrequencyText(partnerData.frequency!.toInt()),
                                                                                    totalTeamMembers: partnerData.members?.length.toString(),
                                                                                    category: partnerData.producer!.categories!.isNotEmpty ? partnerData.producer?.categories?.first.category?.name : '',
                                                                                    nextDelivery: DateFormatUtil.getNextDeliveryDate(partnerData.nextDeliveryDate, partnerData.frequency!.toInt()),
                                                                                    isVertical: false,
                                                                                    postalCode: partnerData.postalCode,
                                                                                    callBack: () {
                                                                                      NavigatorHelper().navigateTo('/PartnerTeam');
                                                                                    },
                                                                                    callBackIfUpdated: () {},
                                                                                  );
                                                                                }),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    })
                                                              ],
                                                            ),
                                                          ),
                                                  ],
                                                )
                                        ],
                                      ),
                                    );
                                  });
                        });
                  });
            }));
  }

  void openLoginSheet() {
    CustomBottomSheet.showLoginViewModelSheet(context, LoginModalView(), true,
        isRemove: true);
  }

  Future<void> getDeepLinkData() async {
    FlutterBranchSdk.getLatestReferringParams().then((value) {
      handleDeepLinkParameters(value);
    });
  }

  void handleDeepLinkParameters(Map<dynamic, dynamic> data) {
    bool isClickedLink = data["+clicked_branch_link"] ?? false;
    if ((data['token'] != null && isClickedLink)) {}
  }

  getStatus(List<BuyingTeamMembers>? members, List<RequestSendData>? requests,
      String? id) {
    BuyingTeamMembers? member = members!.firstWhere(
        (element) => element.userId == id,
        orElse: () => BuyingTeamMembers());
    if (member != null && member.id != null) {
      return member.status;
    } else {
      if (requests != null) {
        RequestSendData? request = requests.firstWhere(
            (element) => element.userId == id,
            orElse: () => RequestSendData());
        if (request != null && request.id != null) {
          return request.status;
        } else
          return '';
      }

      return '';
    }
  }
}
