import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rabble/config/export.dart';

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
    var data = ModalRoute.of(context)!.settings.arguments as Map;

    verifyOtpCubit.otpDataSubject$.sink.add(data);

    return CubitProvider<RabbleBaseState, VerifyOtpCubit>(
      create: (context) => verifyOtpCubit,
      builder: (context, state, bloc) {
        return Scaffold(
          backgroundColor: APPColors.bgColor,
          body: ToucheDetector(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AuthUpperWidget(
                    heading: kOTPVerification,
                    subHeading: kOTPVerificationHint,
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
                        fontFamily: 'Poppin',
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
                                  buttonSize: ButtonSize.large,
                                  bgColor: APPColors.appWhite,
                                  onPressed: !snapshot.hasData
                                      ? null
                                      : () async {
                                          bloc.sendOtp(data
                                             );
                                        },
                                  child: bloc.state.tertiaryBusy
                                      ? const RabbleSecondaryScreenProgressIndicator(
                                          enabled: true,
                                        )
                                      : RabbleText.subHeaderText(
                                          text: kResendCode,
                                          fontSize: 14.sp,
                                          fontFamily: 'Gosha',
                                          color: APPColors.appBlue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                ))
                            : Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RabbleText.subHeaderText(
                                      text: kResendCodeIn,
                                      fontSize: 14.sp,
                                      fontFamily: 'Gosha',
                                      color: APPColors.appBlack,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    RabbleText.subHeaderText(
                                      text: '(${snapshot.data})',
                                      fontSize: 14.sp,
                                      fontFamily: 'Gosha',
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
                              print("otpDataSnapshot ${otpDataSnapshot.data.toString()}");
                              return Container(
                                  margin: PagePadding.horizontalSymmetric(5.w),
                                  child: RabbleButton.tertiaryFilled(
                                    buttonSize: ButtonSize.large,
                                    bgColor: snapshot.data!
                                        ? APPColors.appPrimaryColor
                                        : APPColors.bg_grey25,
                                    onPressed: !snapshot.data!
                                        ? null
                                        : () async {
                                            if (otpDataSnapshot.data!['type'] ==
                                                '2') {

                                              bloc.verifyOtp(
                                                  otpDataSnapshot.data!['number'],
                                                  otpDataSnapshot.data!['sid'] ??
                                                      '', otpDataSnapshot.data!['type'],context,data: otpDataSnapshot.data!['data']);

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
                                            fontFamily: 'Gosha',
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

  Widget otpBoxWidget(
    int isRound,
    TextEditingController controller,
  ) {
    return SizedBox(
      width: 9.w,
      child: TextField(
        maxLength: 1,
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(color: APPColors.appBlack),
        onChanged: (value) {
          _handleTextChange(0, value);
        },
        decoration: InputDecoration(
          counter: const Offstage(),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: isRound == 1
                ? const BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                  )
                : isRound == 3
                    ? const BorderRadius.only(
                        topRight: Radius.circular(6.0),
                        bottomRight: Radius.circular(6.0),
                      )
                    : const BorderRadius.all(Radius.circular(0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: APPColors.bg_grey12,
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: isRound == 1
                ? const BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                  )
                : isRound == 3
                    ? const BorderRadius.only(
                        topRight: Radius.circular(6.0),
                        bottomRight: Radius.circular(6.0),
                      )
                    : const BorderRadius.all(Radius.circular(0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: APPColors.bg_grey12,
              width: 1.0,
              style: BorderStyle.solid,
            ),
            borderRadius: isRound == 1
                ? const BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                  )
                : isRound == 3
                    ? const BorderRadius.only(
                        topRight: Radius.circular(4.0),
                        bottomRight: Radius.circular(4.0),
                      )
                    : const BorderRadius.all(Radius.circular(0)),
          ),
        ),
      ),
    );
  }

  final List<String> _otp = List.filled(6, '');

  void _handleTextChange(int index, String value) {
    setState(() {
      _otp[index] = value;
      if (value.isNotEmpty && index < 6) {
        FocusScope.of(context).nextFocus();
      } else {
        FocusScope.of(context).previousFocus();
      }
    });
  }

  Widget otpBorder() {
    return Container(
      height: 50.0,
      width: 0.5,
      color: Colors.grey[300],
    );
  }
}
