import 'package:rabble/core/config/export.dart';

import '../producer/widget/producer_item_shimmer.dart';

class NotificationListView extends StatelessWidget {
  final Function callBack;

  const NotificationListView({Key? key, required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, NotificationTabCubit>(
        create: (context) => NotificationTabCubit()..fetchNotifications(),
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
              : BehaviorSubjectBuilder<List<NotificationData>>(
                  subject: bloc.notificationsListSubject$,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return EmptyStateWidget(
                          isBasket: true,
                          heading: 'No Notifications Found',
                          subHeading:
                              'There are no new notifications at the moment. Stay tuned for updates and important announcements.',
                          svg: Assets.svgs.notification_empty,
                          btnHeading: '',
                          callback: () {});
                    }

                    List<NotificationData> notificationList = snapshot.data!;
                    if (notificationList.isEmpty) {
                      return EmptyStateWidget(
                          isBasket: true,
                          heading: 'No Notifications Found',
                          subHeading:
                              'There are no new notifications at the moment. Stay tuned for updates and important announcements.',
                          svg: Assets.svgs.notification_empty,
                          btnHeading: '',
                          callback: () {});
                    }

                    bloc.readNotifications();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding: PagePadding.custom(5.w, 5.w, 7.w, 2.w),
                        //   child: RabbleText.subHeaderText(
                        //     text: 'TODAY',
                        //     color: APPColors.appBlack,
                        //     fontWeight: FontWeight.normal,
                        //     fontFamily: cGosha,
                        //     fontSize: 10.sp,
                        //   ),
                        // ),

                        SizedBox(
                          height: 2.h,
                        ),
                        Expanded(
                            child: Padding(
                          padding: PagePadding.all(2.w),
                          child: ListView.builder(
                              itemCount: notificationList.length,
                              itemBuilder: (BuildContext context, int index) {
                                NotificationData data = notificationList[index];
                                return NotificationItemWidget(
                                  unread: index % 2 == 0 ? true : false,
                                  title: data.title,
                                  notificationData:data,
                                  desc: data.text, callBack: (){
                                    callBack.call();
                                },
                                );
                              }),
                        ))
                      ],
                    );
                  });
        });
  }
}
