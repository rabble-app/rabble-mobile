import 'package:rabble/feature/buying_team/address/add_address_shimmer.dart';

import '../../../core/config/export.dart';

class AddAddressView extends StatelessWidget {
  AddAddressView({Key? key}) : super(key: key);

  final TextEditingController _groupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, BuyingTeamCreateCubit>(
        create: (BuildContext context) =>
            BuyingTeamCreateCubit()..fetchMyAddress(),
        builder: (BuildContext context, RabbleBaseState state,
            BuyingTeamCreateCubit bloc) {
          return state.primaryBusy
              ? const AddAddressShimmer()
              : ToucheDetector(
                  child: Container(
                    color: APPColors.bgColor,
                    child: Column(
                      children: [
                        BehaviorSubjectBuilder<String>(
                            subject:
                                BuyingTeamCreationService().groupNameSubject$,
                            builder: (context, snapshot) {
                              return CreationTeamAppbar(
                                backTitle: kBack,
                                title: snapshot.data,
                                barPercentage: 5,
                              );
                            }),
                        Expanded(
                          child: Container(
                            padding:
                                PagePadding.verticalHorizontalSymmetric(5.w),
                            color: APPColors.bgColor,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  RabbleText.subHeaderText(
                                    text: kProvideDeliveryAddress,
                                    color: APPColors.appBlack4,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  RabbleText.subHeaderText(
                                    text: kProvideDeliveryAddressDetail,
                                    color: APPColors.appTextPrimary,
                                    fontSize: 12.sp,
                                    fontFamily: cPoppins,
                                    height: 1.3,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  RabbleText.subHeaderText(
                                    text: 'Postcode',
                                    color: APPColors.appTextPrimary,
                                    fontSize: 12.sp,
                                    fontFamily: cPoppins,
                                    height: 1.3,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  StreamBuilder<String>(
                                      stream: bloc.postalCodeStream,
                                      initialData: '',
                                      builder: (context, snapshot) {
                                        return RabbleTextField.border(
                                          keyBoardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          controller: bloc.postalCodeController,
                                          color: APPColors.appBlack,
                                          textAlign: TextAlign.start,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          borderColor: snapshot.data!.isEmpty
                                              ? APPColors.bg_grey25
                                              : APPColors.borderColor,
                                          hint: kN169JU,
                                          onChange: (val) {
                                            bloc.postalCodeC(val);
                                            bloc.searchAddress(val);
                                          },
                                          filledColor: Colors.transparent,
                                          fontFamily: cPoppins,
                                          letterSpacing: 0.6,
                                          hintFontSize: 10.sp,
                                          maxLines: 1,
                                          hintColor: APPColors.bg_grey27,
                                        );
                                      }),
                                  state.tertiaryBusy
                                      ? Container(
                                          alignment: Alignment.center,
                                          margin: PagePadding.onlyTop(3.h),
                                          child:
                                              RabbleSecondaryScreenProgressIndicator(
                                                  enabled: state.tertiaryBusy),
                                        )
                                      : BehaviorSubjectBuilder<bool>(
                                          subject: bloc.showNearBy,
                                          builder: (context, snapshot) {
                                            return snapshot.data!
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      BehaviorSubjectBuilder<
                                                              int>(
                                                          subject: bloc
                                                              .isExpandedSubject$,
                                                          builder: (context,
                                                              isExpanded) {
                                                            return BehaviorSubjectBuilder<
                                                                    String>(
                                                                subject: bloc
                                                                    .numberSubject$,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  return CustomDropDownWidget(
                                                                    heading:
                                                                        'Select Your Address',
                                                                    isExpanded:
                                                                        isExpanded
                                                                            .data!,
                                                                    subHeading: bloc.singleComma(
                                                                        snapshot
                                                                            .data
                                                                            .toString()),
                                                                    callBack:
                                                                        (val) {
                                                                      bloc.isExpandedSubject$
                                                                          .sink
                                                                          .add(val == 0 || val == 2
                                                                              ? 1
                                                                              : 0);
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                    },
                                                                  );
                                                                });
                                                          }),
                                                      BehaviorSubjectBuilder<
                                                              int>(
                                                          subject: bloc
                                                              .isExpandedSubject$,
                                                          builder: (context,
                                                              isExpanded) {
                                                            return isExpanded
                                                                        .data ==
                                                                    1
                                                                ? Card(
                                                                    color: APPColors
                                                                        .appWhite,
                                                                    child: BehaviorSubjectBuilder<
                                                                            List<
                                                                                String>>(
                                                                        subject:
                                                                            bloc
                                                                                .nearByLcoationListSubject$,
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (!snapshot
                                                                              .hasData)
                                                                            return const Empty();
                                                                          if (snapshot
                                                                              .data!
                                                                              .isEmpty)
                                                                            return const Empty();
                                                                          return Container(
                                                                            height:
                                                                                30.h,
                                                                            width:
                                                                                100.w,
                                                                            margin:
                                                                                PagePadding.onlyTop(2.w),
                                                                            child:
                                                                                CustomDropDownItemWidget(snapshot.data!, (val) {
                                                                              bloc.isExpandedSubject$.sink.add(0);
                                                                              bloc.numberSubject$.sink.add(val);
                                                                              bloc.onSelectAddress(val);
                                                                            }),
                                                                          );
                                                                        }),
                                                                  )
                                                                : const SizedBox
                                                                    .shrink();
                                                          }),
                                                    ],
                                                  )
                                                : const SizedBox.shrink();
                                          }),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  RabbleText.subHeaderText(
                                    text: kBuildingNumber,
                                    color: APPColors.appTextPrimary,
                                    fontSize: 12.sp,
                                    fontFamily: cPoppins,
                                    height: 1.3,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  StreamBuilder<String>(
                                      stream: bloc.buildingNumberStream,
                                      initialData: '',
                                      builder: (context, snapshot) {
                                        return RabbleTextField.border(
                                          keyBoardType: TextInputType.text,
                                          controller: bloc.buildingeController,
                                          color: APPColors.appBlack,
                                          textAlign: TextAlign.start,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          borderColor: snapshot.data!.isEmpty
                                              ? APPColors.bg_grey25
                                              : APPColors.borderColor,
                                          hint: kFloorUnit,
                                          onChange: bloc.buildingNumberC,
                                          filledColor: Colors.transparent,
                                          fontFamily: cPoppins,
                                          letterSpacing: 0.6,
                                          hintFontSize: 10.sp,
                                          maxLines: 1,
                                          hintColor: APPColors.bg_grey27,
                                        );
                                      }),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  RabbleText.subHeaderText(
                                    text: kAddressLine,
                                    color: APPColors.appTextPrimary,
                                    fontSize: 12.sp,
                                    fontFamily: cPoppins,
                                    height: 1.3,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  StreamBuilder<String>(
                                      stream: bloc.addressLineStream,
                                      initialData: '',
                                      builder: (context, snapshot) {
                                        return Container(
                                          padding: const PagePadding.all(10),
                                          width: context.allWidth,
                                          decoration:
                                              ContainerDecoration.boxDecoration(
                                                  bg: Colors.transparent,
                                                  border: snapshot.data!.isEmpty
                                                      ? APPColors.bg_grey25
                                                      : APPColors.borderColor,
                                                  radius: 10,
                                                  width: 1),
                                          child: RabbleText.subHeaderText(
                                            text: snapshot.data!.isEmpty
                                                ? kEGStreetBlockWest
                                                : snapshot.data!,
                                            color: snapshot.data!.isEmpty
                                                ? APPColors.bg_grey27
                                                : APPColors.appBlack,
                                            textAlign: TextAlign.start,
                                            fontSize:snapshot.data!.isEmpty? 10.sp : 12.sp,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: cPoppins,
                                            letterSpacing: 0.6,
                                            maxLines: 1,
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  RabbleText.subHeaderText(
                                    text: kCity,
                                    color: APPColors.appTextPrimary,
                                    fontSize: 12.sp,
                                    fontFamily: cPoppins,
                                    height: 1.3,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  StreamBuilder<String>(
                                      stream: bloc.cityStream,
                                      initialData: '',
                                      builder: (context, snapshot) {
                                        return Container(
                                          padding: const PagePadding.all(10),
                                          width: context.allWidth,
                                          decoration:
                                              ContainerDecoration.boxDecoration(
                                                  bg: Colors.transparent,
                                                  border: snapshot.data!.isEmpty
                                                      ? APPColors.bg_grey25
                                                      : APPColors.borderColor,
                                                  radius: 10,
                                                  width: 1),
                                          child: RabbleText.subHeaderText(
                                            text: snapshot.data!.isEmpty
                                                ? kEGStreetBlockWest
                                                : snapshot.data!,
                                            color: snapshot.data!.isEmpty
                                                ? APPColors.bg_grey27
                                                : APPColors.appBlack,
                                            textAlign: TextAlign.start,
                                            fontSize:snapshot.data!.isEmpty? 10.sp : 12.sp,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: cPoppins,
                                            letterSpacing: 0.6,
                                            maxLines: 1,
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        StreamBuilder<bool>(
                            stream: bloc.validAddressesField,
                            initialData: false,
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              return bloc.state.secondaryBusy
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
                                  : Container(
                                      margin:
                                          PagePadding.custom(4.w, 4.w, 4.w, 0),
                                      child: RabbleButton.tertiaryFilled(
                                        buttonSize: ButtonSize.large,
                                        bgColor: snapshot.data!
                                            ? APPColors.appPrimaryColor
                                            : APPColors.bg_grey25,
                                        onPressed: () {
                                          if (snapshot.data!) {
                                            bloc.addNewAddress();
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
                );
        });
  }
}
