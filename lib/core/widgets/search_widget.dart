import 'package:rabble/config/export.dart';

class SearchWidget extends StatelessWidget {
  final String title;
  final Function? callBack;
  final SearchCubit searchCubit;
  final int? currentIndex;
  final FocusNode? focusNode;

  const SearchWidget(
      {Key? key,
      required this.title,
      this.callBack,
      this.focusNode,
      required this.searchCubit,
      this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, SearchCubit>(
        create: (BuildContext context) => searchCubit,
        builder:
            (BuildContext context, RabbleBaseState state, SearchCubit bloc) {
          return FocusChild(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 4.7.h,
                  width: callBack != null ? 94.w : 73.w,
                  margin: callBack != null
                      ? PagePadding.custom(0, 0, 0.w, 0.w)
                      : PagePadding.custom(2  .w, 0, 0.w, 0.w),
                  decoration: ContainerDecoration.boxDecoration(
                      bg: Color(0xff33405480).withOpacity(0.4),
                      border: callBack == null
                          ? APPColors.appTextPrimary
                          : Colors.transparent,
                      width: 1,
                      radius: 8),
                  child: Padding(
                    padding: PagePadding.horizontalSymmetric(2.w),
                    child: callBack != null
                        ? InkWell(
                            onTap: () {
                              callBack!.call();
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 1.w,
                                ),
                                Assets.svgs.search_normal.svg(),
                                Expanded(
                                    child: IgnorePointer(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 3.w),
                                    child: RabbleTextField.borderLess(
                                      color: APPColors.appWhite,
                                      keyBoardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      hint: title,
                                      filledColor: Colors.transparent,
                                      fontFamily: cPoppins,
                                      letterSpacing: -0.9,
                                      hintColor: APPColors.bg_grey27,
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          )
                        : Row(
                            children: [
                              SizedBox(
                                width: 1.w,
                              ),
                              Assets.svgs.search_normal
                                  .svg(color: APPColors.bg_grey26),
                              Container(
                                  width: 60.w,
                                  padding: EdgeInsets.only(top: 3.w),
                                  child: RabbleTextField.borderLess(
                                    controller: bloc.controller,
                                    color: APPColors.appWhite,
                                    keyBoardType: TextInputType.text,
                                    textAlign: TextAlign.start,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.normal,
                                    cursoeColor: APPColors.appPrimaryColor,
                                    hint: title,
                                    focusNode: focusNode,
                                    onChange: (String query) {
                                      if (query.isNotEmpty &&
                                          query.length > 2) {
                                        dbHelper.insert(query);
                                        bloc.searchProduct(currentIndex);
                                      }
                                    },
                                    filledColor: Colors.transparent,
                                    fontFamily: cPoppins,
                                    letterSpacing: -0.9,
                                    hintColor: APPColors.bg_grey27,
                                  )),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
