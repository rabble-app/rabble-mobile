import 'package:rabble/core/config/export.dart';

class BuyingTeamView extends StatelessWidget {
  BuyingTeamView({Key? key}) : super(key: key);
  final StreamController<int> _controller = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.appWhite,
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 2.h,
              ),
              StreamBuilder<int>(
                  initialData: 0,
                  stream: _controller.stream,
                  builder: (context, snapshot) {
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
                              children: [
                                SizedBox(
                                  width: 40.w,
                                  child: ManageMemberTabView(
                                    title: kHost2,
                                    isSelected:
                                        snapshot.data == 0 ? true : false,
                                    icon: snapshot.data == 0 ? Assets.svgs.myTeamTab_selected : Assets.svgs.myTeamTab,
                                    onTap: () => toggle(snapshot.data!),
                                  ),
                                ),
                                SizedBox(
                                  width: 40.w,
                                  child: ManageMemberTabView(
                                    title: kMember,
                                    isSelected:
                                        snapshot.data == 1 ? true : false,
                                    icon: snapshot.data == 1 ? Assets.svgs.memberTeamTab_selected : Assets.svgs.multi_profileuser,
                                    onTap: () => toggle(snapshot.data!),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
           
            ],
          ),
          Expanded(
            child: StreamBuilder<int>(
                initialData: 0,
                stream: _controller.stream,
                builder: (context, snapshot) {
                  if (snapshot.data == 0) {
                    return const HostListView();
                  } else {
                    return const MemberListView();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: StreamBuilder<int>(
          stream: _controller.stream,
          initialData: 0,
          builder: (context, snapshot) {
            return snapshot.data == 0
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        if(PostalCodeService().postalCodeGlobalSubject.value.isNotEmpty) {
                          NavigatorHelper().navigateTo('/producer_list_view','');
                        }
                        else{
                          globalBloc.showWarningSnackBar(
                              duration: const Duration(milliseconds: 1500),
                              content: Row(
                            children: [
                              RabbleText.subHeaderText(
                                text: 'Please add your postcode',
                                textAlign: TextAlign.start,
                                fontFamily: cPoppins,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: Color(0xffB54708),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: (){
                                  globalBloc.hideSnackBar(main: true);

                                  NavigatorHelper().navigateTo('/add_postal_code_view');
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 5.5.w,
                                      height: 3.8.h,
                                      child: CircleAvatar(
                                        backgroundColor: APPColors.appBlack,
                                        child: Icon(
                                          Icons.add_outlined,
                                          size: 15,
                                          color: APPColors.appPrimaryColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 1.w,),
                                    RabbleText.subHeaderText(
                                      text: 'Add postcode',
                                      fontFamily: cPoppins,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ) );
                        }
                      },
                      child: Container(
                        height: 7.h,
                        decoration: ContainerDecoration.boxDecoration(
                          bg: APPColors.appPrimaryColor,
                          border: APPColors.appPrimaryColor,
                          radius: 30,
                        ),
                        margin: PagePadding.custom(context.allWidth * 0.10,
                            context.allWidth * 0.19, 0, 0),
                        padding: PagePadding.horizontalSymmetric(5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 8.w,
                              height: 6.h,
                              child: CircleAvatar(
                                backgroundColor: APPColors.appBlack,
                                child: Icon(
                                  Icons.add_outlined,
                                  color: APPColors.appPrimaryColor,
                                ),
                              ),
                            ),
                            RabbleText.subHeaderText(
                              text: kStartaNewBuyingteam,
                              fontFamily: cGosha,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: APPColors.appBlack,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          }),
    );
  }

  dynamic toggle(int value) {
    if (value == 0) {
      _controller.sink.add(1);
    } else {
      _controller.sink.add(0);
    }
  }
}
