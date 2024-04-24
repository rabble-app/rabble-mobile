import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/UserTeamModel.dart';
import 'package:rabble/feature/buying_team/widget/buying_team_item_shimmer.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, OrderHistoryCubit>(
        create: (context) => OrderHistoryCubit(),
        builder: (context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bg_app_primary,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(9.h),
                child: RabbleAppbar(
                  backTitle: kBack,
                  title: kOrderHistory,
                  leadingWidth: 40.w,
                )),
            body: Padding(
              padding: PagePadding.custom(2.w, 1.w, 0, 0),
              child: state.primaryBusy
                  ? ListView.builder(
                      itemCount: 10,
                      padding: PagePadding.custom(0, 2.w, 3.w, 5.w),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const BuyingTeamItemShimmer();
                      })
                  : BehaviorSubjectBuilder<List<OrderHistoryData>>(
                      subject: bloc.orderHistoryListSubject$,
                      builder: (ctx, snapshot) {
                        if (!snapshot.hasData) {
                          return EmptyStateWidget(
                              isBasket: false,
                              heading: kNoOrderHistoryFound,
                              subHeading: kOrderEmptyDetail,
                              svg: Assets.svgs.history_empty,
                              btnHeading: '',
                              callback: () {});
                        }
                        if (snapshot.data!.isEmpty) {
                          return EmptyStateWidget(
                              isBasket: false,
                              heading: kNoOrderHistoryFound,
                              subHeading: kOrderEmptyDetail,
                              svg: Assets.svgs.history_empty,
                              btnHeading: '',
                              callback: () {
                                NavigatorHelper()
                                    .navigateTo('/producer_list_view', '');
                              });
                        }

                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              if(snapshot.data![index].order==null){
                                return const SizedBox.shrink();
                              }else{
                                Team data = snapshot.data![index].order!.team!;

                                return BuyingTeamItemWidget(
                                  historyData: snapshot.data![index],
                                  teamId: data.id,
                                  isVertical: true,
                                  teamName: data.name,
                                  postalCode: data.postalCode ?? '',
                                  totalTeamMembers: data.count!.members != null
                                      ? data.count!.members!.toString()
                                      : '0',
                                  image: data.imageUrl,
                                  category: '',
                                  status: snapshot.data![index].order!.status,
                                  address: data.producer!.businessAddress,
                                  busniessName: data.producer!.businessName,
                                  frequency: Conversation.getFrequencyText(
                                      data.frequency!.toInt()),
                                  nextDelivery: DateFormatUtil.getNextDeliveryDate(
                                      data.nextDeliveryDate, data.frequency!.toInt()),
                                  producerName: '${data.producer!.businessName}',
                                  hostName: "",
                                  isHost: data.hostId == bloc.userDataSubject$.value.id,
                                  //'${data.host!.firstName ?? ''} ${data.host!.lastName ?? ''}',
                                  callBack: () {
                                    NavigatorHelper().navigateTo(
                                        '/buy_team_order_history_view',
                                        snapshot.data![index]);
                                  },
                                  callBackIfUpdated: () {
                                    bloc.fetchUserData();
                                  },
                                );
                              }

                            });
                      }),
            ),
          );
        });
  }

  String getTotalAmount(List<Basket>? orders) {
    return orders!.fold(
        '0',
        (previousValue, element) =>
            (int.parse(previousValue) + int.parse(element.price.toString()))
                .toString());
  }
}
