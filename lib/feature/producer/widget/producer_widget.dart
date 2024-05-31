import 'package:rabble/core/config/export.dart';
import 'package:rabble/feature/producer/widget/producer_item_shimmer.dart';

class ProducerListWidget extends StatelessWidget {
  final bool isHorizontal;
  final bool? showViewAll;
  final bool? showHeading;
  final bool? showLoader;
  final String? id;
  final ProducerCubit cubit;

  const ProducerListWidget(
      {Key? key,
      required this.isHorizontal,
      this.showViewAll,
      this.showHeading,
      this.showLoader,
      this.id,
      required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, ProducerCubit>(
        create: (context) => cubit..fetchProducerList(),
        builder: (context, state, bloc) {
          return BehaviorSubjectBuilder<List<ProducerDetail>>(
              subject: bloc.producerListSubject$,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return !isHorizontal
                      ? SizedBox(
                          height: context.allHeight * 0.33,
                          child: ListView.builder(
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return const ProducerItemShimmer();
                              }),
                        )
                      : ListView.builder(
                          itemCount: 50,
                          shrinkWrap: true,
                          padding: PagePadding.onlyRight(3.w),
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return const ProducerItemShimmer();
                          });
                }
                if (snapshot.data!.isEmpty) return const Empty();

                return !isHorizontal
                    ? Column(
                        children: [
                          SizedBox(
                            height: 5.w,
                          ),
                          if (showViewAll! && snapshot.data!.isNotEmpty)
                            Container(
                              margin: PagePadding.custom(3.w, 3.w, 0, 0),
                              child: ViewAllWidget(
                                title: sMeetTP,
                                showViewAllBtn: true,
                                callback: () {
                                  NavigatorHelper()
                                      .navigateTo('/producer_list_view', '');
                                },
                              ),
                            ),
                          SizedBox(
                            height: context.allHeight * 0.40,
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
                      )
                    : Column(
                        children: [
                          if(showViewAll!)
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
                          ListView.builder(
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: isHorizontal && showLoader!
                                  ? EdgeInsets.zero
                                  : PagePadding.onlyRight(3.w),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ProducerItemWidget(
                                  producerDetail: snapshot.data![index],
                                );
                              }),
                          if (state.tertiaryBusy)
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  transform:
                                      Matrix4.translationValues(0, -6.h, 0),
                                  child:
                                      const RabbleSecondaryScreenProgressIndicator(
                                          enabled: true),
                                ))
                        ],
                      );
              });
        });
  }
}
