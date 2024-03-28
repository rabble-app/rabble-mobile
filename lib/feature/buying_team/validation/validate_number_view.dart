import '../../../core/config/export.dart';

class ValidateNumberView extends StatelessWidget {
  const ValidateNumberView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, BuyingTeamCubit>(
        create: (BuildContext context) => BuyingTeamCubit(),
        builder: (BuildContext context, RabbleBaseState state,
            BuyingTeamCubit bloc) {
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
                      RabbleText.subHeaderText(
                        text: kValidateYourNumber,
                        fontFamily: 'Gosha',
                        color: APPColors.appBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      RabbleText.subHeaderText(
                        text: kValidateYourNumberDetail,
                        textAlign: TextAlign.start,
                        color: APPColors.bg_grey3,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Urbanist',
                        fontSize: 11.sp,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),

                      Container(
                        color: APPColors.grey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            RabbleText.subHeaderText(
                              text: kPN,
                              fontFamily: 'Gosha',
                              color: APPColors.appBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              height: 7.5.h,
                              decoration: ContainerDecoration.boxDecoration(
                                  bg: APPColors.appWhite,
                                  border: APPColors.appWhite,
                                  width: 1,
                                  radius: 10),
                              child: Row(
                                children: [
                                  GestureDetector(
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
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                const Color(0xFF8C98A8)
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onSelect: (Country country) {
                                          print("COUNTRY PHONE CODE ${country.phoneCode.toString()}");
                                          bloc.selectedCountryImage$.sink
                                              .add(country.flagEmoji);
                                          bloc.selectedCountryCode$.sink
                                              .add(country.phoneCode);
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        BehaviorSubjectBuilder<String>(
                                            subject:
                                            bloc.selectedCountryImage$,
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Assets
                                                    .png.flagEngland
                                                    .png(
                                                    width: 10.w,
                                                    height: 6.h);
                                              }
                                              return RabbleText.headerText(
                                                text: snapshot.data,
                                              );
                                            }),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        const Icon(
                                          Icons
                                              .keyboard_arrow_down_outlined,
                                          color: APPColors.appBlack,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: StreamBuilder(
                                          stream: bloc.phoneStream,
                                          builder: (context, snapshot) {
                                            return RabbleTextField
                                                .borderLess(
                                              color: APPColors.appBlack,
                                              keyBoardType:
                                              TextInputType.number,
                                              textAlign: TextAlign.start,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              hint: kPN,
                                              onChange: bloc.phoneC,
                                              fontFamily: 'Gosha',
                                              hintColor:
                                              APPColors.appTextGrey,
                                            );
                                          }))
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
                StreamBuilder<bool>(
                    stream: bloc.validFPField,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return ContinueButtonWidget(
                              label: kValidate,

                              callBack: !snapshot.hasData
                                  ? null
                                  : () {
                                      NavigatorHelper()
                                          .navigateTo('/choose_frequency_view');
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
