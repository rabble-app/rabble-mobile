import 'package:rabble/core/config/export.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _currentStoryIndex = 0;

  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = AuthCubit();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: authCubit.storyDurations[_currentStoryIndex]),
    );
    animationListener();
  }

  @override
  void dispose() {
    if (_animationController.isAnimating) {
      _animationController.removeListener(animationListener);

      _animationController.stop();
      _animationController.dispose();
    }
    authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider<RabbleBaseState, AuthCubit>(
      create: (BuildContext context) => authCubit,
      builder: (BuildContext context, RabbleBaseState state, AuthCubit bloc) {
        return Scaffold(
          body: BehaviorSubjectBuilder<int>(
            subject: bloc.currentIndex,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  GestureDetector(
                    onHorizontalDragDown: (DragDownDetails details) {
                      final double screenX = details.globalPosition.dx;
                      final double screenWidth =
                          MediaQuery.of(context).size.width;

                      if (screenX < screenWidth / 2) {
                        if (snapshot.data! - 1 >= 0) {
                          bloc.progressValues$subject.value[snapshot.data!] = 0;

                          final newIndex =
                              snapshot.data! - 1 > 0 ? snapshot.data! - 1 : 0;

                          bloc.currentIndex.sink.add(newIndex);

                          _currentStoryIndex =
                              newIndex; // Update state after updating bloc

                          _animationController.duration = Duration(
                              seconds: authCubit.storyDurations[newIndex]);
                          _animationController.forward(from: 0.0);
                        }
                      } else {
                        if (snapshot.data! + 1 <= 3) {
                          bloc.progressValues$subject.value[snapshot.data!] = 5;

                          final newIndex =
                              snapshot.data! + 1 < 3 ? snapshot.data! + 1 : 3;
                          bloc.currentIndex.sink.add(newIndex);
                          _currentStoryIndex =
                              newIndex; // Update state after updating bloc

                          _animationController.duration = Duration(
                              seconds: authCubit.storyDurations[newIndex]);
                          _animationController.forward(from: 0.0);
                        }
                      }
                    },
                    child: StoryWidget(onboard: bloc.data[snapshot.data!]),
                  ),
                  Positioned(
                    top: context.allHeight * 0.06,
                    left: 5,
                    right: 5,
                    child: BehaviorSubjectBuilder<List<double>>(
                        subject: bloc.progressValues$subject,
                        builder: (context, progressValueSnapshot) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i = 0;
                                  i < authCubit.storyDurations.length;
                                  i++)
                                Container(
                                  width: 23.w,
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
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  void animationListener() {
    _animationController.addListener(() {
      var tempList = authCubit.progressValues$subject.value;
      tempList[_currentStoryIndex] = _animationController.value;
      authCubit.progressValues$subject.sink.add(tempList);
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_currentStoryIndex < authCubit.storyDurations.length - 1) {
          _currentStoryIndex++;
          _animationController.duration =
              Duration(seconds: authCubit.storyDurations[_currentStoryIndex]);

          // Reset and restart the animation here
          _animationController.reset();
          _animationController.forward(from: 0.0);

          authCubit.currentIndex.sink.add(_currentStoryIndex);
        } else {
          // All stories completed, navigate to next screen or exit
        }
      }
    });
    _animationController.forward();
  }
}

class StoryWidget extends StatefulWidget {
  final OnBoardModel onboard;

  const StoryWidget({required this.onboard});

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  int _currentImageIndex = 0;
  StreamController<int> currentImageIndex = StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start from the top
      end: const Offset(0.0, 0.0), // Stop at the center
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: currentImageIndex.stream,
        builder: (context, currentIndexSnapshot) {
          return GestureDetector(
            onTap: () {
              // Pause the animation on tap if needed
              if (_animationController.isAnimating) {
                _animationController.stop();
              } else {
                _animationController.forward();
              }
            },
            behavior: HitTestBehavior.translucent,
            // Ensure gestures are detected on the entire widget area
            onHorizontalDragEnd: (DragEndDetails details) {
              // Check the direction of the swipe
              final velocity = details.primaryVelocity!;
              if (velocity > 0 && currentIndexSnapshot.data! > 0) {
                // Swipe to the right, go to the previous story
                _currentImageIndex--;
                currentImageIndex.sink.add(_currentImageIndex);
                _animationController.reset();
                _animationController.forward();
              } else if (velocity < 0 && currentIndexSnapshot.data! < 3) {
                // Swipe to the left, go to the next story
                _currentImageIndex++;
                currentImageIndex.sink.add(_currentImageIndex);

                _animationController.reset();
                _animationController.forward();
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            Colors.white,
                            Color(0xff000000).withOpacity(0.7)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          widget.onboard.image,
                          fit: BoxFit.cover,
                          width: 100.w,
                          height: 100.h,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: SlideTransition(
                        position: _animation,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RabbleText.subHeaderText(
                                  text: widget.onboard.heading,
                                  fontSize: 55.sp,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: cGosha,
                                  letterSpacing: 0.3,
                                  color: APPColors.appPrimaryColor,
                                ),
                                RabbleText.subHeaderText(
                                  text: widget.onboard.subHeading,
                                  fontSize: 16.sp,
                                  fontFamily: cPoppins,
                                  fontWeight: FontWeight.w600,
                                  color: APPColors.appPrimaryColor3,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                RabbleText.subHeaderText(
                                  text: widget.onboard.title,
                                  fontSize: 15.sp,
                                  fontFamily: cGosha,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w700,
                                  color: APPColors.bg_grey26,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                RabbleText.subHeaderText(
                                  text: widget.onboard.desc,
                                  fontSize: 11.sp,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: cPoppins,
                                  height: 1.5,
                                  color: APPColors.bg_grey25,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 44.w,
                                      child: RabbleButton.primaryFilled(
                                        buttonSize: ButtonSize.medium,
                                        onPressed: () async {
                                          _animationController.stop();

                                          await RabbleStorage().onBoarStatus("1");
                                          NavigatorHelper().navigateAnClearAll(
                                              '/signup_view');
                                        },
                                        child: RabbleText.subHeaderText(
                                          text: kSignUp,
                                          fontSize: 14.sp,
                                          fontFamily: 'Gosha',
                                          color: APPColors.appBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        _animationController.stop();
                                        await RabbleStorage().onBoarStatus("1");
                                        NavigatorHelper()
                                            .navigateAnClearAll('/login');
                                      },
                                      child: Container(
                                        width: 44.w,
                                        height: 4.7.h,
                                        decoration:
                                            ContainerDecoration.boxDecoration(
                                                bg: APPColors.appBlack,
                                                border: APPColors.bg_grey27,
                                                radius: 8,
                                                width: 1),
                                        child: Center(
                                          child: RabbleText.subHeaderText(
                                            text: kLogin,
                                            fontSize: 14.sp,
                                            fontFamily: 'Gosha',
                                            color: APPColors.appPrimaryColor3,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
