import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rabble/feature/hub/widget/deliver_address_widget.dart';

import '../../core/config/export.dart';

class PartnerTeamView extends StatelessWidget {
  PartnerTeamView({super.key});

  final StreamController<bool> _expandableStream = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.bgColor,
      body: Column(
        children: [
          Container(
            color: APPColors.appBlack,
            padding: PagePadding.custom(0, 0, 6.h, 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    NavigatorHelper().pop();
                  },
                  child: Padding(
                    padding: PagePadding.onlyLeft(
                      3.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Assets.svgs.arrowLeft.svg(height: 2.5.h),
                        SizedBox(
                          width: 1.5.w,
                        ),
                        RabbleText.subHeaderText(
                          text: kBack,
                          color: APPColors.appPrimaryColor,
                          fontFamily: cGosha,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomShareWidget(
                  title: kShare,
                  onTap: () async {
                    Share.share(
                      'Check out this partner team on Rabble! ABC}',
                    );
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    height: context.allHeight * 0.25,
                    color: APPColors.appBlack4,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          bottom: 5,
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: context.allWidth * 0.75,
                              child: RabbleText.subHeaderText(
                                text: 'Cackelbean Eggs @ Morrisons',
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w700,
                                color: APPColors.appPrimaryColor,
                                fontFamily: cGosha,
                                height: 1.3,
                                fontSize: 26.sp,
                              ),
                            ),
                          ),
                        ),
                        Assets.svgs.hub_box.svg(width: context.allWidth),
                      ],
                    ),
                  ),
                  HostInfoWidget(
                    showMemmbers: true,
                    label: 'Hub Host',
                    avatar: '',
                    user: 'Morrisons',
                    firstName: 'Morrisons',
                    lastName: 'Kumar',
                    associateMembers: [
                      Members(
                        id: '12',
                        user: User(
                            firstName: 'Hatesh',
                            lastName: 'Kumar',
                            imageUrl: ''),
                      ),
                      Members(
                        id: '12',
                        user: User(
                            firstName: 'Hatesh',
                            lastName: 'Kumar',
                            imageUrl: ''),
                      ),
                      Members(
                        id: '12',
                        user: User(
                            firstName: 'Hatesh',
                            lastName: 'Kumar',
                            imageUrl: ''),
                      ),
                      Members(
                        id: '12',
                        user: User(
                            firstName: 'Hatesh',
                            lastName: 'Kumar',
                            imageUrl: ''),
                      ),
                    ],
                    delivers: 12345,
                    memberSince: DateFormatUtil.formatDate(
                        '2024-04-30T05:14:36.615Z', 'dd MMM yyyy'),
                    currentUserId: '1',
                    introText:
                        '{PARTNERSTORE.NAME} is partnering with {supplier.name} and Rabble to bring everyone in {postcode.sector} the opportunity to subscribe to a discounted fresh delivery each {frequency}. ',
                    percentage: '30',
                    hostId: '2',
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Divider(
                    thickness: 0.5,
                    height: 0.5,
                    color: APPColors.bg_grey25,
                  ),
                  CollectionDetailWidget(),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: PagePadding.custom(2.h, 2.h, 1.h, 0),
                    child: DeliveryAddressCustom(
                      label: 'Delivery Date',
                      value: '20 February 2024',
                      icon: Assets.svgs.boxTick.svg(),
                      imageBgColor: APPColors.bgColor,
                    ),
                  ),
                  Padding(
                    padding: PagePadding.custom(2.h, 2.h, 0.5.h, 0),
                    child: ThresholdMetCustomWidget(
                      producerName: 'Morrisons',
                      milestoneTowards: DateFormatUtil.amountFormatter(80),
                      completedMilestone: DateFormatUtil.amountFormatter(40),
                      totalDays: '5',
                      totalMembers: '4',
                      percentage: '40',
                    ),
                  ),
                  Padding(
                    padding: PagePadding.custom(2.h, 2.h, 0.5.h, 0),
                    child: Container(
                      decoration: ContainerDecoration.boxDecoration(
                          bg: APPColors.bgColor,
                          border: APPColors.bg_grey25,
                          radius: 8,
                          width: 1,
                          showShadow: true),
                      child: Padding(
                        padding: PagePadding.all(1.5.h),
                        child: Column(
                          children: [
                            BasketWidget(
                              orderCount: 2,
                              showImage: true,
                              image: '',
                              name: 'Morrisons',
                              basket: [],
                              callBackExpanded: (val) {},
                            ),
                            SizedBox(
                              height: 1.w,
                            ),
                            RabbleButton.tertiaryFilled(
                              buttonSize: ButtonSize.large,
                              bgColor: APPColors.appPrimaryColor,
                              child: RabbleText.subHeaderText(
                                text: kQRCODETORECEIVEORDER,
                                fontSize: 12.sp,
                                color: APPColors.appBlack4,
                                fontFamily: cGosha,
                                fontWeight: FontWeight.bold,
                              ),
                              onPressed: () async {
                                NavigatorHelper().navigateTo('/qrCode');
                              },
                            ),
                            SizedBox(
                              height: 1.2.h,
                            ),
                            RabbleButton.tertiaryFilled(
                              buttonSize: ButtonSize.large,
                              bgColor: APPColors.appWhite,
                              child: RabbleText.subHeaderText(
                                text: kYS,
                                fontSize: 12.sp,
                                color: APPColors.appBlue,
                                fontFamily: cGosha,
                                fontWeight: FontWeight.bold,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: PagePadding.custom(2.h, 2.h, 0.5.h, 0),
                      child: RabbleText.subHeaderText(
                        text: 'Team Orders',
                        fontFamily: cPoppins,
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        color: APPColors.appBlue,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    padding: PagePadding.horizontalSymmetric(3.5.w),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 2,
                        primary: true,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return StreamBuilder<bool>(
                              initialData: false,
                              stream: _expandableStream.stream,
                              builder: (context, s) {
                                return BasketWidget(
                                  showImage: true,
                                  image: '',
                                  heading: ' Morrisons K',
                                  name: 'Morrisons',
                                  basket: [],
                                  callBackExpanded: (val) {
                                    _expandableStream.sink
                                        .add(val ? false : true);
                                  },
                                );
                              });
                        }),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  const Divider(
                    thickness: 0.5,
                    height: 0.5,
                    color: APPColors.bg_grey25,
                  ),
                  Container(
                    padding: PagePadding.custom(2.h, 2.h, 1.h, 3.h),
                    color: Colors.transparent,
                    child: RabbleButton.tertiaryFilled(
                      buttonSize: ButtonSize.large,
                      bgColor: APPColors.appPrimaryColor,
                      child: RabbleText.subHeaderText(
                        text: kJoinRabbleHub,
                        fontSize: 12.sp,
                        color: APPColors.appBlack4,
                        fontFamily: cGosha,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () async {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
