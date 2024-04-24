import 'package:rabble/core/config/export.dart';

class RequestToJoin extends StatelessWidget {
  const RequestToJoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeamData data = ModalRoute.of(context)!.settings.arguments as TeamData;

    return CubitProvider<RabbleBaseState, RequestToJoinCubit>(
        create: (context) => RequestToJoinCubit(),
        builder: (context, state, bloc) {
          return FocusChild(
            child: Scaffold(
              backgroundColor: APPColors.bgColor,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      NavigatorHelper().pop();
                    },
                    child: Container(
                      width: 100.w,
                      height: 10.h,
                      color: APPColors.appBlack,
                      padding: PagePadding.onlyTop(3.h),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 7.w,
                            height: 5.h,
                            child: CircleAvatar(
                              backgroundColor: APPColors.appPrimaryColor,
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: APPColors.appBlack4,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          RabbleText.subHeaderText(
                            text: kJoinTeamRequest,
                            color: APPColors.appPrimaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: PagePadding.custom(2.w,2.w,0,4.w),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BuyingTeamItemWidget(
                              teamId: data.id ?? '',
                              isVertical: false,
                              teamName: data.name ?? '',
                              image: data.imageUrl ?? '',
                              postalCode: data.postalCode ?? '',
                              busniessName: data.producer!.businessName ?? '',
                              frequency:
                              Conversation.getFrequencyText(data.frequency!.toInt()),
                              category: data.producer!.categories != null &&
                                      data.producer!.categories!.isNotEmpty &&
                                      data.producer!.categories!.first
                                              .category !=
                                          null
                                  ? data.producer!.categories!.first.category!
                                      .name
                                  : '',
                              nextDelivery:
                              'Next delivery ${data.nextDeliveryDate != null
                                  ? '${int.parse(DateFormatUtil.countDays(
                                  data.nextDeliveryDate!)) < 7
                                  ? "in ${DateFormatUtil.countDays(
                                  data.nextDeliveryDate!)} ${int.parse(DateFormatUtil.countDays(data.nextDeliveryDate!)) < 2 ? "day" : "days"}"
                                  : DateFormatUtil.formatDate(data.nextDeliveryDate!, 'dd MMM yyyy')} '
                                  : 'date TBD'}',
                              producerName:
                                  '${data.host!.firstName ?? ''} ${data.host!.lastName ?? ''}',
                              totalTeamMembers: data.members == null
                                  ? '0'
                                  : data.members!.length.toString(),
                              hostName:
                                  '${data.host!.firstName ?? ''} ${data.host!.lastName ?? ''}', callBackIfUpdated: () {  },
                            ),

                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: PagePadding.custom(2.w,2.w,2.w,1.w),
                              child: RabbleText.subHeaderText(
                                text: kRequesttoJoinTeam,
                                fontSize: 15.sp,
                                height: 1.4,
                                fontFamily: cGosha,
                                fontWeight: FontWeight.bold,
                                color: APPColors.appBlack4,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: PagePadding.custom(2.w,2.w,0,1.w),
                              child: RabbleText.subHeaderText(
                                text: 'You are requesting to join ${data.name ?? ''}. The host who will be receiving your orders will need to approve before you can join, introduce yourself below.',
                                fontFamily: cPoppins,
                                textAlign: TextAlign.start,
                                height: 1.5,
                                fontWeight: FontWeight.normal,
                                color: APPColors.appTextPrimary,
                                fontSize: 10.3.sp,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),

                            Padding(
                              padding: PagePadding.custom(2.w,2.w,0,1.w),
                              child: RabbleTextField.border(
                                color: APPColors.appBlack,
                                textAlign: TextAlign.start,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                borderColor: APPColors.bg_grey25,
                                hint: kTelljoiningteam,
                                onChange: bloc.introduceC,
                                filledColor: Colors.transparent,
                                fontFamily: cPoppins,
                                letterSpacing: 0.6,
                                hintFontSize: 10.sp,
                                maxLines: 6,
                                hintColor: APPColors.bg_grey27,
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              bottomNavigationBar: Container(
                margin: PagePadding.custom(5.w, 5.w, 0, 7.w),

                child: StreamBuilder<bool>(
                    stream: bloc.validGroupNameField,
                    initialData: false,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return RabbleButton.tertiaryFilled(
                        bgColor: snapshot.data!
                            ? APPColors.appPrimaryColor
                            : APPColors.bg_grey25,
                        onPressed: () {
                          bloc.requestToJoin(data.id!);
                        },
                        child: bloc.state.secondaryBusy
                            ? Container(
                                padding: PagePadding.horizontalSymmetric(5.w),
                                child: const Center(
                                  child: RabbleSecondaryScreenProgressIndicator(
                                    enabled: true,
                                  ),
                                ),
                              )
                            : RabbleText.subHeaderText(
                                text: kRequestToJoin,
                                fontSize: 14.sp,
                                fontFamily: 'Gosha',
                                color: snapshot.data!
                                    ? APPColors.appBlack
                                    : APPColors.bg_grey27,
                                fontWeight: FontWeight.bold,
                              ),
                      );
                    }),
              ),
            ),
          );
        });
  }
}
