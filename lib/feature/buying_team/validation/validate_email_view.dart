import '../../../config/export.dart';

class ValidateEmailView extends StatelessWidget {
  ValidateEmailView({Key? key}) : super(key: key);

  final TextEditingController _groupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, BuyingTeamCreateCubit>(
        create: (BuildContext context) => BuyingTeamCreateCubit(),
        builder: (BuildContext context, RabbleBaseState state,
            BuyingTeamCreateCubit bloc) {
          return Container(
            decoration: ContainerDecoration.leftRightRadiusDecoration(),
            child: Column(
              children: [
                SizedBox(
                  height: 1.5.h,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 10.w,
                    height: 0.5.h,
                    color: APPColors.appDivider,
                  ),
                ),
                SizedBox(
                  height: 3.5.h,
                ),
                Container(
                  color: APPColors.grey,
                  padding: PagePadding.all(5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.5.h,
                      ),
                      RabbleText.subHeaderText(
                        text: kValidateYourEmail,
                        fontFamily: 'Gosha',
                        color: APPColors.appBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      RabbleText.subHeaderText(
                        text: kValidateYourEmailDetail,
                        textAlign: TextAlign.start,
                        color: APPColors.bg_grey3,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Gosha',
                        fontSize: 11.sp,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        height: 8.h,
                        child: StreamBuilder(
                            stream: bloc.groupNameStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              return Expanded(
                                  child: RabbleTextField.border(
                                    controller: _groupController,
                                    onChange: bloc.groupNameC,
                                    color: APPColors.appBlack,
                                    textAlign: TextAlign.start,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    borderColor: APPColors.appWhite,
                                    hint: kEmail,
                                    filledColor: APPColors.appWhite,
                                    fontFamily: 'Gosha',
                                    letterSpacing: -0.9,
                                    hintFontSize: 10.sp,
                                    hintColor: APPColors.greyText,
                                  ));
                            }),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
                StreamBuilder<bool>(
                    stream: bloc.validGroupNameField,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return bloc.state.secondaryBusy
                          ? Container(
                              padding: PagePadding.horizontalSymmetric(5.w),
                              margin: PagePadding.onlyTop(5.w),
                              child:
                                  const RabbleSecondaryScreenProgressIndicator(
                                enabled: true,
                              ),
                            )
                          : ContinueButtonWidget(
                              label: kValidate,
                              callBack: () {
                                NavigatorHelper().navigateTo('/team_host_view');
                                    },
                            );
                    }),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          );
        });
  }
}
