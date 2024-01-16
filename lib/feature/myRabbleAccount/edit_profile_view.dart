import 'package:rabble/config/export.dart';
import 'package:rabble/core/loader/rabble_full_loader.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, MyRabbleAccountCubit>(
        create: (BuildContext context) => MyRabbleAccountCubit(),
        builder: (BuildContext context, RabbleBaseState state,
            MyRabbleAccountCubit bloc) {
          return RabbleFullScreenProgressIndicator(
            enabled: state.primaryBusy,
            child: BehaviorSubjectBuilder<UserModel>(
                subject: bloc.userDataSubject$,
                builder:
                    (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                  UserModel userModel = snapshot.data!;
                  return ToucheDetector(
                    child: Scaffold(
                      backgroundColor: APPColors.bg_app_primary,
                      appBar: PreferredSize(
                          preferredSize: Size.fromHeight(9.h),
                          child: const RabbleAppbar(
                            backgroundColor: APPColors.bg_app_primary,
                            title: kEditProfile,
                          )),
                      body: BehaviorSubjectBuilder<File>(
                          subject: bloc.selectedImageSubject$,
                          builder: (BuildContext context,
                              AsyncSnapshot<File>
                                  selectedAssetSnapshot) {
                            return Container(
                              padding: PagePadding.horizontalSymmetric(5.w),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    SizedBox(
                                      height: 13.h,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        // Aligns the children at the bottom center

                                        children: [
                                          selectedAssetSnapshot.data == null
                                              ? userModel.imageUrl!=null && userModel.imageUrl!
                                                          .isNotEmpty &&
                                                      userModel.imageUrl !=
                                                          'https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/img.png'
                                                  ? Center(
                                                      child: Container(
                                                        width: 24.w,
                                                        height: 12.h,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: APPColors
                                                                        .appPrimaryColor),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    userModel
                                                                        .imageUrl!,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                      ),
                                                    )
                                                  : Center(
                                                      child:
                                                          CircularAvatarWidget(
                                                        firstName: userModel
                                                                .firstName ??
                                                            '',
                                                        lastName: userModel
                                                                .lastName ??
                                                            '',
                                                        width: 12.w,
                                                        height: 4.h,
                                                        radius: 12.w,
                                                        url: '',
                                                      ),
                                                    )
                                              : Center(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Image.file(
                                                      selectedAssetSnapshot.data!,
                                                      fit: BoxFit.cover,
                                                      height: 100,
                                                      width: 100,
                                                    ),
                                                  ),
                                                ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: GestureDetector(
                                                onTap: () {
                                                  bloc.changePhoto(context);
                                                },
                                                child: CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor:
                                                      APPColors.appBlack,
                                                  child: Assets.svgs.edit2.svg(
                                                      width: 4.w,
                                                      height: 1.7.h),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
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
                                      controller: bloc.nameController,
                                      textAlign: TextAlign.start,
                                      fontSize: 12.sp,
                                      borderColor: APPColors.bg_grey25,
                                      fontWeight: FontWeight.normal,
                                      hint: userModel.firstName ?? kFirstName,
                                      onChange: bloc.nameC,
                                      filledColor: Colors.transparent,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.6,
                                      hintFontSize: 10.sp,
                                      maxLines: 1,
                                      hintColor: APPColors.appBlack4,
                                    ),
                                    SizedBox(
                                      height: 2.h,
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
                                      controller: bloc.surNameController,
                                      borderColor: APPColors.bg_grey25,
                                      fontWeight: FontWeight.normal,
                                      hint: userModel.lastName ?? kSurName,
                                      onChange: bloc.surnameC,
                                      filledColor: Colors.transparent,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.6,
                                      hintFontSize: 10.sp,
                                      maxLines: 1,
                                      hintColor: APPColors.appBlack4,
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      bottomNavigationBar: Container(
                        padding: PagePadding.custom(4.w, 4.w, 6.w, 6.w),
                        margin: PagePadding.onlyBottom(3.w),
                        child: StreamBuilder<bool>(
                            stream: bloc.validUpdateDataField,
                            initialData: false,
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              return RabbleButton.tertiaryFilled(
                                buttonSize: ButtonSize.large,
                                bgColor: snapshot.data!
                                    ? APPColors.appPrimaryColor
                                    : APPColors.bg_grey25,
                                onPressed: !snapshot.hasData
                                    ? null
                                    : () {
                                        bloc.updateProfileData();
                                      },
                                child: bloc.state.secondaryBusy
                                    ? const RabbleSecondaryScreenProgressIndicator(
                                        enabled: true,
                                        loaderColor: APPColors.appBlack4,
                                      )
                                    : RabbleText.subHeaderText(
                                        text: kSave,
                                        fontSize: 13.sp,
                                        fontFamily: 'Gosha',
                                        color: snapshot.data!
                                            ? APPColors.appBlack
                                            : APPColors.bg_grey27,
                                        fontWeight: FontWeight.bold,
                                      ),
                              );
                            }),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
