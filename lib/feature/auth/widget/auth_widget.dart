import 'package:rabble/config/export.dart';

class AuthWidget extends StatefulWidget {
  final String type;

  AuthWidget({Key? key, required this.type}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final FocusNode _focusNode = FocusNode();
  late AuthCubit authCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    authCubit = AuthCubit();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        authCubit.focus$.sink.add(true);
      } else {
        authCubit.focus$.sink.add(false);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, AuthCubit>(
        create: (context) => authCubit,
        builder: (context, state, bloc) {
          return BehaviorSubjectBuilder<String>(
              subject: authCubit.ErrorCode$,
              builder: (context, erroSnapshot) {
                return Container(
                  color: APPColors.bgColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        padding: PagePadding.horizontalSymmetric(3.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 0.5.h,
                            ),
                            SizedBox(
                              height: Platform.isIOS
                                  ? MediaQuery.of(context).size.height * 0.060
                                  : MediaQuery.of(context).size.height * 0.070,
                              child: Row(
                                children: [
                                  Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                    decoration:
                                        ContainerDecoration.boxDecoration(
                                            bg: APPColors.bg_grey26,
                                            border: APPColors.bg_grey26,
                                            width: 1,
                                            radius: 8),
                                    padding: PagePadding.all(2.w),
                                    child: GestureDetector(
                                      onTap: () {
                                        showCountryPicker(
                                          context: context,
                                          countryListTheme:
                                              CountryListThemeData(
                                            flagSize: 25,
                                            backgroundColor: Colors.grey[200],
                                            searchTextStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.blueGrey),
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.blueGrey),
                                            bottomSheetHeight: 500,
                                            // Optional. Country list modal height
                                            //Optional. Sets the border radius for the bottomsheet.
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                            ),
                                            //Optional. Styles the search field.
                                            inputDecoration: InputDecoration(
                                              hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blueGrey),
                                              labelText: 'Search',
                                              hintText:
                                                  'Start typing to search',
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              prefixIconColor: const Color(0xFF8C98A8)
                                                  .withOpacity(0.2),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: const Color(0xFF8C98A8)
                                                      .withOpacity(0.2),
                                                ),
                                              ),

                                            ),
                                          ),
                                          searchAutofocus: true,
                                          onSelect: (Country country) {
                                            authCubit.selectedCountryImage$.sink
                                                .add(country.flagEmoji);
                                            authCubit.selectedCountryCode$.sink
                                                .add(country.phoneCode);
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          BehaviorSubjectBuilder<String>(
                                              subject: authCubit
                                                  .selectedCountryImage$,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Assets.png.flagEngland
                                                      .png(
                                                          width: 7.w,
                                                          height: 4.h);
                                                }
                                                return RabbleText.headerText(
                                                  text: snapshot.data,
                                                  fontSize: 18.sp,
                                                );
                                              }),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: APPColors.bg_grey27,
                                            size: 25,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Expanded(
                                    child: StreamBuilder(
                                        stream: authCubit.phoneStream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          return BehaviorSubjectBuilder<bool>(
                                              subject: authCubit.focus$,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<bool> snapshot) {
                                                return BehaviorSubjectBuilder<
                                                        bool>(
                                                    subject: authCubit
                                                        .iSCompletedNumber$,
                                                    builder: (context,
                                                        isCompletedSnapshot) {
                                                      return Container(
                                                        padding:
                                                            PagePadding.all(1.w),
                                                        decoration: ContainerDecoration
                                                            .boxDecoration(
                                                                bg: snapshot.data!
                                                                    ? APPColors
                                                                        .appWhite
                                                                    : Colors
                                                                        .transparent,
                                                                border: snapshot
                                                                        .data!
                                                                    ? APPColors
                                                                        .borderColor
                                                                    : erroSnapshot
                                                                            .data!
                                                                            .isEmpty
                                                                        ? APPColors
                                                                            .bg_grey25
                                                                        : APPColors
                                                                            .appRedLight,
                                                                width: 1,
                                                                radius: 8),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            BehaviorSubjectBuilder<
                                                                    String>(
                                                                subject: authCubit
                                                                    .selectedCountryCode$,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  return Padding(
                                                                    padding: PagePadding
                                                                        .onlyLeft(
                                                                            2.w),
                                                                    child: RabbleText
                                                                        .subHeaderText(
                                                                      text:
                                                                          '+${snapshot.data}',
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: APPColors
                                                                          .bg_grey27,
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  );
                                                                }),
                                                            SizedBox(
                                                              width:54.w,
                                                              child:
                                                                  RabbleTextField
                                                                      .borderLess(
                                                                color: APPColors
                                                                    .bg_grey27,
                                                                filledColor: Colors
                                                                    .transparent,
                                                                keyBoardType:
                                                                    TextInputType
                                                                        .number,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                fontSize: 12.sp,
                                                                hintFontSize:
                                                                    12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                focusNode:
                                                                    _focusNode,
                                                                hint: kPN,
                                                                onChange:
                                                                    (String val) {
                                                                  authCubit
                                                                      .phoneC(
                                                                          val);
                                                                  if (val.length >
                                                                      9) {
                                                                    _focusNode
                                                                        .unfocus();
                                                                    authCubit
                                                                        .focus$
                                                                        .sink
                                                                        .add(
                                                                            false);
                                                                    authCubit
                                                                        .iSCompletedNumber$
                                                                        .sink
                                                                        .add(
                                                                            true);
                                                                  } else {
                                                                    authCubit
                                                                        .focus$
                                                                        .sink
                                                                        .add(
                                                                            true);
                                                                    authCubit
                                                                        .iSCompletedNumber$
                                                                        .sink
                                                                        .add(
                                                                            false);
                                                                  }
                                                                },
                                                                    letterSpacing: 0.5,
                                                                fontFamily:
                                                                    'Poppins',
                                                                hintColor:
                                                                    APPColors
                                                                        .bg_grey27,
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                      );
                                                    });
                                              });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            RabbleText.subHeaderText(
                              text: erroSnapshot.data!.isEmpty
                                  ? ''
                                  : erroSnapshot.data!,
                              color: APPColors.bg_grey27,
                              fontWeight: FontWeight.normal,
                              textAlign: TextAlign.start,
                              fontFamily: cPoppins,
                              fontSize: 10.sp,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            StreamBuilder(
                                stream: authCubit.validFPField,
                                initialData: false,
                                builder: (BuildContext context,
                                    AsyncSnapshot<bool> snapshot) {
                                  return RabbleButton.tertiaryFilled(
                                    buttonSize: ButtonSize.large,
                                    bgColor: snapshot.data!
                                        ? APPColors.appPrimaryColor
                                        : APPColors.bg_grey25,
                                    onPressed: !snapshot.data!
                                        ? null
                                        : () {
                                            authCubit.sendOtp(widget.type);
                                          },
                                    child: state.secondaryBusy
                                        ? const RabbleSecondaryScreenProgressIndicator(
                                            enabled: true,
                                          )
                                        : RabbleText.subHeaderText(
                                            text: kGetCode,
                                            fontSize: 14.sp,
                                            fontFamily: 'Gosha',
                                            color: snapshot.data!
                                                ? APPColors.appBlack
                                                : APPColors.bg_grey27,
                                            fontWeight: FontWeight.bold,
                                          ),
                                  );
                                }),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              children: [
                                RabbleText.subHeaderText(
                                  text: kTC,
                                  fontSize: 10.sp,
                                  fontFamily: cPoppins,
                                  textAlign: TextAlign.start,
                                  color: APPColors.bg_grey27,
                                  fontWeight: FontWeight.w400,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    NavigatorHelper().navigateToWebScreen('3', '3');
                                  },
                                  child: RabbleText.subHeaderText(
                                    text: kTermsAndConditions,
                                    fontSize: 10.sp,
                                    fontFamily: cPoppins,
                                    textAlign: TextAlign.start,
                                    color: APPColors.appBlue,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
