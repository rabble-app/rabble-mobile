import '../../../config/export.dart';

class ClearBasketSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ToucheDetector(child: clearBasket(context));
  }

  Widget clearBasket(BuildContext context) {
    return Container(
      color: APPColors.bgColor,
      padding: PagePadding.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          InkWell(
            onTap: () {

              Navigator.of(context).pop(false);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              width: 9.w,
              height: 6.h,
              child: const CircleAvatar(
                backgroundColor: APPColors.appTextPrimary,
                child: Icon(
                  Icons.close,
                  color: APPColors.appWhite,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          RabbleText.subHeaderText(
            text: 'Choosing a new producer?',
            fontSize: 15.sp,
            height: 1.4,
            fontFamily: cGosha,
            fontWeight: FontWeight.bold,
            color: APPColors.appBlack4,
          ),
          SizedBox(
            height: 1.h,
          ),
          RabbleText.subHeaderText(
            text:
                'By changing your current producer you will loose your selections inside the basket.',
            fontSize: 11.sp,
            height: 1.7,
            fontFamily: cPoppins,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.normal,
            color: APPColors.appTextPrimary,
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            height: context.allHeight * 0.1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RabbleButton.tertiaryFilled(
                buttonSize: ButtonSize.large,
                bgColor: APPColors.appPrimaryColor,
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: RabbleText.subHeaderText(
                  text: 'Yes, Change Producer',
                  fontSize: 13.sp,
                  fontFamily: cGosha,
                  color: APPColors.appBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop(false);

              },
              child: RabbleText.subHeaderText(
                text: 'Cancel',
                color: APPColors.appBlack,
                fontFamily: cGosha,
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
