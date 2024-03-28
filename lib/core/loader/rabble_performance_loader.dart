import 'dart:ui';

import 'package:lottie/lottie.dart';
import 'package:rabble/core/config/export.dart';

class RabblePerformanceLoader extends StatefulWidget {
  final bool enabled;
  final Widget child;
  final Map map;
  final AnimationController controller;
  final Function(Map) tryAgainCallBack;

  const RabblePerformanceLoader({
    required this.enabled,
    required this.child,
    required this.map,
    required this.controller,
    required this.tryAgainCallBack,
  });

  @override
  State<RabblePerformanceLoader> createState() =>
      _RabblePerformanceLoaderState();
}

class _RabblePerformanceLoaderState extends State<RabblePerformanceLoader>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  int _currentStoryIndex = 0;
  final BehaviorSubject<List<double>> progressValues$subject =
      BehaviorSubject<List<double>>.seeded([0.0, 0.0]);

  List<int> storyDurations = [5, 5];
  BehaviorSubject<int> currentIndex = BehaviorSubject<int>.seeded(0);
  late Key widgetKey;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: storyDurations[_currentStoryIndex]),
    );
    animationListener();
  }

  @override
  void dispose() {
    super.dispose();
    if (_animationController != null && _animationController.isAnimating) {
      _animationController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("here");
    print("map ${widget.map.toString()}");
    print("enable ${widget.enabled}");

    if (widget.map['type'] == '0') {
      _animationController.stop();
    }
    if (widget.map['type'] == '1') {
      _animationController.forward();
    }

    if (widget.enabled) {
      return Container(
        color: APPColors.appBlack4,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      BehaviorSubjectBuilder<String>(
                          subject:
                              BuyingTeamCreationService().groupNameSubject$,
                          builder: (context, snapshot) {
                            return CreationTeamAppbar(
                              backTitle: kPayment,
                              title: snapshot.data,
                              barPercentage: 6,
                            );
                          }),
                      Container(
                        color: Colors.white,
                        padding: PagePadding.horizontalSymmetric(5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.5.h,
                            ),
                            RabbleText.subHeaderText(
                              text: kReviewPayment,
                              color: APPColors.appBlack4,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              margin: const PagePadding.all(0),
                              decoration: ContainerDecoration.boxDecoration(
                                  bg: Colors.transparent,
                                  border: APPColors.bg_grey25,
                                  width: 1,
                                  radius: 8),
                              child: Column(
                                children: [
                                  DeliveryItemWidget(
                                    heading: kOver18,
                                    trailing: Transform.scale(
                                      scale: 1.2,
                                      child: Switch(
                                          value: false,
                                          inactiveThumbColor:
                                              APPColors.bg_grey28,
                                          inactiveTrackColor:
                                              APPColors.bg_grey28,
                                          activeColor:
                                              APPColors.appPrimaryColor,
                                          onChanged: (bool val) {}),
                                    ),
                                  ),
                                  const Divider(
                                    color: APPColors.bg_grey25,
                                    thickness: 1,
                                  ),
                                  DeliveryItemWidget(
                                    heading: kPaymentMethod,
                                    trailing: Container(
                                      height: 4.h,
                                      width: 16.w,
                                      decoration:
                                          ContainerDecoration.boxDecoration(
                                              bg: Colors.transparent,
                                              border: APPColors.bg_grey25,
                                              width: 1,
                                              radius: 8),
                                      child: Assets.svgs.visa
                                          .svg(width: 10.w, height: 5.h),
                                    ),
                                  ),
                                  const Divider(
                                    color: APPColors.bg_grey25,
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: PagePadding.verticalSymmetric(2.w),
                                    child: DeliveryItemWidget(
                                      heading: kTotalPrice,
                                      subHeading: kIncludingVAT,
                                      trailing: RabbleText.subHeaderText(
                                        text:
                                            'GBP ${BuyingTeamCreationService().payDataSubject$.value[mamount]}',
                                        fontSize: 16.sp,
                                        fontFamily: cGosha,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      isLast: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              BehaviorSubjectBuilder<List<double>>(
                  subject: progressValues$subject,
                  builder: (context, progressValueSnapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < storyDurations.length; i++)
                          Container(
                            width: context.allWidth / 2.5,
                            height: 7,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: LinearProgressIndicator(
                                value: progressValueSnapshot.data![i],
                                backgroundColor: APPColors.bg_grey25,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  APPColors.appPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
              widget.enabled
                  ? SizedBox(
                      width: widget.map['type'] == '1'
                          ? MediaQuery.of(context).size.width / 1.12
                          : MediaQuery.of(context).size.width / 2,
                      height: widget.map['type'] == '1'
                          ? context.allHeight * 0.15
                          : context.allHeight * 0.2,
                      child: Lottie.asset(widget.map['json']))
                  : const SizedBox.shrink(),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: RabbleText.subHeaderText(
                  text: widget.map['msg'],
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: APPColors.appWhite,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.map['type'] == '1'
                  ? RabbleText.subHeaderText(
                      text: 'This won\'t take too long.',
                      color: APPColors.bg_grey25,
                      fontSize: 11.sp,
                      fontFamily: cPoppins,
                    )
                  : Padding(
                      padding: const PagePadding.horizontalSymmetric(30),
                      child: RabbleButton.tertiaryFilled(
                        bgColor: APPColors.appPrimaryColor,
                        onPressed: () {
                          setState(() {
                            storyDurations = [5, 5];
                            progressValues$subject.sink.add([0.0, 0.0]);
                            _currentStoryIndex = 0;
                            widget.tryAgainCallBack.call(widget.map);
                            _animationController.duration = Duration(
                                seconds: storyDurations[_currentStoryIndex]);
                          });
                          _animationController.reset();
                          _animationController.forward();
                        },
                        child: RabbleText.subHeaderText(
                          text: 'Try again',
                          fontSize: 14.sp,
                          fontFamily: 'Gosha',
                          color: APPColors.appBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              widget.map['type'] == '0'
                  ? GestureDetector(
                      onTap: () {
                        NavigatorHelper().pop();
                      },
                      child: RabbleText.subHeaderText(
                        text: 'Cancel',
                        color: APPColors.appPrimaryColor,
                        fontSize: 13.sp,
                        fontFamily: cGosha,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );
    }
    return widget.child;
  }

  @override
  void animationListener() {
    _animationController.addListener(() {
      var tempList = progressValues$subject.value;
      tempList[_currentStoryIndex] = _animationController.value;

      progressValues$subject.sink.add(tempList);
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_currentStoryIndex < storyDurations.length - 1) {
          _currentStoryIndex++;
          _animationController.duration =
              Duration(seconds: storyDurations[_currentStoryIndex]);
          _animationController.forward(from: 0.0);
          currentIndex.sink.add(_currentStoryIndex);
        } else {
          // All stories completed, navigate to next screen or exit
        }
      }
    });
    _animationController.reset(); // Reset the animation controller
    _animationController.forward();
  }
}

class WritingTextAnimation extends StatefulWidget {
  final String text;
  final AnimationController controller;

  WritingTextAnimation({
    required this.text,
    required this.controller,
  });

  @override
  _WritingTextAnimationState createState() => _WritingTextAnimationState();
}

class _WritingTextAnimationState extends State<WritingTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late String _animatedText;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animatedText = widget.text;
    _animation = Tween<double>(begin: 0, end: widget.text.length.toDouble())
        .animate(_controller)
      ..addListener(() {
        final endIndex = _animation.value.toInt();
        if (endIndex <= widget.text.length) {
          setState(() {
            _animatedText = widget.text.substring(0, endIndex);
          });
        }
      });

    _controller.forward();
  }

  @override
  void didUpdateWidget(WritingTextAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _animatedText = widget.text;
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: RabbleText.headerText(
        textAlign: TextAlign.center,
        text: _animatedText,
        color: APPColors.appTextPrimary,
        maxLines: 20,
        fontFamily: cPoppins,
        letterSpacing: 0.8,
        wordSpacing: 1.2,
        fontWeight: FontWeight.normal,
        fontSize: 17.sp,
      ),
    );
  }
}
