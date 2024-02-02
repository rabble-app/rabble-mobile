import 'package:rabble/config/export.dart';

class BuyingTeamItemWidget extends StatelessWidget {
  final String? teamId,
      status,
      address,
      teamName,
      busniessName,
      image,
      frequency,
      category,
      nextDelivery,
      producerName,
      hostName,
      totalTeamMembers,
      postalCode;
  final Function? callBack;
  final bool? isVertical;
  final VoidCallback callBackIfUpdated;
  final OrderHistoryData? historyData;
  final bool? isHost;

  const BuyingTeamItemWidget(
      {Key? key,
      this.teamId,
      this.teamName,
      this.status,
      this.address,
      this.image,
      this.busniessName,
      this.frequency,
      this.category,
      this.nextDelivery,
      this.producerName,
      this.hostName,
      this.totalTeamMembers,
      this.callBack,
      this.isVertical,
      required this.callBackIfUpdated,
      this.historyData,
      this.isHost,
      this.postalCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.allWidth * 0.9,
      decoration: ContainerDecoration.boxDecoration(
          bg: Colors.transparent,
          border: APPColors.bg_grey25,
          width: 1,
          radius: 12),
      padding: PagePadding.custom(2.w, 2.w, 2.w, 0),
      margin: PagePadding.custom(1.w, 3.w, 2.w, !isVertical! ? 2.w : 0),
      child: InkWell(
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');

          if (status != null && status!.isNotEmpty && callBack != null) {
            callBack!.call();
          } else {
            Map map = {'teamId': teamId, 'type': '1', 'teamName': teamName};

            Navigator.pushNamed(context, '/threshold_view', arguments: map)
                .then((value) {
              // if (value != null) {
              //   callBackIfUpdated.call();
              // }
              callBackIfUpdated.call();
            });
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.allHeight * 0.23,
              width: context.allWidth * 0.9,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: context.allWidth * 0.9,
                      height: context.allHeight * 0.23,
                      child: RabbleImageLoader(
                        fit: BoxFit.cover,
                        imageUrl: image ?? '',
                        isRound: false,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      height: 3.h,
                      padding: PagePadding.horizontalSymmetric(2.w),
                      decoration: ContainerDecoration.boxDecoration(
                        bg: APPColors.appBlack,
                        border: APPColors.appBlack,
                        radius: 30,
                      ),
                      child: Center(
                        child: RabbleText.subHeaderText(
                          text: frequency,
                          color: APPColors.appPrimaryColor,
                          fontFamily: cPoppins,
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: context.allWidth * 0.6,
                        child: RabbleText.subHeaderText(
                          text:
                              '$teamName ${postalCode!.length <= 3 ? "" : postalCode!.substring(0, postalCode!.length - 3)}',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          color: APPColors.appPrimaryColor,
                          fontFamily: cGosha,
                          height: 1,
                          fontSize: 30.sp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2.w,
            ),
            Row(
              children: [
                // Container(
                //   width: 18.w,
                //   height: 3.2.h,
                //   decoration: ContainerDecoration.boxDecoration(
                //     bg: APPColors.appYellow,
                //     border: APPColors.appYellow,
                //     radius: 24,
                //   ),
                //   child: Center(
                //     child: RabbleText.subHeaderText(
                //       text: kProdcuer,
                //       color: APPColors.appBlack,
                //       fontFamily: cPoppins,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 8.sp,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   width: 2.w,
                // ),
                // SizedBox(
                //   width: context.allWidth * 0.3,
                //   child: RabbleText.subHeaderText(
                //     maxLines: 1,
                //     text: busniessName ?? '',
                //     textAlign: TextAlign.start,
                //     fontWeight: FontWeight.normal,
                //     color: APPColors.appBlack,
                //     fontFamily: cGosha,
                //     fontSize: 11.sp,
                //   ),
                // ),
                isHost != null && isHost!
                    ? Container(
                        width: 10.w,
                        height: 3.2.h,
                        decoration: ContainerDecoration.boxDecoration(
                          bg: APPColors.appYellow,
                          border: APPColors.appYellow,
                          radius: 24,
                        ),
                        child: Center(
                          child: RabbleText.subHeaderText(
                            text: kHost2,
                            color: APPColors.appBlack,
                            fontFamily: cPoppins,
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                        ),
                      )
                    : isHost != null && !isHost!
                        ? Container(
                            width: 15.w,
                            height: 3.2.h,
                            decoration: ContainerDecoration.boxDecoration(
                              bg: APPColors.appYellow,
                              border: APPColors.appYellow,
                              radius: 24,
                            ),
                            child: Center(
                              child: RabbleText.subHeaderText(
                                text: 'Member',
                                color: APPColors.appBlack,
                                fontFamily: cPoppins,
                                fontWeight: FontWeight.bold,
                                fontSize: 8.sp,
                              ),
                            ),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 10.w,
                                height: 3.2.h,
                                decoration: ContainerDecoration.boxDecoration(
                                  bg: APPColors.appYellow,
                                  border: APPColors.appYellow,
                                  radius: 24,
                                ),
                                child: Center(
                                  child: RabbleText.subHeaderText(
                                    text: kHost2,
                                    color: APPColors.appBlack,
                                    fontFamily: cPoppins,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: context.allWidth * 0.25,
                                child: Center(
                                  child: RabbleText.subHeaderText(
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: hostName ?? '',
                                    fontWeight: FontWeight.w400,
                                    color: APPColors.appBlack,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              )
                            ],
                          ),
                const Spacer(),
                Row(
                  children: [
                    Assets.svgs.multi_profileuser
                        .svg(width: 4.w, height: 2.h, color: APPColors.appBlue),
                    SizedBox(
                      width: 2.w,
                    ),
                    RabbleText.subHeaderText(
                      text:
                          '${totalTeamMembers ?? '0'} ${totalTeamMembers == '1' ? 'member' : 'members'}',
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w500,
                      color: APPColors.bg_grey27,
                      fontFamily: cPoppins,
                      fontSize: 9.sp,
                    ),
                  ],
                )
              ],
            ),
            const Divider(
              color: APPColors.bg_grey25,
              thickness: 0.7,
            ),
            SizedBox(
              width: context.allWidth * 0.5,
              child: RabbleText.subHeaderText(
                text: busniessName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.bold,
                color: APPColors.appTextPrimary,
                fontFamily: cGosha,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    category!.isNotEmpty
                        ? Row(
                            children: [
                              Assets.svgs.category.svg(
                                  width: 4.w,
                                  height: 2.h,
                                  color: APPColors.appBlue),
                              SizedBox(
                                width: 2.w,
                              ),
                              RabbleText.subHeaderText(
                                text: category ?? '',
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w500,
                                color: APPColors.bg_grey27,
                                fontFamily: cPoppins,
                                fontSize: 9.sp,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Assets.svgs.home.svg(
                                  width: 4.w,
                                  height: 2.h,
                                  color: APPColors.appBlue),
                              SizedBox(
                                width: 2.w,
                              ),
                              SizedBox(
                                width: context.allWidth * 0.4,
                                child: RabbleText.subHeaderText(
                                  text: address ?? '',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                  color: APPColors.bg_grey27,
                                  fontFamily: cPoppins,
                                  fontSize: 9.sp,
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Assets.svgs.truck_blue.svg(
                            width: 4.w, height: 2.h, color: APPColors.appBlue),
                        SizedBox(
                          width: 2.w,
                        ),
                        RabbleText.subHeaderText(
                          text: nextDelivery ?? '',
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w500,
                          color: APPColors.bg_grey27,
                          fontFamily: cPoppins,
                          fontSize: 9.sp,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                status != null && status == 'PENDING'
                    ? Container(
                        width: isHost == null ? 25.w : 18.w,
                        height: 3.h,
                        decoration: ContainerDecoration.boxDecoration(
                          bg: APPColors.bg_grey33,
                          border: APPColors.bg_grey33,
                          radius: 30,
                        ),
                        child: Center(
                          child: RabbleText.subHeaderText(
                            text:
                                isHost == null ? 'Request Pending' : 'Pending',
                            color: APPColors.appBlue,
                            fontFamily: cPoppins,
                            fontWeight: FontWeight.w600,
                            fontSize: 7.sp,
                          ),
                        ),
                      )
                    : status != null && status == 'APPROVED'
                        ? Container(
                            width: 15.w,
                            height: 3.h,
                            decoration: ContainerDecoration.boxDecoration(
                              bg: APPColors.appBlack,
                              border: APPColors.appBlack,
                              radius: 30,
                            ),
                            child: Center(
                              child: RabbleText.subHeaderText(
                                text: 'Member',
                                color: APPColors.appPrimaryColor,
                                fontFamily: cPoppins,
                                fontWeight: FontWeight.w600,
                                fontSize: 7.sp,
                              ),
                            ),
                          )
                        : status != null && status == 'CANCELLED'
                            ? Container(
                                width: 18.w,
                                height: 3.h,
                                decoration: ContainerDecoration.boxDecoration(
                                  bg: APPColors.appRedLight2,
                                  border: APPColors.appRedLight2,
                                  radius: 30,
                                ),
                                child: Center(
                                  child: RabbleText.subHeaderText(
                                    text: 'Cancelled',
                                    color: APPColors.appRedLight,
                                    fontFamily: cPoppins,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 7.sp,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                SizedBox(
                  width: 2.w,
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            if (historyData != null)
              const Divider(
                color: APPColors.bg_grey25,
                thickness: 0.7,
              ),
            if (historyData != null)
              BuyingTeamCardView(
                  amount: DateFormatUtil.amountFormatter(historyData!.amount!.toDouble()),
                  date: DateFormatUtil.formatDate(
                      historyData!.order!.createdAt!, 'dd MMM yyyy'),
                  deliveryFee: sDeliveryAmount,
                  orderItems: historyData!.order!.team!.name!,
                  orderNumber: historyData!.order!.team!.postalCode!,
                  subTotal: DateFormatUtil.amountFormatter(double.parse(
                      getTotalAmount(historyData!.order!.basket!))),
                  orderQty: historyData!.order!.basket!.length.toString(),
                  basket: historyData!.order!.basket),
            if (historyData != null)
              SizedBox(
                height: 1.h,
              ),
          ],
        ),
      ),
    );
  }

  String getTotalAmount(List<Basket>? orders) {
    return orders!.fold(
        '0',
        (previousValue, element) =>
            (double.parse(previousValue) + double.parse(element.price.toString()))
                .toString());
  }

  String getOutwardCode(String postalCode) {

    if (postalCode == null || postalCode.isEmpty) {
      return '';
    }

    // Check if there's a space, if so just return before the space
    if (postalCode.contains(' ')) {
      return postalCode.split(' ')[0];
    }

    // If no space, we need to infer based on the postcode formats
    RegExp ln = RegExp(r'^[A-Z][0-9]');
    RegExp lln = RegExp(r'^[A-Z]{2}[0-9]');
    RegExp lnn = RegExp(r'^[A-Z][0-9]{2}');
    RegExp llnn = RegExp(r'^[A-Z]{2}[0-9]{2}');
    RegExp llnl = RegExp(r'^[A-Z]{2}[0-9][A-Z]');
    RegExp lnl = RegExp(r'^[A-Z][0-9][A-Z]');

    if (ln.hasMatch(postalCode)) {
      return postalCode.substring(0, 2);
    } else if (lln.hasMatch(postalCode) || llnl.hasMatch(postalCode)) {
      return postalCode.substring(0, 3);
    } else if (lnn.hasMatch(postalCode) ||
        lnl.hasMatch(postalCode) ||
        llnn.hasMatch(postalCode)) {
      return postalCode.substring(0, 4);
    }

    return postalCode; // Default to return the full code if no format matched
  }
}
