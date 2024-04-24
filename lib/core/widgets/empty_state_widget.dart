import 'package:lottie/lottie.dart';
import 'package:rabble/core/config/export.dart';

class EmptyStateWidget extends StatelessWidget {
  final String heading;
  final String subHeading;
  final String btnHeading;
  final SvgGenImage svg;
  final String? loader;
  final VoidCallback callback;
  final bool? isBasket;

  const EmptyStateWidget(
      {Key? key,
      required this.heading,
      required this.subHeading,
      required this.svg,
      required this.btnHeading,
      required this.callback,
      this.isBasket,
      this.loader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.allHeight * 0.09,
        ),
        loader == null
            ? isBasket != null && isBasket!
                ? Container(
                    margin: PagePadding.onlyTop(context.allHeight / 12),
                    width: context.allWidth,
                    child: svg.svg(
                      height: context.allHeight * 0.2,
                    ),
                  )
                : SizedBox(
                    width: context.allWidth,
                    child: svg.svg(
                      height: context.allHeight * 0.2,
                    ),
                  )
            : SizedBox(
                height: context.allHeight * 0.3, child: Lottie.asset(loader!)),
        loader == null
            ? SizedBox(
                height: context.allHeight * 0.07,
              )
            : const SizedBox.shrink(),
        RabbleText.subHeaderText(
          text: heading,
          fontSize: context.allWidth * 0.045,
          fontWeight: FontWeight.bold,
          color: APPColors.appBlack4,
          fontFamily: cGosha,
        ),
        SizedBox(
          height: 1.h,
        ),
        SizedBox(
          width: context.allWidth * 0.87,
          child: RabbleText.subHeaderText(
            text: subHeading,
            fontSize: context.allWidth * 0.03,
            height: 1.4,
            fontWeight: FontWeight.normal,
            color: APPColors.appTextPrimary,
            fontFamily: cPoppins,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        btnHeading.isNotEmpty
            ? isBasket != null && isBasket!
                ? Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: PagePadding.custom(4.w, 4.w, 0, 10.w),
                        child: RabbleButton.tertiaryFilled(
                          buttonSize: ButtonSize.large,
                          bgColor: APPColors.appPrimaryColor,
                          child: RabbleText.subHeaderText(
                            text: btnHeading,
                            fontSize: 12.sp,
                            color: APPColors.appBlack,
                            fontFamily: cGosha,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            callback.call();
                          },
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: PagePadding.horizontalSymmetric(4.w),
                    child: RabbleButton.tertiaryFilled(
                      buttonSize: ButtonSize.large,
                      bgColor: APPColors.appPrimaryColor,
                      child: RabbleText.subHeaderText(
                        text: btnHeading,
                        fontSize: 12.sp,
                        color: APPColors.appBlack,
                        fontFamily: cGosha,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () {
                        callback.call();
                      },
                    ),
                  )
            : const SizedBox.shrink(),
      ],
    );
  }
}
