import '../../../core/config/export.dart';

class CreateGroupNameView extends StatelessWidget {
  CreateGroupNameView(
      {Key? key, this.isEdit, this.teamName, this.teamId, this.producerName})
      : super(key: key);

  final bool? isEdit;
  final String? teamId;
  final String? teamName;
  final String? producerName;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, BuyingTeamCreateCubit>(
        create: (BuildContext context) => BuyingTeamCreateCubit()
          ..setData(isEdit != null && isEdit! ? teamName : ''),
        builder: (BuildContext context, RabbleBaseState state,
            BuyingTeamCreateCubit bloc) {
          return ToucheDetector(
            child: Scaffold(
              body: Column(
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
                                text: kEditTeamName,
                                color: APPColors.appPrimaryColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        )
                      : BehaviorSubjectBuilder<String>(
                          subject:
                              BuyingTeamCreationService().groupNameSubject$,
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            return CreationTeamAppbar(
                              backTitle: kBackToBasket,
                              title: snapshot.data,
                              barPercentage: 1,
                            );
                          }),
                  Expanded(
                    child: Container(
                      padding: PagePadding.all(5.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RabbleText.subHeaderText(
                            text: kChooseGroup,
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
                                'Create a name for your buying team, you can edit this later:',
                            textAlign: TextAlign.start,
                            color: APPColors.appTextPrimary,
                            fontWeight: FontWeight.w400,
                            fontFamily: cPoppins,
                            fontSize: 11.sp,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          BehaviorSubjectBuilder<bool>(
                              subject: bloc.focus$,
                              builder: (BuildContext context,
                                  AsyncSnapshot<bool> snapshot) {
                                return Container(
                                  height: 6.4.h,
                                  decoration: ContainerDecoration.boxDecoration(
                                      bg: snapshot.data!
                                          ? APPColors.appWhite
                                          : Colors.transparent,
                                      border: snapshot.data!
                                          ? APPColors.borderColor
                                          : APPColors.bg_grey25,
                                      width: 2,
                                      radius: 10),
                                  child: TextFormField(
                                    controller: bloc.groupController,
                                    onChanged: (String val) {
                                      BuyingTeamCreationService()
                                          .groupNameSubject$
                                          .sink
                                          .add(val);
                                      bloc.focus$.sink.add(true);

                                      bloc.groupNameSubject$.sink.add(val);
                                    },
                                    textAlign: TextAlign.start,
                                    autofocus: true,
                                    cursorColor: Colors.black,
                                    // Set cursor color
                                    cursorWidth: 2.0,
                                    cursorHeight: 10,
                                    // Set cursor width
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: APPColors.appBlack4,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: cPoppins,
                                        letterSpacing: -0.9,
                                        height: 1),
                                    maxLength: 25,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      fillColor: Colors.transparent,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 1.h),
                                      hintText: 'Team name',

                                      hintStyle: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: cPoppins,
                                          letterSpacing: -0.9,
                                          height: 0,
                                          color: APPColors.appTextPrimary),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      // This ensures the label doesn't shift upwards
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: StreamBuilder<String>(
                  stream: BuyingTeamCreationService().groupNameSubject$,
                  initialData: '',
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Container(
                      margin: PagePadding.custom(0, 0, 4.w, 5.w),
                      width: 20.w,
                      padding: PagePadding.custom(4.w, 4.w, 5.w, 5.w),
                      child: RabbleButton.tertiaryFilled(
                        buttonSize: ButtonSize.large,
                        bgColor: snapshot.data!.isNotEmpty
                            ? APPColors.appPrimaryColor
                            : APPColors.bg_grey25,
                        onPressed: state.secondaryBusy? null : () async {
                          bool teamExist = await bloc.checkTeamNameExist();

                          if (!teamExist) {
                            if (isEdit != null && isEdit!) {
                              Map<String, dynamic> body = {
                                'name': bloc.groupController.text
                              };

                              var res =
                                  await bloc.updateTeamData(teamId!, body);
                              if (res) {
                                NavigatorHelper()
                                    .pop(result: bloc.groupController.text);
                              }
                            } else {
                              if (snapshot.data!.isNotEmpty) {
                                BuyingTeamCreationService()
                                    .addTeamCreationData(mName, snapshot.data!);

                                NavigatorHelper()
                                    .navigateTo(
                                        '/choose_frequency_view', producerName)
                                    .then((value) => _focusNode.requestFocus());
                              }
                            }
                          }
                        },
                        child: state.secondaryBusy
                            ? Container(
                                padding: PagePadding.horizontalSymmetric(5.w),
                                child: const Center(
                                  child: RabbleSecondaryScreenProgressIndicator(
                                    enabled: true,
                                  ),
                                ),
                              )
                            : RabbleText.subHeaderText(
                                text: isEdit != null && isEdit!
                                    ? kSaveUpdate
                                    : kContinue,
                                fontSize: 14.sp,
                                fontFamily: 'Gosha',
                                color: snapshot.data!.isNotEmpty
                                    ? APPColors.appBlack
                                    : APPColors.bg_grey27,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                    );
                  }),
            ),
          );
        });
  }

  void changeFocus(BuyingTeamCubit teamCubit) {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        teamCubit.focus$.sink.add(true);
      } else {
        teamCubit.focus$.sink.add(false);
      }
    });
  }
}
