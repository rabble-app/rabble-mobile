import 'package:rabble/domain/entities/ConversationModel.dart';
import 'package:rabble/domain/entities/TeamDetailChatModel.dart';

import '../../config/export.dart';
import '../producer/widget/producer_item_shimmer.dart';

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({super.key});

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  late ChatRoomCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cubit = ChatRoomCubit();
    cubit.fetchUserData();
//    initPusher();
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    super.dispose();
    await cubit.pusher.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;

    return CubitProvider<RabbleBaseState, ChatRoomCubit>(
        create: (BuildContext context) => cubit
          ..initScroller(data['teamId'], context)
          ..fetchChatList(data['teamId'])
          ..fetchTeamDetail(data['teamId']),
        builder:
            (BuildContext context, RabbleBaseState state, ChatRoomCubit bloc) {
          return Scaffold(
            backgroundColor: APPColors.appBlack,
            body: ToucheDetector(
              child: Column(
                children: <Widget>[
                  BehaviorSubjectBuilder<TeamDetailChatData>(
                      subject: bloc.teamDetailSubject$,
                      builder: (context, snapshot) {
                        return ChatRoomAppbar(
                          backTitle: kBack,
                          title: snapshot.hasData ? snapshot.data!.name : '',
                          subTitle: snapshot.hasData
                              ? snapshot.data!.producer!.businessName!
                              : '',
                          memeberList:
                              snapshot.hasData ? snapshot.data!.members! : [],
                          hostId: snapshot.hasData ? snapshot.data!.hostId : '',
                          callBack: () {
                            if (bloc.conversationListSubject$.hasValue) {
                              if (bloc
                                  .conversationListSubject$.value.isNotEmpty) {
                                NavigatorHelper().pop(
                                    result: bloc
                                        .conversationListSubject$.value.last);
                              } else {
                                NavigatorHelper().pop();
                              }
                            } else {
                              NavigatorHelper().pop();
                            }
                          },
                        );
                      }),
                  Expanded(
                      child: state.primaryBusy
                          ? Container(
                              color: APPColors.bgColor,
                              child: ListView.builder(
                                  itemCount: 50,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return const ProducerItemShimmer();
                                  }),
                            )
                          : BehaviorSubjectBuilder<List<ConversationData>>(
                              subject: cubit.conversationListSubject$,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<ConversationData>>
                                      snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                    color: APPColors.bgColor,
                                    padding: PagePadding.onlyTop(10.h),
                                    child: Center(
                                      child: EmptyStateWidget(
                                          heading: 'Start Conversation',
                                          subHeading: '',
                                          svg: Assets.svgs.message_empty,
                                          btnHeading: '',
                                          callback: () {}),
                                    ),
                                  );
                                }
                                if (snapshot.data!.isEmpty) {
                                  return Container(
                                    color: APPColors.bgColor,
                                    padding: PagePadding.onlyTop(10.h),
                                    child: Center(
                                      child: EmptyStateWidget(
                                          heading: 'Start Conversation',
                                          subHeading: '',
                                          svg: Assets.svgs.message_empty,
                                          btnHeading: '',
                                          callback: () {}),
                                    ),
                                  );
                                }

                                List<ConversationData> conversationList =
                                    snapshot.data!;

                                return BehaviorSubjectBuilder<UserModel>(
                                    subject: bloc.myDataSubject$,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<UserModel> snapshot) {
                                      return Container(
                                        color: APPColors.bgColor,
                                        child: SingleChildScrollView(
                                          controller: bloc.scrollController,
                                          reverse: conversationList.length > 10
                                              ? true
                                              : false,
                                          padding: EdgeInsets.zero,
                                          child: Column(
                                            children: <Widget>[
                                              if (state.tertiaryBusy)
                                                Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      transform: Matrix4
                                                          .translationValues(
                                                              0, 1.h, 0),
                                                      child:
                                                          const RabbleSecondaryScreenProgressIndicator(
                                                              enabled: true),
                                                    )),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              ConversationListWidget(
                                                  conversationList,
                                                  snapshot.data!.id!)
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              })),
                  StreamBuilder<String>(
                      stream: bloc.messageStream,
                      builder: (context, snapshot) {
                        return Container(
                          height: snapshot.hasData
                              ? snapshot.data!.length >= 45
                                  ? context.allHeight * 0.2
                                  : context.allHeight * 0.12
                              : context.allHeight * 0.12,
                          padding: PagePadding.all(1.h),
                          child: Container(
                            margin: PagePadding.onlyBottom(3.w),
                            child: Padding(
                              padding: PagePadding.custom(1.w, 1.w, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: context.allWidth * 0.82,
                                    height: snapshot.hasData
                                        ? snapshot.data!.length >= 45
                                            ? context.allHeight * 0.1
                                            : context.allHeight * 0.05
                                        : context.allHeight * 0.05,
                                    decoration:
                                        ContainerDecoration.boxDecoration(
                                            bg: APPColors.appBlack4,
                                            border: Colors.transparent,
                                            width: 1,
                                            radius: 8),
                                    child: Container(
                                        width: context.allWidth * 0.82,
                                        padding: EdgeInsets.only(top: 1.w),
                                        child: RabbleTextField.borderLess(
                                          color: APPColors.appWhite,
                                          keyBoardType: TextInputType.text,
                                          controller: bloc.msgController,
                                          textAlign: TextAlign.start,
                                          fontSize: 11.sp,
                                          maxLine: snapshot.hasData
                                              ? snapshot.data!.length >= 45
                                                  ? 2
                                                  : 1
                                              : 1,
                                          hintFontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          cursoeColor:
                                              APPColors.appPrimaryColor,
                                          hint: 'Message',
                                          onChange: bloc.messageC,
                                          filledColor: Colors.transparent,
                                          fontFamily: cPoppins,
                                          letterSpacing: -0.9,
                                          hintColor: APPColors.bg_grey27,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  InkWell(
                                    child: Assets.svgs.send
                                        .svg(width: 1.8.h, height: 1.8.h),
                                    onTap: () {
                                      bloc.sendMessage(
                                          data['teamId'], data['teamName']);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          );
        });
  }
}
