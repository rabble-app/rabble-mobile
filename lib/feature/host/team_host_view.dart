import 'package:rabble/config/export.dart';

class TeamHostView extends StatelessWidget {
  const TeamHostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, TeamHostCubit>(
        create: (Context) => TeamHostCubit(),
        builder: (Context, state, bloc) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(8.h),
                child: RabbleAppbar(
                  title: sFremontStreetWine,
                  leadingWidth: 20.w,
                  action: [
                    PostCodeWidget(
                      callBack: () {
                        NavigatorHelper().navigateTo('/add_postal_code_view');

                      },
                    )
                  ],
                )),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Assets.png.teamhost.png(),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      color: APPColors.appWhite,
                      padding: PagePadding.custom(2.w, 2.w, 2.w, 2.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Assets.svgs.MultiUser.svg(),
                              SizedBox(
                                width: 3.w,
                              ),
                              RabbleText.subHeaderText(
                                text: '8',
                                color: APPColors.appBlue,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Assets.svgs.share.svg(),
                            ],
                          ),
                          const Divider(
                            color: APPColors.appDivider,
                            thickness: 1,
                          ),
                          Container(
                            padding: PagePadding.custom(
                              3.w,
                              3.w,
                              1.w,
                              1.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Assets.svgs.truck
                                    .svg(width: 5.w, height: 2.5.h),
                                SizedBox(
                                  width: 3.w,
                                ),
                                RabbleText.subHeaderText(
                                  text: k16DeliveryVansPrevented,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: APPColors.appBlack,
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: PagePadding.custom(
                              3.w,
                              3.w,
                              1.w,
                              1.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Assets.svgs.dollarSaved
                                    .svg(width: 5.w, height: 2.5.h),
                                SizedBox(
                                  width: 3.w,
                                ),
                                RabbleText.subHeaderText(
                                  text: s127Saved,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: APPColors.appBlack,
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: APPColors.appDivider,
                            thickness: 1,
                          ),
                          Padding(
                            padding: PagePadding.custom(3.w, 3.w, 1.w, 1.w),
                            child: RabbleText.subHeaderText(
                              text: sFremontStreetWine,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: APPColors.appBlack,
                            ),
                          ),
                          Padding(
                            padding: PagePadding.custom(3.w, 3.w, 1.w, 1.w),
                            child: const Divider(
                              color: APPColors.appDivider,
                              thickness: 1,
                            ),
                          ),
                          const DeliveryDetailWidget(),
                          Padding(
                            padding: PagePadding.custom(3.w, 3.w, 1.w, 1.w),
                            child: const Divider(
                              color: APPColors.appDivider,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: PagePadding.custom(3.w, 3.w, 1.w, 1.w),
                            child: RabbleText.subHeaderText(
                              textAlign: TextAlign.start,
                              text: sFremontStreetWineDetail,
                              fontSize: 12.sp,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.normal,
                              color: APPColors.bg_grey9,
                            ),
                          ),
                          Padding(
                            padding: PagePadding.custom(3.w, 3.w, 1.w, 1.w),
                            child: const Divider(
                              color: APPColors.appDivider,
                              thickness: 1,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            padding: PagePadding.custom(
                              3.w,
                              3.w,
                              1.w,
                              1.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Assets.svgs.truck
                                    .svg(width: 5.w, height: 2.5.h),
                                SizedBox(
                                  width: 3.w,
                                ),
                                RabbleText.subHeaderText(
                                  text: kNextShippingDate,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: APPColors.bg_grey21,
                                ),
                                RabbleText.subHeaderText(
                                  text: sDate1,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: APPColors.bg_grey24,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: PagePadding.custom(
                              3.w,
                              3.w,
                              1.w,
                              2.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Assets.png.location
                                    .png(width: 5.w, height: 2.5.h),
                                SizedBox(
                                  width: 3.w,
                                ),
                                RabbleText.subHeaderText(
                                  text: sCollectionAddress,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: APPColors.bg_grey21,
                                ),
                                RabbleText.subHeaderText(
                                  text: sAddress,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: APPColors.bg_grey24,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          BehaviorSubjectBuilder<bool>(
                              subject: bloc.expanded$,
                              builder: (context, snapshot) {
                                return Container(
                                  width: 100.w,
                                  height: !snapshot.data! ? 90.h : 75.h,
                                  decoration: ContainerDecoration.boxDecoration(
                                      bg: const Color(0xfff9f9fc),
                                      border: APPColors.appYellow,
                                      radius: 11),
                                  child: Padding(
                                    padding: PagePadding.general(3.w),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 90.w,
                                          height: 45.h,
                                          decoration:
                                              ContainerDecoration.boxDecoration(
                                                  bg: APPColors.appWhite,
                                                  border: APPColors.appWhite,
                                                  radius: 11),
                                          child: Padding(
                                            padding: PagePadding.general(2.w),
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        const Color(0xffB7EC21),
                                                    radius: 50,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          APPColors.appYellow,
                                                      radius: 45,
                                                      child: RabbleText
                                                          .subHeaderText(
                                                        text: k157,
                                                        color:
                                                            APPColors.appBorder,
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3.h,
                                                  ),
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: ' $k700',
                                                            style: TextStyle(
                                                                color: APPColors
                                                                    .appBorder,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    11.sp)),
                                                        TextSpan(
                                                            text: ' $kTowards ',
                                                            style: TextStyle(
                                                              color: APPColors
                                                                  .appBorder,
                                                              fontSize: 11.sp,
                                                            )),
                                                        TextSpan(
                                                            text: ' $k500',
                                                            style: TextStyle(
                                                                color: APPColors
                                                                    .appBorder,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    11.sp)),
                                                        TextSpan(
                                                            text:
                                                                '  $kMinium\n',
                                                            style: TextStyle(
                                                              color: APPColors
                                                                  .appBorder,
                                                              fontSize: 12.sp,
                                                            )),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const TimerWidget(
                                                        daysRemaining: 6,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      RabbleText.subHeaderText(
                                                          text: ' $kTo',
                                                          color: APPColors
                                                              .appBorder,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.sp)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        BasketWidget(
                                          image: "",
                                          name: "",
                                          callBackExpanded: (val) {
                                            bloc.expanded$.sink.add(val);
                                          },
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            height: 7.5.h,
                            child: RabbleButton.tertiaryFilled(
                              onPressed: () {
                                NavigatorHelper()
                                    .navigateTo('/my_subscribtion_view');
                              },
                              child: RabbleText.subHeaderText(
                                text: kYS,
                                fontSize: 14.sp,
                                color: APPColors.appIcons,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            height: 7.5.h,
                            child: RabbleButton.tertiaryFilled(
                              onPressed: () {
                                //    NavigatorHelper().navigateTo('/subscription_shipment_view');
                                NavigatorHelper()
                                    .navigateTo('/contact_selection_view');
                              },
                              child: RabbleText.subHeaderText(
                                text: kInviateContactFremont,
                                fontSize: 14.sp,
                                color: APPColors.appIcons,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: PagePadding.custom(3.w, 3.w, 1.w, 1.w),
                            child: const Divider(
                              color: APPColors.appDivider,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
