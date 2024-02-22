import 'package:rabble/config/export.dart';
import 'package:rabble/feature/branch/welcome_to_team_sheet.dart';

class UserNameView extends StatefulWidget {
  const UserNameView({Key? key}) : super(key: key);

  @override
  State<UserNameView> createState() => _UserNameViewState();
}

class _UserNameViewState extends State<UserNameView> {
  final FocusNode _focusNode = FocusNode();

  late MyRabbleAccountCubit userInfoCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userInfoCubit = MyRabbleAccountCubit();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        userInfoCubit.focus$.sink.add(true);
      } else {
        userInfoCubit.focus$.sink.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    var phoneNumber = data['number'];
    var type = data['type'];

    return CubitProvider<RabbleBaseState, MyRabbleAccountCubit>(
      create: (BuildContext context) => userInfoCubit,
      builder:
          (BuildContext ctx, RabbleBaseState state, MyRabbleAccountCubit bloc) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Scaffold(
            backgroundColor: APPColors.bgColor,
            body: ToucheDetector(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                     AuthUpperWidget(
                      heading: kYourDetails,
                      subHeading: kTellYourName,
                      image: Assets.png.detailImage.png(),
                      steps: 'Step 2/2',
                    ),
                    Container(
                      padding: PagePadding.all(4.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          RabbleText.subHeaderText(
                            text: kFirstName,
                            color: APPColors.appTextPrimary,
                            fontSize: 9.sp,
                            fontFamily: cPoppins,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          RabbleTextField.border(
                            keyBoardType: TextInputType.text,
                            color: APPColors.appBlack,
                            textAlign: TextAlign.start,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            borderColor: APPColors.bg_grey25,
                            hint: sEGAlbert,
                            onChange: bloc.nameC,
                            filledColor: Colors.transparent,
                            fontFamily: 'Poppins',
                            letterSpacing: 0.6,
                            hintFontSize: 10.sp,
                            maxLines: 1,
                            hintColor: APPColors.bg_grey27,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          RabbleText.subHeaderText(
                            text: kSurName,
                            color: APPColors.appTextPrimary,
                            fontSize: 9.sp,
                            fontFamily: cPoppins,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          RabbleTextField.border(
                            keyBoardType: TextInputType.text,
                            color: APPColors.appBlack,
                            textAlign: TextAlign.start,
                            fontSize: 12.sp,
                            onChange: bloc.surnameC,
                            fontWeight: FontWeight.w400,
                            borderColor: APPColors.bg_grey25,
                            hint: sEGRoss,
                            filledColor: Colors.transparent,
                            fontFamily: 'Poppins',
                            letterSpacing: 0.6,
                            hintFontSize: 10.sp,
                            maxLines: 1,
                            hintColor: APPColors.bg_grey27,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          StreamBuilder(
                              stream: bloc.validUserInfoField,
                              initialData: false,
                              builder: (BuildContext ctx,
                                  AsyncSnapshot<bool> snapshot) {
                                print(snapshot.data);
                                return SizedBox(
                                  child: RabbleButton.tertiaryFilled(
                                    buttonSize: ButtonSize.large,
                                    bgColor: snapshot.data!
                                        ? APPColors.appPrimaryColor
                                        : APPColors.bg_grey25,
                                    onPressed: !snapshot.hasData
                                        ? null
                                        : () async {
                                            var res = await bloc.addProfileData(
                                                phoneNumber, data, context);
                                            if (res) {
                                              if (data['type'] == '1') {
                                                NavigatorHelper()
                                                    .navigateAnClearAll(
                                                        '/home');
                                              } else {
                                                Navigator.pushNamedAndRemoveUntil(
                                                    context, '/add_postal_code_view', (route) => false,
                                                    arguments: data);
                                              }
                                            }
                                          },
                                    child: bloc.state.secondaryBusy
                                        ? const RabbleSecondaryScreenProgressIndicator(
                                            enabled: true,
                                          )
                                        : RabbleText.subHeaderText(
                                            text: kGetStarted,
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
                            height: 20.h,
                          ),
                          type == '0'
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AuthNowWidget(
                                      heading: kGetStarted,
                                      subHeading: kLogin,
                                      callBack: () {
                                        NavigatorHelper().navigateTo('/login');
                                      }),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void changeStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: APPColors.appBlack,
      ),
    );
  }
}
