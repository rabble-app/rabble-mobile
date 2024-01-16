import 'package:rabble/config/export.dart';
import 'package:share_plus/share_plus.dart';

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
                    print('notified');
                    return CubitProvider<RabbleBaseState, ExploreCubit>(
                        create: (context) => exploreCubit..fetchPostalCode(),
                        builder: (context, state, bloc) {
                          return postalCodeSnap.data!.isEmpty
                              ? Container(
                                  color: APPColors.bgColor,
                                  child: PostalCodeEmptyWidget())
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
                                                  callBack: () {
                                                    NavigatorHelper().navigateTo(
                                                        '/search_product_view');
                                                  },
                                                ),
                                                SizedBox(height: 1.5.h),
                                              ],
                                            ),
                                          ),
                                          BehaviorSubjectBuilder<bool>(
                                              subject: bloc
                                                  .visibleShareWidgetSubject,
                                              builder:
                                                  (context, shareSnapshot) {
                                                if (!shareSnapshot.hasData) {
                                                  return const SizedBox
                                                      .shrink();
                                                }
                                                if (shareSnapshot.data!) {
                                                  return Container(
                                                    margin: PagePadding.custom(
                                                        4.w, 3.5.w, 5.w, 0),
                                                    padding:
                                                        PagePadding.all(0.5.w),
                                                    decoration:
                                                        ContainerDecoration
                                                            .boxDecoration(
                                                      bg: APPColors.appWhite,
                                                      border:
                                                          APPColors.appWhite,
                                                      width: 1,
                                                      radius: 8,
                                                      showShadow: true,
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Share.share(
                                                            'Join Rabble, the team buying platform, to support small producers and reduce your community’s carbon footprint\nhttps://apps.apple.com/app/rabble/id6450045487',
                                                            subject:
                                                                'Share Rabble with your friends and local community');
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            PagePadding.all(
                                                                3.w),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 5.h,
                                                              height: 5.h,
                                                              decoration: BoxDecoration(
                                                                  color: APPColors
                                                                      .appPrimaryColor,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: Center(
                                                                child: Assets.svgs.share.svg(
                                                                    width:
                                                                        2.5.h,
                                                                    height:
                                                                        2.5.h,
                                                                    color: APPColors
                                                                        .appBlack),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                RabbleText
                                                                    .subHeaderText(
                                                                  text:
                                                                      'Share Rabble with your friends',
                                                                  fontFamily:
                                                                      cGosha,
                                                                  color: APPColors
                                                                      .appTextPrimary,
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
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
                                                                      TextDecoration
                                                                          .underline,
                                                                  color: APPColors
                                                                      .appBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                )
                                                              ],
                                                            ),
                                                            const Spacer(),
                                                            GestureDetector(
                                                              onTap: () {
                                                                bloc.visibleShareWidgetSubject
                                                                    .sink
                                                                    .add(!shareSnapshot
                                                                        .data!);
                                                                RabbleStorage
                                                                    .setStatusShareWidget(
                                                                        '1');
                                                              },
                                                              child: const Icon(
                                                                Icons.close,
                                                                color: APPColors
                                                                    .bg_grey27,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return const SizedBox.shrink();
                                              }),
                                          snapshot.data!.isEmpty
                                              ? Container(
                                                  color: APPColors.bgColor,
                                                  padding:
                                                      PagePadding.onlyBottom(
                                                          1.h),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5.w,
                                                      ),
                                                      Container(
                                                        margin:
                                                            PagePadding.custom(
                                                                3.w, 3.w, 0, 0),
                                                        child: ViewAllWidget(
                                                          title: sMeetTP,
                                                          showViewAllBtn: true,
                                                          callback: () {
                                                            NavigatorHelper()
                                                                .navigateTo(
                                                                    '/producer_list_view',
                                                                    '');
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: PagePadding
                                                            .onlyLeft(2.w),
                                                        child:
                                                            ProducerListWidget(
                                                          cubit:
                                                              ProducerCubit(),
                                                          isHorizontal: !snapshot
                                                                  .hasData
                                                              ? snapshot.data ==
                                                                      null
                                                                  ? true
                                                                  : false
                                                              : true,
                                                          showLoader: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  color: APPColors.bgColor,
                                                  padding:
                                                      PagePadding.onlyBottom(
                                                          1.h),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5.w,
                                                      ),
                                                      Container(
                                                        margin:
                                                            PagePadding.custom(
                                                                3.w, 3.w, 0, 0),
                                                        child: ViewAllWidget(
                                                          title: sMeetTP,
                                                          showViewAllBtn: true,
                                                          callback: () {
                                                            NavigatorHelper()
                                                                .navigateTo(
                                                                    '/producer_list_view',
                                                                    '');
                                                          },
                                                        ),
                                                      ),
                                                      ProducerListWidget(
                                                        cubit: ProducerCubit(),
                                                        isHorizontal:
                                                            snapshot.hasData
                                                                ? snapshot.data!
                                                                        .isEmpty
                                                                    ? true
                                                                    : false
                                                                : true,
                                                        showLoader: true,
                                                      ),
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      BuyingTeamWidget(
                                                        isHorizontal: true,
                                                        showViewAll: true,
                                                        heading: kBuyingTeams,
                                                        id: bloc.userDataSubject$
                                                                .hasValue
                                                            ? bloc
                                                                .userDataSubject$
                                                                .value
                                                                .id
                                                            : '',
                                                        teamList:
                                                            snapshot.hasData
                                                                ? snapshot.data!
                                                                : [],
                                                        showLoader:
                                                            state.primaryBusy,
                                                        callBackIfUpdated: () {
                                                          bloc.fetchAllBuyingTeamsForPostalCode();
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                )
                                        ],
                                      ),
                                    );
                                  });
                        });
                  });
            }));
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
}
