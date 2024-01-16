import 'package:rabble/config/export.dart';

class MySubscribtionView extends StatefulWidget {
  const MySubscribtionView({Key? key}) : super(key: key);

  @override
  State<MySubscribtionView> createState() => _MySubscribtionViewState();
}

class _MySubscribtionViewState extends State<MySubscribtionView> {

  int purchaseStatus = 1;

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) {
      int arg =  ModalRoute.of(context)!.settings.arguments as int;
      purchaseStatus = arg;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.grey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(9.h),
          child: RabbleAppbar(
            backgroundColor: APPColors.bg_app_primary,
            title: kMySubscriptions,
            leadingWidth: 20.w,
          )),
      body: SafeArea(
        child: Padding(
          padding: PagePadding.horizontalSymmetric(4.w),
          child: purchaseStatus == 0 ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              NoPurchasesView(),
            ],
          ) : SingleChildScrollView(
            child: Column(
              children: <Widget>[

                SizedBox(height: 2.h,),
                BuyingWithTeamsView(
                  address: sAddress,
                  teamTitle: sTeamTitle,
                  host: sHostName,
                  nextCharge: sChargeDate,
                  onTap: () => NavigatorHelper().navigateTo('/subscription_shipment_view'),
                ),
                BuyingWithTeamsView(
                  address: sAddress,
                  teamTitle: sTeamTitle,
                  host: sHostName,
                  nextCharge: sChargeDate,
                  status: sStatus,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
