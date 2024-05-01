import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rabble/core/config/export.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({Key? key}) : super(key: key);

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  late VerifyOtpCubit verifyOtpCubit;

  @override
  void initState() {
    super.initState();

    verifyOtpCubit = VerifyOtpCubit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments != null
        ? ModalRoute.of(context)!.settings.arguments as Map
        : {};

    verifyOtpCubit.otpDataSubject$.sink.add(data);

    return CubitProvider<RabbleBaseState, VerifyOtpCubit>(
      create: (context) => verifyOtpCubit..countdownTimer(),
      builder: (context, state, bloc) {
        return ToucheDetector(
          child: Scaffold(
            backgroundColor: APPColors.bgColor,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthUpperWidget(
                    heading: kOTPVerification,
                    subHeading: 'Enter the six digit code sent to your number',
                    image: Assets.png.otpImage.png(),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    margin: PagePadding.horizontalSymmetric(5.w),
                    child: PinCodeTextField(
                      backgroundColor: Colors.transparent,
                      appContext: context,
                      keyboardType: TextInputType.number,
                      hintCharacter: '0',
                      hintStyle: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: cPoppins,
                        color: APPColors.bg_grey25,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.black,
                      key: GlobalKey(),
                      length: 6,
                      onChanged: bloc.otpC,
                      textStyle: RabbleTheme.themeData.textTheme.labelGrayMedium
                          .copyWith(
                              color: APPColors.appBlack,
                              fontWeight: FontWeight.bold),
                      useHapticFeedback: true,
                      autoFocus: true,
                      autoDismissKeyboard: false,
                      pinTheme: PinTheme(
                          inactiveColor: APPColors.bg_grey25,
                          selectedColor: APPColors.appBlue,
                          activeColor: APPColors.appBlue,
                          fieldWidth: 50,
                          fieldHeight: 55,
                          borderWidth: 1,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          shape: PinCodeFieldShape.box),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  StreamBuilder<int>(
                      stream: bloc.timer,
                      builder: (context, snapshot) {
                        return snapshot.data == 0
                            ? Container(
                                margin: PagePadding.horizontalSymmetric(5.w),
                                child: RabbleButton.tertiaryFilled(
                                  key: const Key('resend_otp_button'),
                                  // Add this line to assign the key
                                  // Add this line to assign the key

                                  buttonSize: ButtonSize.large,
                                  bgColor: APPColors.appWhite,
                                  onPressed:
                                      !snapshot.hasData || state.tertiaryBusy
                                          ? null
                                          : () async {
                                              bloc.sendOtp(data);
                                            },
                                  child: bloc.state.tertiaryBusy
                                      ? const RabbleSecondaryScreenProgressIndicator(
                                          enabled: true,
                                        )
                                      : RabbleText.subHeaderText(
                                          text: kResendCode,
                                          fontSize: 14.sp,
                                          fontFamily: cGosha,
                                          color: APPColors.appBlue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                ))
                            : Center(
                                key: const Key('resend_otp_button'),
                                // Add this line to assign the key

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RabbleText.subHeaderText(
                                      text: kResendCodeIn,
                                      fontSize: 14.sp,
                                      fontFamily: cGosha,
                                      color: APPColors.appBlack,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    RabbleText.subHeaderText(
                                      text: '(${snapshot.data})',
                                      fontSize: 14.sp,
                                      fontFamily: cGosha,
                                      color: APPColors.appBlack,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              );
                      }),
                  SizedBox(
                    height: 3.h,
                  ),
                  StreamBuilder(
                      stream: bloc.validOTPField,
                      initialData: false,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return BehaviorSubjectBuilder<Map>(
                            subject: bloc.otpDataSubject$,
                            builder: (context, otpDataSnapshot) {
                              return Container(
                                  margin: PagePadding.horizontalSymmetric(5.w),
                                  child: RabbleButton.tertiaryFilled(
                                    key: const Key('verify_button'),
                                    buttonSize: ButtonSize.large,
                                    bgColor: snapshot.data!
                                        ? APPColors.appPrimaryColor
                                        : APPColors.bg_grey25,
                                    onPressed: !snapshot.data! ||
                                            state.secondaryBusy
                                        ? null
                                        : () async {
                                            FocusScope.of(context).unfocus();

                                            if (otpDataSnapshot.data!['type'] ==
                                                '2') {
                                              bloc.verifyOtp(
                                                  otpDataSnapshot
                                                      .data!['number'],
                                                  otpDataSnapshot
                                                          .data!['sid'] ??
                                                      '',
                                                  otpDataSnapshot.data!['type'],
                                                  context,
                                                  data: otpDataSnapshot
                                                      .data!['data']);
                                            } else {
                                              bloc.verifyOtp(
                                                  otpDataSnapshot
                                                      .data!['number'],
                                                  otpDataSnapshot
                                                          .data!['sid'] ??
                                                      '',
                                                  otpDataSnapshot.data!['type'],
                                                  context);
                                            }
                                          },
                                    child: bloc.state.secondaryBusy
                                        ? const RabbleSecondaryScreenProgressIndicator(
                                            enabled: true,
                                          )
                                        : RabbleText.subHeaderText(
                                            text: kVerify,
                                            fontSize: 14.sp,
                                            fontFamily: cGosha,
                                            color: snapshot.data!
                                                ? APPColors.appBlack
                                                : APPColors.bg_grey27,
                                            fontWeight: FontWeight.bold,
                                          ),
                                  ));
                            });
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
