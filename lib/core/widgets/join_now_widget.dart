import 'package:rabble/config/export.dart';

class JoinNowWidget extends StatelessWidget {
  final Function? callBack;
  const JoinNowWidget({Key? key,this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        showDialog(
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: RabbleInfoDialog(
                content: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: APPColors.appLightGrey,
                      radius: 7.w,
                      child: Assets.svgs.placeHolder
                          .svg(width: 8.w, height: 4.5.h),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    RabbleText.subHeaderText(
                      text: kJoinTeamMsg,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.3.sp,
                    ),

                    SizedBox(height: 5.h,),
                    RabbleTextField.border(
                      color: APPColors.appBlack,
                      keyBoardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      fontSize: 12.sp,
                      hintFontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      hint:  kIntroduceYS,
                      filledColor: APPColors.bg_grey13,
                      maxLines: 4,
                      fontFamily: 'Gosha',
                      letterSpacing: -0.9,
                      hintColor: APPColors.appIcons,
                    ),

                    ContinueButtonWidget(
                      width: 60.w,
                      label: kRequestToJoin,
                      callBack: () {
                        NavigatorHelper().pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
          height: 3.5.h,
          padding: PagePadding.verticalHorizontalSymmetric(2.5.w),
          decoration: ContainerDecoration.boxDecoration(
            bg: APPColors.appYellow,
            border: APPColors.appYellow,
            radius: 24,
          ),
          child:Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  RabbleText.subHeaderText(
                    text: kJoinNow,
                    color: APPColors.appBlack,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                    width: 15.w,
                    height: 0.2.h,
                    color: APPColors.appBlack,
                  ),
                ],
              ),
              const Icon(
                Icons.add_outlined,
                color: APPColors.appBlack,
                size: 12,
              )
            ],
          )
      ),
    );
  }
}
