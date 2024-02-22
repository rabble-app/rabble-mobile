import 'package:rabble/config/export.dart';
import 'package:rabble/feature/auth/login/login_modal_view.dart';

final List<Widget> _widgets = [
  const ExploreView(),
  BuyingTeamView(),
  const MessagesView(),
  const MyRabbleAccountView(),
];

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    homeCubit = HomeCubit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      homeCubit.fetchNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, HomeCubit>(
        create: (BuildContext context) => homeCubit..fetchNotifications(),
        builder: (BuildContext context, RabbleBaseState state, HomeCubit bloc) {
          return BehaviorSubjectBuilder<bool>(
              subject: globalBloc.isNotifcation,
              initialData: false,
              builder: (context, snapshot) {
                if (snapshot.data!) {
                  bloc.fetchNotifications();
                }
                return BehaviorSubjectBuilder<int>(
                    subject: bloc.selectedIndex$,
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      return Scaffold(
                        backgroundColor: APPColors.appBlack,
                        body: SafeArea(
                          child: Column(
                            children: [
                              Container(
                                height: context.allHeight * 0.065,
                                color: APPColors.appBlack,
                                child: Padding(
                                  padding: PagePadding.custom(3.w, 3.w, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      PostCodeWidget(
                                        callBack: () async {
                                          String status = await RabbleStorage
                                                  .getLoginStatus() ??
                                              "0";
                                          if (status != '0') {
                                            NavigatorHelper().navigateTo(
                                                '/add_postal_code_view');
                                          } else {
                                            openLoginSheet();
                                          }
                                        },
                                      ),
                                      RabbleText.subHeaderText(
                                        text: bloc.getTitle(snapshot.data),
                                        fontSize: 20.sp,
                                        fontFamily: cGosha,
                                        color: APPColors.appPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: PagePadding.onlyTop(2.w),
                                            child: CartBadgeWidget(
                                              callBack: () async {
                                                String status =
                                                    await RabbleStorage
                                                            .getLoginStatus() ??
                                                        "0";
                                                if (status != '0') {
                                                  NavigatorHelper().navigateTo(
                                                      '/checkout',
                                                      {'type': false});
                                                } else {
                                                  openLoginSheet();
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Padding(
                                            padding: PagePadding.onlyTop(2.w),
                                            child: BehaviorSubjectBuilder<
                                                    List<NotificationData>>(
                                                subject: bloc
                                                    .notificationsListSubject$,
                                                builder: (context, ListSsnapshot) {
                                                  return NotificationBadgeWidget(
                                                    notifcationList:
                                                    ListSsnapshot.hasData
                                                            ? ListSsnapshot.data!
                                                                    .isNotEmpty
                                                                ? ListSsnapshot.data!
                                                                : []
                                                            : [],
                                                    callBack: () async {

                                                      String status =
                                                          await RabbleStorage
                                                                  .getLoginStatus() ??
                                                              "0";
                                                      if (status != '0') {
                                                        NavigatorHelper()
                                                            .navigateTo(
                                                                '/notification_list_view')
                                                            .then((value) {
                                                          if(snapshot.data == 2){
                                                            globalBloc.isBackNotifcation.sink.add(true);
                                                          }
                                                          List<NotificationData>
                                                              tempList = bloc
                                                                  .notificationsListSubject$
                                                                  .value;

                                                          tempList.clear();
                                                          bloc.notificationsListSubject$
                                                              .sink
                                                              .add(tempList);
                                                        });
                                                      } else {
                                                        openLoginSheet();
                                                      }
                                                    },
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(child: _widgets[snapshot.data!])
                            ],
                          ),
                        ),
                        bottomNavigationBar: CustomBottomNavigation(
                          list: _widgets,
                          currentIndex: snapshot.data!,
                          onTap: (i) async {
                            String status =
                                await RabbleStorage.getLoginStatus() ?? "0";
                            if (status != '0') {
                              bloc.selectedIndex$.sink.add(i);
                            } else if (i != 0) {
                              openLoginSheet();
                            }
                          },
                        ),
                      );
                    });
              });
        });
  }

  void openLoginSheet() {
    CustomBottomSheet.showLoginViewModelSheet(context, LoginModalView(), true,
        isRemove: true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
