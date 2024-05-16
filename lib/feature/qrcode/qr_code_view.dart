import 'package:rabble/core/config/export.dart';

class QrCodeView extends StatelessWidget {
  const QrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: RabbleAppbar(
          leadingWidth: 12.w,
          centerTitle: false,
          titleWidget: RabbleText.subHeaderText(
            text: kQRCode,
            overflow: TextOverflow.ellipsis,
            color: APPColors.appPrimaryColor,
            fontWeight: FontWeight.w600,
            wordSpacing: 2,
            letterSpacing: 0.5,
            fontFamily: cPoppins,
            fontSize: 13.sp,
          ),
          leading: InkWell(
            onTap: () {
              NavigatorHelper().pop();
            },
            child: Container(
              height: 5.h,
              padding: PagePadding.onlyLeft(2.w),
              child: CircleAvatar(
                backgroundColor: APPColors.appPrimaryColor,
                child: const Icon(
                  Icons.close,
                  color: APPColors.appBlack4,
                ),
              ),
            ),
          ),
          title: kQRCode,
        ),
      ),
      body: Container(
        width: context.allWidth,
        color: APPColors.bgColor,
        padding: PagePadding.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RabbleText.subHeaderText(
              text: 'QR Code to\nReceive Order',
              color: APPColors.appBlack4,
              fontWeight: FontWeight.bold,
              fontFamily: cGosha,
              height: 1.3,
              textAlign: TextAlign.start,
              fontSize: 25.sp,
            ),
            SizedBox(
              height: 1.h,
            ),
            RabbleText.subHeaderText(
              text:
                  'Show this QR code to the store owner for order verification.',
              color: APPColors.bg_grey27,
              fontWeight: FontWeight.w400,
              fontFamily: cPoppins,
              textAlign: TextAlign.start,
              fontSize: 11.sp,
            ),
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: Container(
                decoration: ContainerDecoration.boxDecoration(
                    border: APPColors.bg_grey26,
                    bg: APPColors.appWhite,
                    width: 1,
                    radius: 8,
                    showShadow: true),
                child: Assets.svgs.qrcode.svg(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
