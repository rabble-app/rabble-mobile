import 'package:rabble/core/config/export.dart';

class PostalCodeEmptyWidget extends StatelessWidget {
  const PostalCodeEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.allWidth,
          child: Assets.svgs.empty_postcode.svg(
            height: context.allHeight * 0.4,
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        RabbleText.subHeaderText(
          text: kNoNearbyProducersTeams,
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
            text: KDiscoverProducer,
            fontSize: context.allWidth * 0.03,
            height: 1.4,
            fontWeight: FontWeight.normal,
            color: APPColors.appTextPrimary,
            fontFamily: cPoppins,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Container(
          margin: PagePadding.horizontalSymmetric(4.w),
          child: RabbleButton.tertiaryFilled(
            buttonSize: ButtonSize.large,
            bgColor: APPColors.appPrimaryColor,
            child: RabbleText.subHeaderText(
              text: kAddPostcode,
              fontSize: 12.sp,
              color: APPColors.appBlack,
              fontFamily: cGosha,
              fontWeight: FontWeight.bold,
            ),
            onPressed: () {
              NavigatorHelper().navigateTo('/add_postal_code_view');
            },
          ),
        ),
      ],
    );
  }
}
