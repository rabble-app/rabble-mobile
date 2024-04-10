import 'package:rabble/core/util/trim_name_extension.dart';
import 'package:rabble/feature/share/share_product_view.dart';

import '../../core/config/export.dart';
import '../../domain/entities/PartionedProductsData.dart';

class PortionedProductBoxListWidget extends StatelessWidget {
  final int totalItems;
  final List<PartionedProducts> partionedProductsList;
  final List<TempBoxData> purchaseUser;

  const PortionedProductBoxListWidget(
      {super.key,
      required this.totalItems,
      required this.partionedProductsList,
      required this.purchaseUser});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1;

    return Container(
      padding: PagePadding.customHorizontalVerticalSymmetric(3.w, 2.h),
      margin: PagePadding.onlyTop(2.w),
      decoration: ContainerDecoration.boxDecoration(
          bg: APPColors.appWhite,
          border: APPColors.appWhite,
          radius: 8,
          width: 1,
          showShadow: true),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: totalItems,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: (itemWidth / itemHeight)),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: context.allWidth * 0.04,
            width: context.allWidth * 0.23,
            padding: PagePadding.horizontalSymmetric(1.w),
            decoration: ContainerDecoration.boxDecoration(
                border: purchaseUser.length > index
                    ? APPColors.appBlack
                    : APPColors.bg_grey26,
                bg: purchaseUser.length > index
                    ? APPColors.appBlack
                    : APPColors.bg_grey26,
                width: 1,
                radius: 8),
            child: Container(
              margin: purchaseUser.length > index
                  ? PagePadding.verticalSymmetric(1.w)
                  : PagePadding.custom(0.3.w, 0.3.w, 1.3.w, 1.3.w),
              decoration: ContainerDecoration.boxDecoration(
                  border: purchaseUser.length > index
                      ? APPColors.appBlack
                      : APPColors.borderColor2,
                  bg: purchaseUser.length > index
                      ? APPColors.appBlack
                      : APPColors.borderColor2,
                  width: 1,
                  radius: 4),
              child: purchaseUser.length > index
                  ? Center(
                      child: RabbleText.subHeaderText(
                        text: purchaseUser.length > index
                            ? purchaseUser[index].userName!.getName()
                            : '',
                        fontWeight: FontWeight.bold,
                        color: APPColors.appPrimaryColor,
                        fontSize: 7.2.sp,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}

class PortionedProductListWidget extends StatefulWidget {
  final List<PartionedProducts> partionedProductsList;
  final int totalItems;
  final List<TempBoxData> purchaseUser;
  final int index;
  final TeamData teamData;
  final Function(bool)? expendedCallBack;

  const PortionedProductListWidget(
      {super.key,
      required this.partionedProductsList,
      required this.totalItems,
      required this.purchaseUser,
      required this.index,
      required this.teamData,
      this.expendedCallBack});

  @override
  State<PortionedProductListWidget> createState() =>
      _PortionedProductListWidgetState();
}

class _PortionedProductListWidgetState
    extends State<PortionedProductListWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1;

    return Container(
        margin: PagePadding.verticalSymmetric(1.w),
        decoration: ContainerDecoration.boxDecoration(
            bg: Colors.transparent,
            border: APPColors.bg_grey25,
            radius: 8,
            width: 1),
        child: Theme(
          data: ThemeData(
            /// Prevents to splash effect when clicking.
            splashColor: Colors.transparent,

            /// Prevents the mouse cursor to highlight the tile when hovering on web.
            hoverColor: Colors.transparent,

            /// Hides the highlight color when the tile is pressed.
            highlightColor: Colors.transparent,

            /// Makes the top and bottom dividers invisible when expanded.
            dividerColor: Colors.transparent,

            /// Make background transparent.
            expansionTileTheme: const ExpansionTileThemeData(
              backgroundColor: Colors.transparent,
              collapsedBackgroundColor: Colors.transparent,
            ),
          ),
          child: ExpansionTile(
            backgroundColor: Colors.transparent,
            collapsedBackgroundColor: Colors.transparent,
            initiallyExpanded: false,
            tilePadding: PagePadding.horizontalSymmetric(1.w),
            expandedAlignment: Alignment.center,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    width: context.allWidth * 0.12,
                    height: MediaQuery.of(context).size.height * 0.052,
                    child: RabbleImageLoader(
                      imageUrl: widget.partionedProductsList[widget.index]
                              .product!.imageUrl ??
                          '',
                      isRound: false,
                      roundValue: 25,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 1.5.w),
                // Title and other details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.5.h,
                    ),
                    RabbleText.subHeaderText(
                      text:
                          '${widget.partionedProductsList[widget.index].product!.unitsPerOrder} ${widget.partionedProductsList[widget.index].product!.orderSubUnit!.toLowerCase()} ${widget.partionedProductsList[widget.index].product!.orderUnit!.toLowerCase()} of',
                      fontSize: 8.sp,
                      fontFamily: cPoppins,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w500,
                      color: APPColors.bg_grey27,
                    ),
                    SizedBox(
                      height: 0.3.h,
                    ),
                    SizedBox(
                      width: context.allWidth * 0.5,
                      child: RabbleText.subHeaderText(
                        text: widget
                            .partionedProductsList[widget.index].product!.name,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                        fontFamily: cPoppins,
                        color: APPColors.appTextPrimary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 9.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            maintainState: true,
            onExpansionChanged: (b) {
              setState(() {
                isExpanded = b;
              });
              if (widget.expendedCallBack != null) {
                Future.delayed(Duration(milliseconds: 50), () {
                  widget.expendedCallBack!.call(b);
                });
              }
            },
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: ContainerDecoration.boxDecoration(
                      bg: widget.totalItems - widget.purchaseUser.length == 0
                          ? APPColors.appPrimaryColor
                          : APPColors.appBlack4,
                      border:
                          widget.totalItems - widget.purchaseUser.length == 0
                              ? APPColors.appPrimaryColor
                              : APPColors.appBlack4,
                      width: 1,
                      radius: 20),
                  child: Padding(
                    padding: PagePadding.customHorizontalVerticalSymmetric(
                        1.w, 0.8.w),
                    child: RabbleText.subHeaderText(
                      text: widget.totalItems - widget.purchaseUser.length == 0
                          ? 'SOLD'
                          : '${widget.totalItems - widget.purchaseUser.length} left',
                      fontFamily: cPoppins,
                      fontSize: 7.sp,
                      color: widget.totalItems - widget.purchaseUser.length == 0
                          ? APPColors.appBlack4
                          : APPColors.appPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                !isExpanded
                    ? Assets.svgs.arrowUp.svg()
                    : Assets.svgs.arrowDown.svg(),
                SizedBox(
                  width: 1.w,
                ),
              ],
            ),
            children: [
              Container(
                padding:
                    PagePadding.customHorizontalVerticalSymmetric(3.w, 1.h),
                margin: PagePadding.custom(1.w, 1.w, 2.w, 2.w),
                decoration: ContainerDecoration.boxDecoration(
                    bg: APPColors.bg_grey26,
                    border: APPColors.bg_grey25,
                    radius: 8,
                    width: 1,
                    showShadow: true),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: widget.totalItems,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: (itemWidth / itemHeight)),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: context.allWidth * 0.04,
                      width: context.allWidth * 0.23,
                      padding: PagePadding.horizontalSymmetric(1.w),
                      decoration: ContainerDecoration.boxDecoration(
                          border: widget.purchaseUser.length > index
                              ? widget.totalItems -
                                          widget.purchaseUser.length ==
                                      0
                                  ? APPColors.appPrimaryColor
                                  : APPColors.appBlack
                              : APPColors.bg_grey25,
                          bg: widget.purchaseUser.length > index
                              ? widget.totalItems -
                                          widget.purchaseUser.length ==
                                      0
                                  ? APPColors.appPrimaryColor
                                  : APPColors.appBlack
                              : APPColors.bg_grey25,
                          width: 1,
                          radius: 8),
                      child: Container(
                        margin: widget.purchaseUser.length > index
                            ? PagePadding.verticalSymmetric(1.w)
                            : PagePadding.custom(0.3.w, 0.3.w, 1.3.w, 1.3.w),
                        decoration: ContainerDecoration.boxDecoration(
                            border: widget.purchaseUser.length > index
                                ? widget.totalItems -
                                            widget.purchaseUser.length ==
                                        0
                                    ? APPColors.appPrimaryColor
                                    : APPColors.appBlack
                                : APPColors.bg_grey25,
                            bg: widget.purchaseUser.length > index
                                ? widget.totalItems -
                                            widget.purchaseUser.length ==
                                        0
                                    ? APPColors.appPrimaryColor
                                    : APPColors.appBlack
                                : APPColors.bg_grey25,
                            width: 1,
                            radius: 4),
                        child: widget.purchaseUser.length > index
                            ? Center(
                                child: RabbleText.subHeaderText(
                                  text: widget.purchaseUser.length > index
                                      ? widget.purchaseUser[index].userName!
                                          .getName()
                                      : '',
                                  fontWeight: FontWeight.bold,
                                  color: widget.totalItems -
                                              widget.purchaseUser.length ==
                                          0
                                      ? APPColors.appBlack
                                      : APPColors.appPrimaryColor,
                                  fontSize: 7.2.sp,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    );
                  },
                ),
              ),
              if (widget.totalItems - widget.purchaseUser.length != 0) ...[
                InkWell(
                  onTap: () async {
                    CustomBottomSheet.showSharePortionedBottomModelSheet(
                        context,
                        ShareProductView(
                          teamData: widget.teamData,
                          index: widget.index,
                          totalItems: widget.totalItems,
                          partionedProductsList: widget.partionedProductsList,
                          purchaseUser: widget.purchaseUser,
                        ),
                        true,
                        isRemove: true);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.svgs.share.svg(color: APPColors.appBlue),
                      SizedBox(
                        width: 1.w,
                      ),
                      RabbleText.subHeaderText(
                        text:
                            'Share this ${widget.partionedProductsList[widget.index].product!.orderUnit} with a friend',
                        color: APPColors.appBlue,
                        fontFamily: cPoppins,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                )
              ]
            ],
          ),
        ));
  }

  dynamic content(String text,
      {FontWeight? fontWeight,
      double? fontSize,
      Color? color,
      String? fontFamily}) {
    return RabbleText.subHeaderText(
      text: text,
      fontSize: fontSize,
      fontFamily: fontFamily ?? cPoppins,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
