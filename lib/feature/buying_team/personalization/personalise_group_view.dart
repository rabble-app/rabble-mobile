import '../../../config/export.dart';

class PersonaliseGroupView extends StatelessWidget {
  PersonaliseGroupView(
      {Key? key,
      this.isEdit,
      this.teamDesc,
      this.teamId,
      this.frequency,
      this.producerName})
      : super(key: key);
  final bool? isEdit;
  final String? teamDesc, teamId, producerName;
  final int? frequency;

  final TextEditingController _groupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isEdit != null && isEdit!) {
      _groupController.text = teamDesc!;
    }
    return CubitProvider<RabbleBaseState, BuyingTeamCreateCubit>(
        create: (BuildContext context) => BuyingTeamCreateCubit(),
        builder: (BuildContext context, RabbleBaseState state,
            BuyingTeamCreateCubit bloc) {
          return ToucheDetector(
            child: Column(
              children: [
                isEdit != null && isEdit!
                    ? Container(
                        width: 100.w,
                        height: 13.h,
                        color: APPColors.appBlack,
                        padding: PagePadding.onlyTop(1.h),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 2.w,
                            ),
                            InkWell(
                              onTap: () {
                                NavigatorHelper().pop();
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: 7.w,
                                height: 5.h,
                                child: CircleAvatar(
                                  backgroundColor: APPColors.appPrimaryColor,
                                  child: const Icon(
                                    Icons.close,
                                    color: APPColors.appBlack4,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            RabbleText.subHeaderText(
                              text: kEditTeamIntroduction,
                              color: APPColors.appPrimaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      )
                    : BehaviorSubjectBuilder<String>(
                        subject: BuyingTeamCreationService().groupNameSubject$,
                        builder: (context, snapshot) {
                          return CreationTeamAppbar(
                            backTitle: kBack,
                            title: snapshot.data,
                            barPercentage: 3,
                          );
                        }),
                Expanded(
                  child: Container(
                    padding: PagePadding.verticalHorizontalSymmetric(5.w),
                    color: APPColors.bgColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3.5.h,
                        ),
                        RabbleText.subHeaderText(
                          text: kPersonaliseGroupIntroduction,
                          fontFamily: 'Gosha',
                          color: APPColors.appBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        RabbleText.subHeaderText(
                          text:
                              'This will help those that want to join your team know how you run it. You can edit and personalise this as much as you like:',
                          textAlign: TextAlign.start,
                          color: APPColors.appTextPrimary,
                          fontWeight: FontWeight.w400,
                          fontFamily: cPoppins,
                          fontSize: 11.sp,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        BehaviorSubjectBuilder<String>(
                            subject:
                                BuyingTeamCreationService().groupNameSubject$,
                            builder: (context, snapshot) {
                              return RabbleText.subHeaderText(
                                text: '${snapshot.data} Introduction',
                                textAlign: TextAlign.start,
                                color: APPColors.appTextPrimary,
                                fontWeight: FontWeight.w500,
                                fontFamily: cPoppins,
                                fontSize: 11.sp,
                              );
                            }),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 18.h,
                          child: StreamBuilder(
                              stream: bloc.persolizedStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                return RabbleTextField.border(
                                  controller: _groupController,
                                  onChange: bloc.persolizedC,
                                  color: APPColors.appBlack,
                                  textAlign: TextAlign.start,
                                  fontSize: 12.sp,
                                  maxLength: 80,
                                  fontWeight: FontWeight.w400,
                                  borderColor: APPColors.bg_grey25,
                                  hint: isEdit != null && isEdit!
                                      ? bloc.getHintPersonalization(
                                          producerName, frequency)
                                      : bloc.getHintPersonalization(
                                          BuyingTeamCreationService()
                                              .creationDataSubject$
                                              .value[mProducerName],
                                          BuyingTeamCreationService()
                                              .creationDataSubject$
                                              .value[mFrequency]),
                                  filledColor: Colors.transparent,
                                  fontFamily: cPoppins,
                                  letterSpacing: 0.6,
                                  hintFontSize: 11.sp,
                                  maxLines: 6,
                                  hintColor: APPColors.bg_grey27,
                                );
                              }),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: bloc.state.secondaryBusy
                                ? Container(
                                    padding:
                                        PagePadding.horizontalSymmetric(5.w),
                                    margin: PagePadding.onlyTop(5.w),
                                    child: const Center(
                                      child:
                                          RabbleSecondaryScreenProgressIndicator(
                                        enabled: true,
                                      ),
                                    ),
                                  )
                                : RabbleButton.tertiaryFilled(
                                    bgColor: APPColors.appPrimaryColor,
                                    onPressed: () async {
                                      if (isEdit != null && isEdit!) {
                                        Map<String, dynamic> body = {
                                          'description':
                                              _groupController.text.isEmpty
                                                  ? teamDesc
                                                  : _groupController.text
                                        };

                                        var res = await bloc.updateTeamData(
                                            teamId!, body);
                                        if (res) {
                                          NavigatorHelper().pop(
                                              result:
                                                  _groupController.text.isEmpty
                                                      ? teamDesc
                                                      : _groupController.text);
                                        }
                                      } else {
                                        BuyingTeamCreationService().addTeamCreationData(
                                            mDescription,
                                            _groupController.text.isEmpty
                                                ? bloc.getHintPersonalization(
                                                    BuyingTeamCreationService()
                                                        .creationDataSubject$
                                                        .value[mProducerName],
                                                    BuyingTeamCreationService()
                                                        .creationDataSubject$
                                                        .value[mFrequency])
                                                : _groupController.text);
                                        NavigatorHelper()
                                            .navigateTo('/add_address_view');
                                      }
                                    },
                                    child: RabbleText.subHeaderText(
                                      text: isEdit != null && isEdit!
                                          ? kSaveUpdate
                                          : kContinue,
                                      fontSize: 14.sp,
                                      fontFamily: 'Gosha',
                                      color: APPColors.appBlack,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
