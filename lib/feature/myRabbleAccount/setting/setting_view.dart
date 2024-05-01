import 'package:rabble/core/config/export.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, MyRabbleAccountCubit>(
        create: (context) => MyRabbleAccountCubit(),
        builder: (context, state, bloc) {
          return Scaffold(
            backgroundColor: APPColors.bgColor,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(8.h),
                child:  RabbleAppbar(
                  canGoBack: !state.tertiaryBusy,
                  backgroundColor: APPColors.bg_app_primary,
                  title: kSetting,
                )),
            body: SafeArea(
              child: Container(
                padding: PagePadding.all(3.w),
                margin: PagePadding.onlyTop(2.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          final String recipient = 'support@rabble.market';
                          final String subject = 'Subject of your email';
                          final String body = 'Your email content goes here';

                          final Uri mailtoUrl = Uri(
                            scheme: 'mailto',
                            path: recipient,
                            queryParameters: {
                              'subject': subject,
                              'body': body,
                            },
                          );
                          if (!await launchUrl(mailtoUrl,
                              mode: LaunchMode.externalNonBrowserApplication)) {
                            throw 'Could not launch $mailtoUrl';
                          }
                        },
                        child: TeamSettingCustomView(
                          icon: Container(
                              margin: PagePadding.onlyTop(1.w),
                              child: Assets.svgs.chat
                                  .svg(width: 3.w, height: 2.h)),
                          title: kContactUsFeedback,
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: APPColors.appBlue,
                            size: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _launchUrl();
                        },
                        child: TeamSettingCustomView(
                          icon: Container(
                              margin: PagePadding.onlyTop(1.w),
                              child: Assets.svgs.feedback
                                  .svg(width: 3.w, height: 2.h)),
                          title: kProvideYourFeedback,
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: APPColors.appBlue,
                            size: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          NavigatorHelper().navigateToWebScreen('2', '2');
                        },
                        child: TeamSettingCustomView(
                          icon: Assets.svgs.faqs.svg(width: 3.w, height: 2.h),
                          title: kFAQs,
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: APPColors.appBlue,
                            size: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: TeamSettingCustomView(
                          icon: Assets.svgs.star.svg(width: 3.w, height: 2.h),
                          title: kRateRabble,
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: APPColors.appBlue,
                            size: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _launchUrl();
                        },
                        child: TeamSettingCustomView(
                          icon:
                              Assets.svgs.warning.svg(width: 3.w, height: 2.h),
                          title: kUpdateRABBLE,
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: APPColors.appBlue,
                            size: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          NavigatorHelper().navigateToWebScreen('3', '3');
                        },
                        child: TeamSettingCustomView(
                          icon: Assets.svgs.terms.svg(width: 3.w, height: 2.h),
                          title: kTermsofUse,
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: APPColors.appBlue,
                            size: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          NavigatorHelper().navigateToWebScreen('1', '1');
                        },
                        child: TeamSettingCustomView(
                          icon: Assets.svgs.terms.svg(width: 3.w, height: 2.h),
                          title: kPrivacyPolicy,
                          trailing: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: APPColors.appBlue,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: PagePadding.onlyBottom(7.h),
              child: InkWell(
                onTap: () {
                  CustomBottomSheet.showAccountBottomModelSheet(context,
                      RemoveMyAccount(
                    callBackDelete: () async {
                      bool res = await bloc.deleteMyAccount();
                      if (res) {
                        RabbleStorage().userAccountDeletion();
                      }
                    },
                  ), true, isRemove: true);
                },
                child: state.tertiaryBusy
                    ? SizedBox(
                        width: 4.h,
                        height: 4.h,
                        child: const Center(
                          child: RabbleSecondaryScreenProgressIndicator(
                            enabled: true,
                          ),
                        ),
                      )
                    : RabbleText.subHeaderText(
                        text: kCloseAccount,
                        fontSize: 13.sp,
                        height: 1.4,
                        fontFamily: cGosha,
                        fontWeight: FontWeight.bold,
                        color: APPColors.appRedLight,
                      ),
              ),
            ),
          );
        });
  }

  Future<void> _launchUrl() async {
    String url = Platform.isIOS
        ? 'https://apps.apple.com/app/rabble/id6450045487'
        : 'https://apps.apple.com/app/rabble/id6450045487';
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication)) {
      throw 'Could not launch $url';
    }
  }
}
