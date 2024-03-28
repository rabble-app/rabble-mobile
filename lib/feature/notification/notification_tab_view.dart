import 'package:rabble/core/config/export.dart';

class NotificationTabView extends StatefulWidget {
  NotificationTabView({Key? key}) : super(key: key);

  @override
  State<NotificationTabView> createState() => _NotificationTabViewState();
}

class _NotificationTabViewState extends State<NotificationTabView> {
  final _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    RabbleStorage.setFromNotification('0');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, NotificationTabCubit>(
        create: (BuildContext context) => NotificationTabCubit(),
        builder: (BuildContext context, RabbleBaseState state,
            NotificationTabCubit bloc) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(9.h),
                child: RabbleAppbar(
                  backgroundColor: APPColors.bg_app_primary,
                  leadingWidth: 10.h,
                  title: kNotifications,
                )),
            body: Container(
              color: APPColors.bgColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  BehaviorSubjectBuilder<int>(
                      subject: bloc.selectedTapSubject$,
                      builder: (BuildContext context,
                          AsyncSnapshot<int> selectedTapSnapshot) {
                        return Container(
                          margin: PagePadding.horizontalSymmetric(7.w),
                          padding: PagePadding.all(0.5.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: APPColors.appWhite,
                            border:
                                Border.all(width: 2, color: APPColors.appWhite),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                                offset: const Offset(
                                    0, 3), // Offset in the x and y direction
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      child: ManageMemberTabView(
                                        title: kNotifications,
                                        isSelected:
                                            selectedTapSnapshot.data == 0
                                                ? true
                                                : false,
                                        icon: Assets.svgs.notification,
                                        onTap: () {
                                          bloc.selectedTapSubject$.sink.add(0);
                                          _controller.jumpToPage(0);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40.w,
                                      child: ManageMemberTabView(
                                        title: kRequest,
                                        isSelected:
                                            selectedTapSnapshot.data == 1
                                                ? true
                                                : false,
                                        icon: Assets.svgs.request,
                                        onTap: () {
                                          bloc.selectedTapSubject$.sink.add(1);
                                          _controller.jumpToPage(1);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (int page) {
                        bloc.selectedTapSubject$.sink.add(page);
                      },
                      children: [
                        NotificationListView(
                          callBack: () {
                            bloc.selectedTapSubject$.sink.add(1);
                            _controller.jumpToPage(1);

                          },
                        ),
                        const TeamRequestListView(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
