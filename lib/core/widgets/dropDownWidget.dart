import 'package:rabble/core/config/export.dart';

class CustomDropDownWidget extends StatelessWidget {
  final String heading;
  final String subHeading;
  final int isExpanded;
  final Function callBack;

  const CustomDropDownWidget(
      {Key? key,
      required this.heading,
      required this.isExpanded,
      required this.subHeading,
      required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, CustomDropDownCubit>(
        create: (context) => CustomDropDownCubit(),
        builder: (context, state, bloc) {
          return Container(
            width: 100.w,
            child: InkWell(
              onTap: () {
                callBack.call(isExpanded);

              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RabbleText.subHeaderText(
                    text: heading,
                    fontFamily: cPoppins,
                    color: APPColors.appTextPrimary,
                    fontSize: 12.sp,
                    height: 1.3,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    padding: PagePadding.all(3.5.w),
                    decoration: ContainerDecoration.boxDecoration(
                        bg: Colors.transparent,
                        border: APPColors.bg_grey25,
                        width: 1,
                        radius: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: RabbleText.subHeaderText(
                            text: subHeading,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            fontFamily: cPoppins,
                            color: APPColors.appTextPrimary,
                            fontSize: 12.sp,
                            height: 1.3,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: APPColors.bg_grey27,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CustomDropDownItemWidget extends StatelessWidget {
  final List<String> list;
  final Function callBack;

  const CustomDropDownItemWidget(this.list, this.callBack, {super.key});

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, CustomDropDownCubit>(
        create: (context) => CustomDropDownCubit(),
        builder: (context, state, bloc) {
          return Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      callBack.call(list[index].toString());
                    },
                    child: Container(
                      width: 100.w,
                      padding: PagePadding.custom(0, 0, 1.5.w, 3.5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: PagePadding.onlyLeft(3.5.w),
                            child: RabbleText.subHeaderText(
                              text: bloc
                                  .singleComma(list[index].toString().trim()),
                              textAlign: TextAlign.start,
                              color: APPColors.appTextPrimary,
                              fontSize: 12.sp,
                              fontFamily: cPoppins,
                              height: 1.3,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          const Divider(
                            color: APPColors.bg_grey23,
                            thickness: 1,
                            height: 0.1,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        });
  }

  String removeConsecutiveCommas(String input) {
    return input.replaceAll(RegExp(r',+'), ',');
  }
}
