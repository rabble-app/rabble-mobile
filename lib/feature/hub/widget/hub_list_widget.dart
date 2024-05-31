import 'package:rabble/domain/entities/mock/mock_hub_model.dart';
import 'package:rabble/feature/hub/hub_cubit.dart';

import '../../../core/config/export.dart';

class HubListWidget extends StatelessWidget {
  final bool? isHorizontal;
  final bool? showViewAll;

  const HubListWidget(
      {super.key, this.isHorizontal = true, this.showViewAll = true});

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, HubCubit>(
        create: (context) => HubCubit(),
        builder: (context, state, bloc) {
          return Column(
            children: [
              if (showViewAll!)
                Container(
                  margin: PagePadding.custom(3.w, 3.w, 0, 0),
                  child: ViewAllWidget(
                    title: kRabbleHubs,
                    showViewAllBtn: true,
                    callback: () {
                      NavigatorHelper().navigateTo('/AllPartnersTeams');
                    },
                  ),
                ),
              isHorizontal!
                  ? SizedBox(
                      height: context.allHeight * 0.35,
                      width: context.allWidth,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: MockHubModel.getMockHubs().length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return HubWidget(
                              teamName: 'Cackelbean Eggs @ Morrisons',
                              frequency: 'Weekly',
                              category: 'Farm and Dairy',
                              nextDelivery: 'Delivers every week',
                              isVertical: false,
                              mockData: MockHubModel.getMockHubs()[index],
                              callBack: () {
                                NavigatorHelper().navigateTo('/PartnerTeam');
                              },
                              callBackIfUpdated: () {},
                            );
                          }),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: MockHubModel.getMockHubs().length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return HubWidget(
                          teamName: 'Cackelbean Eggs @ Morrisons',
                          frequency: 'Weekly',
                          category: 'Farm and Dairy',
                          nextDelivery: 'Delivers every week',
                          isVertical: false,
                          mockData: MockHubModel.getMockHubs()[index],
                          callBack: () {
                            NavigatorHelper().navigateTo('/PartnerTeam');
                          },
                          callBackIfUpdated: () {},
                        );
                      }),
            ],
          );
        });
  }
}
