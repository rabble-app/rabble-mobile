import '../../../core/config/export.dart';

class SenderChip extends StatelessWidget {
  final ConversationData data;

  const SenderChip({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePadding.all(2.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: PagePadding.onlyTop(1.w),
            decoration: BoxDecoration(
              color: APPColors.appPrimaryColor,
              // or any color you want for the container
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.06),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0, 3), // Offset in the x and y direction
                ),
              ],
            ),
            child: Padding(
              padding: PagePadding.all(2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 0.2.h,
                  ),
                  data.text!.length > 30
                      ? SizedBox(
                          width: context.allWidth * 0.77,
                          child: RabbleText.subHeaderText(
                            text: data.text ?? '',
                            textAlign: TextAlign.start,
                            fontFamily: cPoppins,
                            color: APPColors.appBlack4,
                            fontSize: 10.sp,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Padding(
                          padding: PagePadding.onlyRight(14.w),
                          child: RabbleText.subHeaderText(
                            text: data.text ?? '',
                            textAlign: TextAlign.start,
                            fontFamily: cPoppins,
                            color: APPColors.appBlack4,
                            fontSize: 11.sp,
                            height: 0.8,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RabbleText.subHeaderText(
                      text: data.createdAt != null
                          ? DateFormatUtil.formatMessageTime(
                              DateTime.parse(data.createdAt.toString()))
                          : '',
                      textAlign: TextAlign.start,
                      fontFamily: cGosha,
                      color: APPColors.appTextPrimary,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          SizedBox(
            width: 4.h,
            height: 4.h,
            child: data.user != null
                ? data.user!.imageUrl!.isNotEmpty
                    ? RabbleImageLoader(
                        imageUrl: data.user!.imageUrl!,
                        isRound: true,
                        roundValue: 18,
                      )
                    : Container(
                        width: 33,
                        height: 45,
                        decoration: ContainerDecoration.boxDecoration(
                            bg: APPColors.appBlack,
                            border: APPColors.appGrey,
                            radius: 40),
                        child: Center(
                          child: RabbleText.subHeaderText(
                            text:
                                '${data.user!.firstName![0]}${data.user!.lastName![0]}',
                            fontSize: 10.sp,
                            fontFamily: cGosha,
                            fontWeight: FontWeight.w500,
                            color: APPColors.appPrimaryColor,
                          ),
                        ),
                      )
                : RabbleImageLoader(
                    imageUrl: '',
                    isRound: true,
                    roundValue: 18,
                  ),
          )
        ],
      ),
    );
  }
}
