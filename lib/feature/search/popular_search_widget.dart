import 'package:rabble/config/export.dart';
import 'package:shimmer/shimmer.dart';

class PopularSearchWidget extends StatelessWidget {
  final List<PopularSearchData> popularSearchList;

  const PopularSearchWidget(this.popularSearchList, {super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Popular Searches',
      'Popular Searches',
      'Small',
      'Popular Searches',
      'Small'
    ];
    return Container(
      color: APPColors.bgColor,
      width: context.allWidth,
      child: popularSearchList.isNotEmpty? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Container(
            margin: PagePadding.horizontalSymmetric(context.allWidth * 0.04),
            child: RabbleText.subHeaderText(
              text: 'Popular Searches',
              fontSize: 15.sp,
              color: APPColors.appBlack,
              fontFamily: cGosha,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            margin: PagePadding.horizontalSymmetric(context.allWidth * 0.04),
            child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              List<Widget>.generate(popularSearchList.length, (index) {
            PopularSearchData data = popularSearchList[index];
            return Container(
                height: 35,
                padding: PagePadding.custom(2.w, 2.w, 1.w, 1.w),
                decoration: ContainerDecoration.boxDecoration(
                    bg: APPColors.bgColor,
                    border: APPColors.bg_grey25,
                    radius: 24,
                    width: 1),
                child: RabbleText.subHeaderText(
                  text: data.keyword,
                  color: APPColors.appBlack,
                  textAlign: TextAlign.start,
                  fontFamily: cPoppins,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ));
          }),
            ),
          )
        ],
      ):SizedBox(),
    );
  }
}
