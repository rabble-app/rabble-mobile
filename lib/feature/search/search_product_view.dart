import 'package:rabble/config/export.dart';
import 'package:rabble/feature/search/popular_search_widget.dart';
import 'package:rabble/feature/search/recent_search_widget.dart';
import 'package:rabble/feature/search/search_shimmer.dart';

class SearchProductView extends StatefulWidget {
  const SearchProductView({Key? key}) : super(key: key);

  @override
  State<SearchProductView> createState() => _SearchProductViewState();
}

class _SearchProductViewState extends State<SearchProductView>
    with SingleTickerProviderStateMixin {
  late SearchCubit searchCubit;

  late TabController tabController;
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchCubit = SearchCubit();
    tabController = TabController(length: 3, vsync: this);
    // searchFocusNode.addListener(() {
    //   if (searchFocusNode.hasFocus) {
    //     searchCubit.searchStarted.sink.add(true);
    //   } else {
    //     List<dynamic> tempList = searchCubit.dynamicListSubject$.hasValue
    //         ? searchCubit.dynamicListSubject$.value
    //         : [];
    //
    //     searchCubit.dynamicListSubject$.sink.add(tempList);
    //     searchCubit.searchStarted.sink.add(false);
    //     searchCubit.currentIndex.sink.add(-1);
    //   }
    // });
  }

  @override
  void dispose() {
    tabController.dispose();
    searchFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, SearchCubit>(
        create: (BuildContext context) => searchCubit..fetchRecentSearch(),
        builder:
            (BuildContext context, RabbleBaseState state, SearchCubit bloc) {
          return FocusChild(
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: APPColors.bgColor,
                body: Column(
                  children: [
                    Container(
                      color: APPColors.appBlack,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 6.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BehaviorSubjectBuilder<int>(
                                  subject: bloc.currentIndex,
                                  builder: (context, snapshot) {
                                    return SearchWidget(
                                        title: kSearch,
                                        focusNode: searchFocusNode,
                                        searchCubit: searchCubit,
                                        currentIndex: snapshot.data);
                                  }),
                              GestureDetector(
                                onTap: () {
                                  NavigatorHelper().pop();
                                },
                                child: Container(
                                  margin: PagePadding.onlyTop(2.w),
                                  child: RabbleText.subHeaderText(
                                    text: kCancel,
                                    fontFamily: cPoppins,
                                    color: APPColors.bg_grey26,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          BehaviorSubjectBuilder<int>(
                              subject: bloc.currentIndex,
                              builder: (context, snapshot) {
                                return TabBar(
                                  indicatorColor: APPColors.appPrimaryColor,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorWeight: 4,
                                  controller: tabController,
                                  onTap: !state.primaryBusy
                                      ? (index) {
                                    if (!state.primaryBusy) {
                                      bloc.currentIndex.sink.add(index);
                                      bloc.searchProduct(index);
                                    }
                                  }
                                      : null,
                                  tabs: [
                                    Tab(
                                      child: RabbleText.subHeaderText(
                                        text: 'Suppliers',
                                        fontSize: 13.sp,
                                        color: snapshot.data == 0
                                            ? APPColors.bg_grey26
                                            : APPColors.bg_grey25,
                                        fontFamily: cGosha,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Tab(
                                      child: RabbleText.subHeaderText(
                                        text: 'Products',
                                        fontSize: 13.sp,
                                        color: snapshot.data == 1
                                            ? APPColors.bg_grey26
                                            : APPColors.bg_grey25,
                                        fontFamily: cGosha,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Tab(
                                      child: RabbleText.subHeaderText(
                                        text: 'Teams',
                                        fontSize: 13.sp,
                                        color: snapshot.data == 2
                                            ? APPColors.bg_grey26
                                            : APPColors.bg_grey25,
                                        fontFamily: cGosha,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),
                    state.primaryBusy
                        ? const Expanded(child: SearchShimmer())
                        : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BehaviorSubjectBuilder<bool>(
                                subject: bloc.searchStarted,
                                initialData: false,
                                builder: (context, searchStarted) {
                                  return BehaviorSubjectBuilder<
                                      List<RecentSearchData>>(
                                      subject: bloc.recentSearchListSubject$,
                                      builder: (context, recentSearchSnap) {
                                        return BehaviorSubjectBuilder<int>(
                                            subject: bloc.currentIndex,
                                            builder: (context, snapshot) {
                                              int currentIndex = snapshot.data!;

                                              print(currentIndex);

                                              return BehaviorSubjectBuilder<
                                                  List<dynamic>>(
                                                  subject:
                                                  bloc.dynamicListSubject$,
                                                  builder: (context, snapshot) {
                                                    if (recentSearchSnap
                                                        .data!.isEmpty &&
                                                        !searchStarted.data!) {
                                                      return EmptyStateWidget(
                                                          heading:
                                                          'Search Rabble',
                                                          subHeading:
                                                          'Find exceptional products and people near '
                                                              'you that are buying direct from small producers',
                                                          svg: Assets
                                                              .svgs.search_view,
                                                          btnHeading: '',
                                                          callback: () {});
                                                    }
                                                    if (recentSearchSnap
                                                        .data!.isNotEmpty &&
                                                        !searchStarted.data!) {
                                                      return RecentSearchWidget(
                                                        recentSearchSnap.data !=
                                                            null &&
                                                            recentSearchSnap
                                                                .data!
                                                                .isNotEmpty
                                                            ? recentSearchSnap
                                                            .data!
                                                            : [],
                                                        callBack: (String val) {
                                                          bloc.controller.text =
                                                              val;
                                                          bloc.searchProduct(
                                                              currentIndex);
                                                        },
                                                        callBackClear: () {
                                                          bloc
                                                              .clearRecentSearch();
                                                        },
                                                        removeCallBack: (int id,
                                                            int index) {
                                                          bloc.removeSearch(
                                                              id, index);
                                                        },
                                                      );;
                                                    }
                                                    if (currentIndex == 0 &&
                                                        snapshot.hasData) {
                                                      BehaviorSubject<
                                                          List<
                                                              ProducerDetail>>
                                                      producerListSubject$ =
                                                      BehaviorSubject<
                                                          List<
                                                              ProducerDetail>>();

                                                      List<ProducerDetail>
                                                      producerList =
                                                      snapshot.data!
                                                          .map((entry) =>
                                                          ProducerDetail
                                                              .fromJson(
                                                              entry))
                                                          .toList();
                                                      producerListSubject$.sink
                                                          .add(producerList);

                                                      if (producerList
                                                          .isEmpty) {
                                                        return EmptyStateWidget(
                                                            loader:
                                                            'assets/json/NoSearch.json',
                                                            heading:
                                                            'No Suppliers Found',
                                                            subHeading:
                                                            'There are no suppliers matching your search criteria at the moment.',
                                                            svg: Assets.svgs
                                                                .search_view,
                                                            btnHeading: '',
                                                            callback: () {});
                                                      } else {
                                                        return ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                            NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                            producerList
                                                                .length,
                                                            scrollDirection:
                                                            Axis.vertical,
                                                            padding:
                                                            EdgeInsets.only(
                                                                top: 1.h,
                                                                left: 1.w,
                                                                right: 1.w),
                                                            itemBuilder:
                                                                (context,
                                                                index) {
                                                              return ProducerItemWidget(
                                                                producerDetail:
                                                                producerList[
                                                                index],
                                                              );
                                                            });
                                                      }
                                                    } else if (currentIndex ==
                                                        1 &&
                                                        snapshot.hasData) {
                                                      BehaviorSubject<
                                                          List<
                                                              ProductDetail>>
                                                      productListSubject$ =
                                                      BehaviorSubject<
                                                          List<
                                                              ProductDetail>>();
                                                      List<ProductDetail>
                                                      productList = snapshot
                                                          .data!
                                                          .map((entry) =>
                                                          ProductDetail
                                                              .fromJson(
                                                              entry))
                                                          .toList();
                                                      productListSubject$.sink
                                                          .add(productList);
                                                      var size =
                                                          MediaQuery
                                                              .of(context)
                                                              .size;

                                                      final double itemHeight =
                                                          (size.height -
                                                              kToolbarHeight -
                                                              24) /
                                                              2;
                                                      final double itemWidth =
                                                          size.width / 2;

                                                      if (productList.isEmpty) {
                                                        return EmptyStateWidget(
                                                            loader:
                                                            'assets/json/NoSearch.json',
                                                            heading:
                                                            'No Products Found',
                                                            subHeading:
                                                            'There are no products matching your search criteria at the moment.',
                                                            svg: Assets.svgs
                                                                .search_view,
                                                            btnHeading: '',
                                                            callback: () {});
                                                      } else {
                                                        return GridView.builder(
                                                          itemCount: productList
                                                              .length,
                                                          shrinkWrap: true,
                                                          padding: EdgeInsets
                                                              .only(top: 2.h),

                                                          physics:
                                                          NeverScrollableScrollPhysics(),
                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              childAspectRatio:
                                                              (itemWidth /
                                                                  itemHeight)),
                                                          itemBuilder:
                                                              (BuildContext
                                                          context,
                                                              int index) {
                                                            ProducerDetail producerDetail = ProducerDetail(id: productList[
                                                            index].producerId);
                                                            return ProductItemWidget(
                                                              businessDetail:producerDetail,
                                                              isEmpty: {},
                                                              productList[
                                                              index],
                                                              isHorizontal:
                                                              false,
                                                            );
                                                          },
                                                        );
                                                      }
                                                    } else if (currentIndex ==
                                                        2 &&
                                                        snapshot.hasData) {
                                                      BehaviorSubject<
                                                          List<
                                                              BuyingTeamDetail>>
                                                      buyingTeamListSubject$ =
                                                      BehaviorSubject<
                                                          List<
                                                              BuyingTeamDetail>>();
                                                      List<BuyingTeamDetail>
                                                      teamList = snapshot
                                                          .data!
                                                          .map((entry) =>
                                                          BuyingTeamDetail
                                                              .fromJson(
                                                              entry))
                                                          .toList();
                                                      buyingTeamListSubject$
                                                          .sink
                                                          .add(teamList);

                                                      if (teamList.isEmpty) {
                                                        return EmptyStateWidget(
                                                            loader:
                                                            'assets/json/NoSearch.json',
                                                            heading:
                                                            'No Teams Found',
                                                            subHeading:
                                                            'You can try again later or consider starting your own team with like-minded individuals to enjoy the benefits of collective buying power.',
                                                            svg: Assets.svgs
                                                                .search_view,
                                                            btnHeading: '',
                                                            callback: () {});
                                                      } else {
                                                        return BuyingTeamWidget(
                                                          isHorizontal: false,
                                                          showViewAll: false,
                                                          heading: '',
                                                          showLoader:
                                                          state.primaryBusy,
                                                          teamList: teamList,
                                                          callBackIfUpdated: () {
                                                            bloc.searchProduct(
                                                                currentIndex);
                                                          },
                                                        );
                                                      }
                                                    } else {
                                                      return RecentSearchWidget(
                                                        recentSearchSnap.data !=
                                                            null &&
                                                            recentSearchSnap
                                                                .data!
                                                                .isNotEmpty
                                                            ? recentSearchSnap
                                                            .data!
                                                            : [],
                                                        callBack: (String val) {
                                                          bloc.controller.text =
                                                              val;
                                                          bloc.searchProduct(
                                                              currentIndex);
                                                        },
                                                        callBackClear: () {
                                                          bloc
                                                              .clearRecentSearch();
                                                        },
                                                        removeCallBack: (int id,
                                                            int index) {
                                                          bloc.removeSearch(
                                                              id, index);
                                                        },
                                                      );
                                                    }
                                                  });
                                            });
                                      });
                                }
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
