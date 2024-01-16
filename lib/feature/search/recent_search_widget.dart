import 'package:rabble/config/export.dart';

class RecentSearchWidget extends StatelessWidget {
  final List<RecentSearchData>? recentSearchList;
  final Function(String) callBack;
  final Function callBackClear;
  final Function(int,int) removeCallBack;

  const RecentSearchWidget(this.recentSearchList,
      {super.key, required this.callBack, required this.callBackClear, required this.removeCallBack});

  @override
  Widget build(BuildContext context) {
    return recentSearchList!.isNotEmpty?

    Container(
      color: APPColors.bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          recentSearchList!.isNotEmpty
              ? Container(
                  margin:
                      PagePadding.horizontalSymmetric(context.allWidth * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RabbleText.subHeaderText(
                        text: 'Recent Searches',
                        fontSize: 15.sp,
                        color: APPColors.appBlack,
                        fontFamily: cGosha,
                        fontWeight: FontWeight.w700,
                      ),
                      GestureDetector(
                        onTap: (){
                          callBackClear.call();
                        },
                        child: RabbleText.subHeaderText(
                          text: 'Clear',
                          fontSize: 15.sp,
                          color: APPColors.appBlue,
                          fontFamily: cGosha,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(height: 1.h,),
          Container(
              margin: PagePadding.horizontalSymmetric(context.allWidth * 0.04),
              child: const Divider(
                thickness: 0.8,
                height: 0.8,
                color: APPColors.bg_grey4,
              )),
          SizedBox(
            height: 0.5.h,
          ),
          ListView.builder(
              itemCount: recentSearchList!.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                RecentSearchData data = recentSearchList![index];
                return GestureDetector(
                  onTap: () {
                    callBack.call(data.keyword!);
                  },
                  child: Container(
                    margin: PagePadding.horizontalSymmetric(
                        context.allWidth * 0.01),
                    padding: PagePadding.custom(2.w,2.w,1.w,2.w),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Assets.svgs.search_normal.svg(width: 5.w),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: context.allWidth * 0.7,
                              child: RabbleText.subHeaderText(
                                text: data.keyword,
                                color: APPColors.appBlack,
                                textAlign: TextAlign.start,
                                fontFamily: cPoppins,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            //
                            // const Spacer(),
                            // GestureDetector(
                            //   onTap: (){
                            //     removeCallBack.call(int.parse(data.id!),index);
                            //   },
                            //   child: const SizedBox(
                            //     width: 20,
                            //     height: 20,
                            //     child: Icon(
                            //       Icons.close_outlined,
                            //       color: APPColors.bg_grey27,
                            //       size: 20,
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(width: 10,),
                          ],
                        ),
                        SizedBox(height: 0.5.h,),
                        Container(
                            margin: PagePadding.horizontalSymmetric(context.allWidth * 0.04),
                            child: const Divider(
                              thickness: 0.8,
                              height: 0.8,
                              color: APPColors.bg_grey4,
                            )),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    ):
        const SizedBox.shrink();
  }
}
