import '../../../config/export.dart';
import 'dart:math' as math;

class ReceiverChip extends StatelessWidget {
  final int index;
  final ConversationData data;
  const ReceiverChip({super.key, required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePadding.all(2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Container(
          //       margin: PagePadding.custom(0,4.w,2.5.w,0),
          //       child: CustomPaint(
          //         painter: ArrowPainter(),
          //         size: const Size(40.0, 20.0),
          //       ),
          //     ),
          //     SizedBox(width: 1.5.w,),
          //     SizedBox(
          //       width: context.allWidth*0.63,
          //       child: RabbleText
          //           .subHeaderText(
          //         text:
          //         'Okay...Do we have a deal?',
          //         textAlign: TextAlign.start,
          //         fontFamily:
          //         cPoppins,
          //         color: APPColors
          //             .appTextPrimary,
          //         fontSize: 9.sp,
          //         fontWeight:
          //         FontWeight
          //             .w500,
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 4.h,
                height: 4.h,
                child: RabbleImageLoader(
                  imageUrl: '',
                  isRound: true,
                  roundValue: 18,
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              Container(
                margin: PagePadding.onlyTop(1.w),
                decoration: BoxDecoration(
                  color: APPColors.appWhite,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.06),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset:
                          const Offset(0, 3), // Offset in the x and y direction
                    ),
                  ],
                ),
                child: Padding(
                  padding: PagePadding.all(2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.allWidth*0.63,
                        child: RabbleText
                            .subHeaderText(
                          text:
                          'Sean H',
                          textAlign: TextAlign.start,
                          fontFamily:
                          cGosha,
                          color: APPColors
                              .appGreen6,
                          fontSize: 11.sp,
                          fontWeight:
                          FontWeight
                              .w700,
                        ),
                      ),
                      // :
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     SizedBox(
                      //       width: context.allWidth*0.63,
                      //       child: RabbleText
                      //           .subHeaderText(
                      //         text:
                      //         'Sean H',
                      //         textAlign: TextAlign.start,
                      //         fontFamily:
                      //         cGosha,
                      //         color: APPColors
                      //             .appGreen6,
                      //         fontSize: 11.sp,
                      //         fontWeight:
                      //         FontWeight
                      //             .w700,
                      //       ),
                      //     ),
                      //     Container(
                      //       width: context.allWidth*0.01,
                      //       height: context.allWidth*0.01,
                      //       decoration: const BoxDecoration(
                      //         color: APPColors.bg_grey25,
                      //         shape: BoxShape.circle,
                      //       ),
                      //     )
                      //
                      //   ],
                      // ),
                      SizedBox(height: 0.8.h,),
                      SizedBox(
                        width: context.allWidth*0.63,
                        child: RabbleText
                            .subHeaderText(
                          text:
                          data.text ?? '',
                          textAlign: TextAlign.start,
                          fontFamily:
                          cPoppins,
                          color: APPColors
                              .appBlack4,
                          fontSize: 10.sp,
                          height: 1.2,
                          fontWeight:
                          FontWeight
                              .w400,
                        ),
                      ),
                      SizedBox(height: 0.5.h,),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: RabbleText
                            .subHeaderText(
                          text:
                          DateFormatUtil.formatDate(data.createdAt!, 'dd MMM yyyy'),
                          textAlign: TextAlign.start,
                          fontFamily:
                          cGosha,
                          color: APPColors
                              .bg_grey27,
                          fontSize: 9.sp,
                          fontWeight:
                          FontWeight
                              .w400,
                        ),
                      ),


                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = APPColors.bg_grey25
      ..strokeWidth = 1.0;

    // Draw a vertical line.
    canvas.drawLine(
      Offset(0.0, 0.0),
      Offset(0.0, size.height),
      paint,
    );

    // Draw a horizontal line starting from the top of the vertical line.
    canvas.drawLine(
      Offset(0.0, 0.0),
      Offset(size.width, 0.0),
      paint,
    );
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) => false;
}
