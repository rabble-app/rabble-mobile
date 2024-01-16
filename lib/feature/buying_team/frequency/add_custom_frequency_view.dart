import '../../../config/export.dart';

class AddCustomFrequencyView extends StatelessWidget {
  const AddCustomFrequencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, FrequencyCubit>(
        create: (context) => FrequencyCubit(),
        builder: (Context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bgColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 100.w,
                    height: 13.h,
                    color: APPColors.appBlack,
                    padding: PagePadding.onlyTop(2.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,

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
                          text: kAddCustomShipmentFrq,
                          color: APPColors.appPrimaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: PagePadding.horizontalSymmetric(4.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 3.h,
                        ),
                        RabbleText.subHeaderText(
                          text: kRepeatOrderAfterEvery,
                          fontFamily: 'Gosha',
                          color: APPColors.appBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        BehaviorSubjectBuilder<int>(
                            subject: bloc.isExpandedSubject$,
                            builder: (context, isExpanded) {
                              return BehaviorSubjectBuilder<String>(
                                  subject: bloc.numberSubject$,
                                  builder: (context, snapshot) {
                                    return CustomDropDownWidget(
                                      heading: kNumber,
                                      isExpanded: isExpanded.data!,
                                      subHeading: snapshot.data.toString(),
                                      callBack: (val) {
                                        bloc.isExpandedSubject$.sink
                                            .add(val == 0 || val == 2 ? 1 : 0);
                                      },
                                    );
                                  });
                            }),
                        BehaviorSubjectBuilder<int>(
                            subject: bloc.isExpandedSubject$,
                            builder: (context, isExpanded) {
                              return isExpanded.data == 1
                                  ? Card(
                                      color: APPColors.appWhite,
                                      child: Container(
                                        height: 30.h,
                                        width: 100.w,
                                        margin: PagePadding.onlyTop(2.w),
                                        child: CustomDropDownItemWidget(
                                            ["1", "2", "3", "4", "5", "6", "7"],
                                            (val) {
                                          bloc.isExpandedSubject$.sink.add(0);
                                          bloc.numberSubject$.sink.add(val);
                                        }),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            }),
                        SizedBox(
                          height: 2.h,
                        ),
                        BehaviorSubjectBuilder<int>(
                            subject: bloc.isExpandedSubject$,
                            builder: (context, isExpanded) {
                              return BehaviorSubjectBuilder<String>(
                                  subject: bloc.weekSubject$,
                                  builder: (context, snapshot) {
                                    return CustomDropDownWidget(
                                      heading: kType,
                                      isExpanded: isExpanded.data!,
                                      subHeading: snapshot.data.toString(),
                                      callBack: (val) {
                                        bloc.isExpandedSubject$.sink
                                            .add(val == 1 || val == 0 ? 2 : 0);
                                      },
                                    );
                                  });
                            }),
                        BehaviorSubjectBuilder<int>(
                            subject: bloc.isExpandedSubject$,
                            builder: (context, isExpanded) {
                              return isExpanded.data == 2
                                  ? Card(
                                      color: APPColors.appWhite,
                                      child: Container(
                                          height: 15.h,
                                          margin: PagePadding.onlyTop(2.w),
                                          child: CustomDropDownItemWidget(
                                              bloc.weekList, (val) {
                                            bloc.isExpandedSubject$.sink.add(0);
                                            bloc.weekSubject$.sink.add(val);
                                          })),
                                    )
                                  : const SizedBox.shrink();
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: PagePadding.horizontalSymmetric(4.w),
              margin: PagePadding.onlyBottom(4.h),
              child: RabbleButton.tertiaryFilled(
                buttonSize: ButtonSize.large,
                bgColor: APPColors.appPrimaryColor,
                onPressed: () {
                  Map customFrequency = {
                    'key': bloc.weekSubject$.value,
                    'value': bloc.numberSubject$.value
                  };
                  NavigatorHelper().pop(result: customFrequency);
                },
                child: RabbleText.subHeaderText(
                  text: kSaveUpdate,
                  fontSize: 14.sp,
                  fontFamily: 'Gosha',
                  color: APPColors.appBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }
}
