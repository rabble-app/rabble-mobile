import 'package:rabble/core/config/export.dart';
import 'package:rabble/core/loader/rabble_full_loader.dart';

class MyRabbleAccountView extends StatelessWidget {
  const MyRabbleAccountView({Key? key}) : super(key: key);

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
                  return Scaffold(
                    backgroundColor: APPColors.bgColor,
                    body: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: context.allHeight * 0.2,
                              width: 100.w,
                              color: APPColors.appBlack,
                              child: CustomPaint(
                                painter: BottomCenterRoundPainter(),
                              ),
                            ),
                            Container(
                              padding: PagePadding.custom(3.w, 3.w, 0, 0),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    userModel.imageUrl != null &&
                                            userModel.imageUrl!.isNotEmpty &&
                                            userModel.imageUrl !=
                                                'https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/img.png'
                                        ? Container(
                                            width: 30.w,
                                            height: 15.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(width: 1),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    userModel.imageUrl!,
                                                  ),
                                                  fit: BoxFit.cover,
                                                )),
                                          )
                                        : Center(
                                            child: CircularAvatarWidget(
                                              firstName:
                                                  userModel.firstName ?? '',
                                              lastName:
                                                  userModel.lastName ?? '',
                                              width: 20.w,
                                              fontSize: 26.sp,
                                              height: 5.h,
                                              radius: 15.w,
                                              url: '',
                                            ),
                                          ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (userModel.firstName == null &&
                                            userModel.lastName == null) {
                                          NavigatorHelper()
                                              .navigateTo('/edit_profile_view')
                                              .then((value) {
                                            bloc.fetchMyData();
                                          });
                                        }
                                      },
                                      child: RabbleText.subHeaderText(
                                        text: userModel.firstName == null &&
                                                userModel.lastName == null
                                            ? "Add Your Name"
                                            : '${userModel.firstName ?? ''} ${userModel.lastName ?? ''}',
                                        fontWeight: FontWeight.bold,
                                        fontFamily: cGosha,
                                        color: APPColors.appPrimaryColor,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.7.h,
                                    ),
                                    RabbleText.subHeaderText(
                                      text: '${userModel.phone}',
                                      fontWeight: FontWeight.normal,
                                      fontFamily: cGosha,
                                      color: APPColors.appPrimaryColor2,
                                      fontSize: 11.sp,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(
                            padding: PagePadding.horizontalSymmetric(
                                context.allHeight * 0.02),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: context.allHeight * 0.06,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      NavigatorHelper()
                                          .navigateTo('/edit_profile_view')
                                          .then((value) {
                                        bloc.fetchMyData();
                                      });
                                    },
                                    child: TeamSettingCustomView(
                                      icon: Assets.svgs.userEdit.svg(),
                                      title: kEditProfile,
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: APPColors.appBlue,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      NavigatorHelper()
                                          .navigateTo('/my_subscriptions_view')
                                          .then((value) {
                                        bloc.fetchMyData();
                                      });
                                    },
                                    child: TeamSettingCustomView(
                                      icon: Assets.svgs.crown.svg(),
                                      title: kYourSubscriptions,
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: APPColors.appBlue,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      NavigatorHelper()
                                          .navigateTo('/order_history_view')
                                          .then((value) {
                                        bloc.fetchMyData();
                                      });
                                    },
                                    child: TeamSettingCustomView(
                                      icon: Assets.svgs.truck
                                          .svg(color: APPColors.appBlack4),
                                      title: kOrderHistory,
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: APPColors.appBlue,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      NavigatorHelper()
                                          .navigateTo('/all_cards');
                                    },
                                    child: TeamSettingCustomView(
                                      icon: Assets.svgs.managecard
                                          .svg(color: APPColors.appBlack4),
                                      title: kManageYourCard,
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: APPColors.appBlue,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      NavigatorHelper()
                                          .navigateTo('/setting_view')
                                          .then((value) {
                                        bloc.fetchMyData();
                                      });
                                    },
                                    child: TeamSettingCustomView(
                                      icon: Assets.svgs.setting.svg(
                                          color: APPColors.appBlack4,
                                          height: 2.5.h),
                                      title: kSetting,
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: APPColors.appBlue,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        RabbleStorage.logout(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RabbleText.subHeaderText(
                                          text: kLogout,
                                          fontSize: 13.sp,
                                          height: 1.4,
                                          fontFamily: cGosha,
                                          fontWeight: FontWeight.bold,
                                          color: APPColors.appRedLight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }
}

class BottomCenterRoundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = APPColors.appBlack
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height * 1.6, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
