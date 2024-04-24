import 'package:rabble/core/config/export.dart';

class ReviewPaymentView extends StatefulWidget {
  ReviewPaymentView({Key? key}) : super(key: key);

  @override
  State<ReviewPaymentView> createState() => _ReviewPaymentViewState();
}

class _ReviewPaymentViewState extends State<ReviewPaymentView>
    with TickerProviderStateMixin {
  final StreamController<bool> _over18Stream =
      StreamController<bool>.broadcast();

  dynamic toggleSwitch(bool val) {
    if (val) {
      _over18Stream.sink.add(false);
    } else {
      _over18Stream.sink.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Data : ${BuyingTeamCreationService().payDataSubject$.value.toString()}');
    return CubitProvider<RabbleBaseState, PaymentCubit>(
        create: (context) => PaymentCubit(fetchMyCard: false),
        builder: (Context, state, bloc) {
          if (state.tertiaryBusy) {
            return BehaviorSubjectBuilder<Map>(
                subject: bloc.messageSubject$,
                builder: (context, snapshot) {
                  return RabblePerformanceLoader(
                    enabled: state.tertiaryBusy,
                    map: snapshot.data!,
                    tryAgainCallBack: (Map data) {
                      if (snapshot.hasData) {
                        if (data['isUpdate'] == '1') {
                          if (data['api'] == '2') {
                            bloc.chargeCardPayment(
                                BuyingTeamCreationService()
                                    .apiDataSubject$
                                    .value,
                                true);
                          }
                        } else {
                          print(data.toString());
                          if (data['api'] == '2') {
                            bloc.chargeCardPayment(
                                BuyingTeamCreationService()
                                    .apiDataSubject$
                                    .value,
                                false);
                          } else if (data['api'] == '3') {
                            bloc.createTeam({});
                          } else {
                            bloc.messageSubject$.sink.add({
                              'json': 'assets/json/loader1.json',
                              'msg': kSettingUpTeam,
                              'type': '1',
                              'isUpdate': '0'
                            });
                            bloc.uploadBasket(data['team']);
                          }
                        }
                      }
                    },
                    controller: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 10000),
                    ),
                    child: Scaffold(
                      backgroundColor: APPColors.bgColor,
                      body: Column(
                        children: [
                          BehaviorSubjectBuilder<String>(
                              subject:
                                  BuyingTeamCreationService().groupNameSubject$,
                              builder: (context, snapshot) {
                                return CreationTeamAppbar(
                                  backTitle: kPayment,
                                  title: snapshot.data,
                                  barPercentage: 6,
                                );
                              }),
                          Expanded(
                            child: Padding(
                              padding: PagePadding.all(4.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  RabbleText.subHeaderText(
                                    text: kReviewPayment,
                                    color: APPColors.appBlack4,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Container(
                                    margin: const PagePadding.all(0),
                                    decoration:
                                        ContainerDecoration.boxDecoration(
                                            bg: Colors.transparent,
                                            border: APPColors.bg_grey25,
                                            width: 1,
                                            radius: 8),
                                    child: Column(
                                      children: [
                                        StreamBuilder<bool>(
                                          stream: _over18Stream.stream,
                                          initialData: true,
                                          builder: (BuildContext context, s) {
                                            return DeliveryItemWidget(
                                              heading: kOver18,
                                              trailing: Transform.scale(
                                                scale: 1.2,
                                                child: Switch(
                                                  value: s.data!,
                                                  inactiveThumbColor:
                                                      APPColors.bg_grey28,
                                                  inactiveTrackColor:
                                                      APPColors.bg_grey28,
                                                  activeColor:
                                                      APPColors.appPrimaryColor,
                                                  onChanged: (bool val) =>
                                                      toggleSwitch(s.data!),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const Divider(
                                          color: APPColors.bg_grey25,
                                          thickness: 1,
                                        ),
                                        DeliveryItemWidget(
                                          heading: kPaymentMethod,
                                          trailing: Container(
                                            height: 5.h,
                                            width: 16.w,
                                            decoration: ContainerDecoration
                                                .boxDecoration(
                                                    bg: Colors.transparent,
                                                    border: APPColors.bg_grey25,
                                                    width: 1,
                                                    radius: 8),
                                            child: BuyingTeamCreationService()
                                                    .payDataSubject$
                                                    .value
                                                    .isEmpty
                                                ? const SizedBox.shrink()
                                                : bloc
                                                    .getIconOfCard(
                                                        BuyingTeamCreationService()
                                                                .payDataSubject$
                                                                .value[
                                                            mPaymentType])
                                                    .svg(
                                                        width: 10.w,
                                                        height: 5.h),
                                          ),
                                        ),
                                        const Divider(
                                          color: APPColors.bg_grey25,
                                          thickness: 1,
                                        ),
                                        Padding(
                                          padding:
                                              PagePadding.verticalSymmetric(
                                                  2.w),
                                          child: DeliveryItemWidget(
                                            heading: kTotalPrice,
                                            subHeading: kIncludingVAT,
                                            trailing: RabbleText.subHeaderText(
                                              text:
                                                  'GBP ${DateFormatUtil.amountFormatter(BuyingTeamCreationService().payDataSubject$.value[mamount] ?? 0)}',
                                              fontSize: 16.sp,
                                              fontFamily: cGosha,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            isLast: true,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 22.h,
                                  ),
                                  TextRichCustom(
                                    labelPrefix1: kAgreeToTerms,
                                    labelPrefix2: kTermsofUse,
                                    labelPrefix3: kPrivacyPolicy,
                                    onTap1: () {},
                                    onTap2: () {},
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  RabbleButton.tertiaryFilled(
                                    bgColor: APPColors.appPrimaryColor,
                                    onPressed: () {
                                      if (BuyingTeamCreationService()
                                              .payDataSubject$
                                              .value
                                              .containsKey('update') &&
                                          BuyingTeamCreationService()
                                              .payDataSubject$
                                              .value['update']) {
                                        bloc.chargeCardPayment(
                                            BuyingTeamCreationService()
                                                .payDataSubject$
                                                .value,
                                            true);
                                      } else {
                                        bloc.chargeCardPayment(
                                            BuyingTeamCreationService()
                                                .payDataSubject$
                                                .value,
                                            false);
                                      }
                                    },
                                    child: RabbleText.subHeaderText(
                                      text:
                                          'Pay (${'GBP ${BuyingTeamCreationService().payDataSubject$.value[mamount]}'})',
                                      fontSize: 14.sp,
                                      fontFamily: 'Gosha',
                                      color: APPColors.appBlack,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Scaffold(
              backgroundColor: APPColors.bgColor,
              body: Column(
                children: [
                  BehaviorSubjectBuilder<String>(
                      subject: BuyingTeamCreationService().groupNameSubject$,
                      builder: (context, snapshot) {
                        return CreationTeamAppbar(
                          backTitle: kPayment,
                          title: snapshot.data,
                          barPercentage: 6,
                        );
                      }),
                  Expanded(
                    child: Padding(
                      padding: PagePadding.all(4.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.5.h,
                          ),
                          RabbleText.subHeaderText(
                            text: kReviewPayment,
                            color: APPColors.appBlack4,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Container(
                            margin: const PagePadding.all(0),
                            decoration: ContainerDecoration.boxDecoration(
                                bg: Colors.transparent,
                                border: APPColors.bg_grey25,
                                width: 1,
                                radius: 8),
                            child: Column(
                              children: [
                                StreamBuilder<bool>(
                                  stream: _over18Stream.stream,
                                  initialData: true,
                                  builder: (BuildContext context, s) {
                                    return DeliveryItemWidget(
                                      heading: kOver18,
                                      trailing: Transform.scale(
                                        scale: 1.2,
                                        child: Switch(
                                          value: s.data!,
                                          inactiveThumbColor:
                                              APPColors.bg_grey28,
                                          inactiveTrackColor:
                                              APPColors.bg_grey28,
                                          activeColor:
                                              APPColors.appPrimaryColor,
                                          onChanged: (bool val) =>
                                              toggleSwitch(s.data!),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const Divider(
                                  color: APPColors.bg_grey25,
                                  thickness: 1,
                                ),
                                DeliveryItemWidget(
                                  heading: kPaymentMethod,
                                  trailing: Container(
                                    height: 5.h,
                                    width: 16.w,
                                    decoration:
                                        ContainerDecoration.boxDecoration(
                                            bg: Colors.transparent,
                                            border: APPColors.bg_grey25,
                                            width: 1,
                                            radius: 8),
                                    child: BuyingTeamCreationService()
                                            .payDataSubject$
                                            .value
                                            .isEmpty
                                        ? const SizedBox.shrink()
                                        : bloc
                                            .getIconOfCard(
                                                BuyingTeamCreationService()
                                                    .payDataSubject$
                                                    .value[mPaymentType])
                                            .svg(width: 10.w, height: 5.h),
                                  ),
                                ),
                                const Divider(
                                  color: APPColors.bg_grey25,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: PagePadding.verticalSymmetric(2.w),
                                  child: DeliveryItemWidget(
                                    heading: kTotalPrice,
                                    subHeading: kIncludingVAT,
                                    trailing: RabbleText.subHeaderText(
                                      text:
                                          'GBP ${DateFormatUtil.amountFormatter(BuyingTeamCreationService().payDataSubject$.value[mamount])}',
                                      fontSize: 16.sp,
                                      fontFamily: cGosha,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    isLast: true,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          TextRichCustom(
                            labelPrefix1: kAgreeToTerms,
                            labelPrefix2: kTermsofUse,
                            labelPrefix3: kPrivacyPolicy,
                            onTap1: () {},
                            onTap2: () {},
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          RabbleButton.tertiaryFilled(
                            bgColor: APPColors.appPrimaryColor,
                            onPressed: () {
                              if (BuyingTeamCreationService()
                                      .payDataSubject$
                                      .value
                                      .containsKey('update') &&
                                  BuyingTeamCreationService()
                                      .payDataSubject$
                                      .value['update']) {

                                // var chargeData = BuyingTeamCreationService()
                                //     .payDataSubject$
                                //     .value;
                                // chargeData['paymentMethodId'] = 'pm_1O1qQPLOm4z6Mbsx18uvoNtL';
                                // chargeData['customerId'] = 'cus_OkzhCBhxZBLdrQ';
                                //
                                // bloc.chargeCardPayment(
                                //     chargeData,
                                //     false);

                                bloc.chargeCardPayment(
                                    BuyingTeamCreationService()
                                        .payDataSubject$
                                        .value,
                                    true);
                              } else {
                                // var chargeData = BuyingTeamCreationService()
                                //     .payDataSubject$
                                //     .value;
                                // chargeData['paymentMethodId'] = 'pm_1O1qQPLOm4z6Mbsx18uvoNtL';
                                // chargeData['customerId'] = 'cus_OkzhCBhxZBLdrQ';
                                //
                                // bloc.chargeCardPayment(
                                //     chargeData,
                                //     false);

                                bloc.chargeCardPayment(
                                    BuyingTeamCreationService()
                                        .payDataSubject$
                                        .value,
                                    false);
                              }
                            },
                            child: RabbleText.subHeaderText(
                              text:
                                  'Pay (${'GBP ${DateFormatUtil.amountFormatter(BuyingTeamCreationService().payDataSubject$.value[mamount])}'})',
                              fontSize: 14.sp,
                              fontFamily: 'Gosha',
                              color: APPColors.appBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
