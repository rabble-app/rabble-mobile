import 'package:rabble/core/config/export.dart';

class ChooseFrequencyView extends StatelessWidget {
  const ChooseFrequencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CubitProvider<RabbleBaseState, FrequencyCubit>(
        create: (context) => FrequencyCubit(),
        builder: (Context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bgColor,
            body: Column(
              children: [
                BehaviorSubjectBuilder<String>(
                    subject: BuyingTeamCreationService().groupNameSubject$,
                    builder: (context, snapshot) {
                      return CreationTeamAppbar(
                        backTitle: kTeamSetup,
                        title: snapshot.data,
                        barPercentage: 2,
                      );
                    }),
                Expanded(
                  child: Padding(
                    padding: PagePadding.horizontalSymmetric(4.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 3.h,
                        ),
                        RabbleText.subHeaderText(
                          text: kChooseFrequency,
                          fontFamily: 'Gosha',
                          color: APPColors.appBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        RabbleText.subHeaderText(
                          text:
                              'Select how often ${BuyingTeamCreationService().creationDataSubject$.value[mProducerName]} should drop to your street:',
                          textAlign: TextAlign.start,
                          color: APPColors.appTextPrimary,
                          fontWeight: FontWeight.w400,
                          fontFamily: cPoppins,
                          fontSize: 11.sp,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Expanded(
                          child: BehaviorSubjectBuilder<List<FrequencyData>>(
                              subject: bloc.frequencyDataSubject$,
                              builder: (context, snapshot) {
                                return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      FrequencyData data =
                                          snapshot.data![index];
                                      return FrequencyCardView(
                                        cubit: bloc,
                                        title: data.heading!,
                                        subTitle: data.subHeading,
                                        isSelected: data.isSelected,
                                        isCustom: data.isCustom,
                                        index: index,
                                        onTap: () {
                                          data.isSelected = true;
                                          bloc.onSelectedFrequency(data, index);
                                        },
                                      );
                                    });
                              }),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        StreamBuilder<bool>(
                            stream: bloc.validateFrequnecySelected$,
                            initialData: false,
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              return bloc.state.secondaryBusy
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
                                  : Container(
                                      margin: PagePadding.custom(0, 0, 4.w, 0),
                                      child: RabbleButton.tertiaryFilled(
                                        buttonSize: ButtonSize.large,
                                        bgColor: snapshot.data!
                                            ? APPColors.appPrimaryColor
                                            : APPColors.bg_grey25,
                                        onPressed: () {
                                          if (snapshot.data!) {
                                            NavigatorHelper().navigateTo(
                                              '/personalise_group_view',
                                            );
                                          }
                                        },
                                        child: RabbleText.subHeaderText(
                                          text: kContinue,
                                          fontSize: 14.sp,
                                          fontFamily: 'Gosha',
                                          color: snapshot.data!
                                              ? APPColors.appBlack
                                              : APPColors.bg_grey27,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                            }),
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
