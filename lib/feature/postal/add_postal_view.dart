import 'package:rabble/core/config/export.dart';

class AddPostalAddressView extends StatelessWidget {
  AddPostalAddressView({Key? key}) : super(key: key);
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments != null
        ? ModalRoute.of(context)!.settings.arguments as Map
        : {};
    String type = data['type'] ?? '0';

    return CubitProvider<RabbleBaseState, PostalCubit>(
        create: (context) => PostalCubit(),
        builder: (context, state, bloc) {
          return ToucheDetector(
            child: Scaffold(
              backgroundColor: APPColors.bgColor,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    height: 12.h,
                    color: APPColors.appBlack,
                    padding: PagePadding.onlyTop(4.h),
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
                                size: 16,
                                color: APPColors.appBlack4,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        RabbleText.subHeaderText(
                          text: kAddYourLocation,
                          color: APPColors.appPrimaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: PagePadding.all(3.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        RabbleText.subHeaderText(
                          text: kAddYourLocation,
                          fontFamily: cGosha,
                          color: APPColors.appBlack4,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        RabbleText.subHeaderText(
                          text: kAddLocationHint,
                          textAlign: TextAlign.start,
                          color: APPColors.appTextPrimary,
                          fontWeight: FontWeight.normal,
                          fontFamily: cPoppins,
                          height: 1.4,
                          fontSize: 11.sp,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        RabbleText.subHeaderText(
                          text: kMyPostCode,
                          fontSize: 9.sp,
                          fontFamily: cPoppins,
                          color: APPColors.appTextPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        BehaviorSubjectBuilder<bool>(
                            subject: bloc.focus$,
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              return Container(
                                decoration: ContainerDecoration.boxDecoration(
                                    bg: snapshot.data!
                                        ? APPColors.appWhite
                                        : Colors.transparent,
                                    border: snapshot.data!
                                        ? APPColors.borderColor
                                        : APPColors.bg_grey25,
                                    width: 2,
                                    radius: 10),
                                child: StreamBuilder(
                                    stream: bloc.postalCodeStream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      return Center(
                                        child: RabbleTextField.borderLess(
                                          controller: bloc.postalController,
                                          onChange: (String val) {
                                            bloc.postalCodeC(val);
                                            bloc.focus$.sink.add(true);
                                            bloc.postalCodeSubject.sink
                                                .add(val);
                                          },
                                          color: APPColors.appBlack4,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          textAlign: TextAlign.start,
                                          fontSize: 11.sp,
                                          hintFontSize: 11.sp,
                                          focusNode: _focusNode,
                                          fontWeight: FontWeight.w400,
                                          hint: kEnterYourPostCode,
                                          filledColor: Colors.transparent,
                                          fontFamily: cPoppins,
                                          letterSpacing: -0.9,
                                          hintColor: APPColors.appBlack4,
                                        ),
                                      );
                                    }),
                              );
                            }),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
              bottomNavigationBar: StreamBuilder<bool>(
                  stream: bloc.validPostalCodeField,
                  initialData: false,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return Container(
                      margin: PagePadding.custom(4.w, 4.w, 3.w, 8.w),
                      child: RabbleButton.tertiaryFilled(
                        buttonSize: ButtonSize.large,
                        bgColor: snapshot.data!
                            ? APPColors.appPrimaryColor
                            : APPColors.bg_grey25,
                        onPressed: state.secondaryBusy ? null : () async {
                          if (snapshot.data!) {
                            print(type);
                            if (type == '0') {
                              bloc.updatePostalCode();
                            } else {
                              await bloc.addPostalCode(context, data['data']);
                            }
                          }
                        },
                        child: state.secondaryBusy
                            ? Container(
                                padding: PagePadding.horizontalSymmetric(5.w),
                                width: 50.w,
                                height: 10.h,
                                child: const Center(
                                  child: RabbleSecondaryScreenProgressIndicator(
                                    enabled: true,
                                  ),
                                ),
                              )
                            : RabbleText.subHeaderText(
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
            ),
          );
        });
  }
}
