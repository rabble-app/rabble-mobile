import 'package:rabble/core/config/export.dart';

class BuyingTeamNearYouWidget extends StatefulWidget {
  const BuyingTeamNearYouWidget({Key? key}) : super(key: key);

  @override
  State<BuyingTeamNearYouWidget> createState() =>
      _BuyingTeamNearYouWidgetState();
}

class _BuyingTeamNearYouWidgetState extends State<BuyingTeamNearYouWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return CubitProvider<RabbleBaseState, BuyingTeamCubit>(
        create: (context) => BuyingTeamCubit(fetchBuyingTeam: true),
        builder: (context, state, bloc) {
          return state.secondaryBusy
              ? const SizedBox.shrink()
              : BehaviorSubjectBuilder<String>(
                  subject: PostalCodeService().postalCodeGlobalSubject,
                  builder: (context, snapshot) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RabbleText.subHeaderText(
                            text: kBuyingTeamNearMe,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: (itemWidth / itemHeight)),
                            itemBuilder: (BuildContext context, int index) {
                              return  BuyingTeamItemWidget(callBackIfUpdated: () {  },);
                            },
                          )
                        ],
                      ),
                    );
                  });
        });
  }
}
