import '../../../core/config/export.dart';

class EditFrequencyView extends StatelessWidget {
  const EditFrequencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map teamData = ModalRoute.of(context)!.settings.arguments as Map;

    return CubitProvider<RabbleBaseState, FrequencyCubit>(
        create: (context) => FrequencyCubit(),
        builder: (Context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bgColor,
            body: Column(
              children: [
                Container(
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
                          if(!state.secondaryBusy) {
                            NavigatorHelper().pop();
                          }
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
                        text: kEditShipmentFrq,
                        color: APPColors.appPrimaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
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
                              'Select how often ${teamData['producerName']} should drop to your street:',
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
                              return Container(
                                      margin: PagePadding.custom(0, 0, 4.w, 0),
                                      child: RabbleButton.tertiaryFilled(
                                        buttonSize: ButtonSize.large,
                                        bgColor: snapshot.data!
                                            ? APPColors.appPrimaryColor
                                            : APPColors.bg_grey25,
                                        onPressed: state.secondaryBusy
                                            ? null
                                            : () async {
                                                if (snapshot.data!) {
                                                  Map<String, dynamic> body = {
                                                    'frequency': int.parse(bloc
                                                        .frequencySelectedUpdateSubject$
                                                        .value
                                                        .frequecnyEpoch!)
                                                  };

                                                  var res =
                                                      await bloc.updateTeamData(
                                                          teamData['teamId']!,
                                                          body);

                                                  var res2 =
                                                      await bloc.updateTeamData(
                                                          teamData['teamId']!,
                                                          {
                                                            'description': bloc
                                                                .getHintPersonalization(
                                                                    teamData[
                                                                        'producerName'],
                                                                    int.parse(bloc
                                                                        .frequencySelectedUpdateSubject$
                                                                        .value
                                                                        .frequecnyEpoch!))
                                                          },
                                                          same: true);

                                                  if (res) {
                                                    Map data = {
                                                      'freequnecy': int.parse(bloc
                                                          .frequencySelectedUpdateSubject$
                                                          .value
                                                          .frequecnyEpoch!),
                                                      'desc': bloc.getHintPersonalization(
                                                          teamData[
                                                              'producerName'],
                                                          int.parse(bloc
                                                              .frequencySelectedUpdateSubject$
                                                              .value
                                                              .frequecnyEpoch!))
                                                    };
                                                    NavigatorHelper()
                                                        .pop(result: data);
                                                  }
                                                }
                                              },
                                        child: state.secondaryBusy
                                            ? Container(
                                          padding:
                                          PagePadding.horizontalSymmetric(5.w),
                                          child: const Center(
                                            child:
                                            RabbleSecondaryScreenProgressIndicator(
                                              enabled: true,
                                            ),
                                          ),
                                        )
                                            :  RabbleText.subHeaderText(
                                          text: kSaveUpdate,
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
