import 'package:contacts_service/contacts_service.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/ConversationModel.dart';
import 'package:rabble/domain/entities/TeamDetailChatModel.dart';
import 'package:rabble/domain/entities/contact_data.dart';
import 'package:rxdart/rxdart.dart';

class ChatRoomCubit extends RabbleBaseCubit with Validators {
  ChatRoomCubit() : super(RabbleBaseState.idle());

  ScrollController scrollController = ScrollController();
  int offset = 0;
  bool isEmpty = false;

  BehaviorSubject<List<ConversationData>> conversationListSubject$ =
      BehaviorSubject();

  BehaviorSubject<List<TeamChatData>> teamChatListSubject$ = BehaviorSubject();
  BehaviorSubject<TeamDetailChatData> teamDetailSubject$ = BehaviorSubject();

  final TextEditingController msgController = TextEditingController();

  BehaviorSubject<UserModel> myDataSubject$ = BehaviorSubject();

  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  final BehaviorSubject<String> _messageSubject$ = BehaviorSubject();

  Function(String) get messageC => _messageSubject$.sink.add;

  Stream<String> get messageStream => _messageSubject$.transform(validateEmpty);

  late PusherChannel myChannel;

  String socketId = '';

  void initScroller(String teamId, BuildContext context) {
    scrollController.addListener(() {
      FocusScope.of(context).unfocus();

      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          // Fetch more data based on the direction of scrolling
          if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
            // Normal scrolling (down)
            // No action needed for normal scrolling in this example
          } else {
            if (!isEmpty) {
              offset = offset + 30;
              fetchChatList(teamId);
            }
          }
        }
      }
    });
  }

  Future<void> fetchUserData() async {
    var userData =
        await RabbleStorage.retrieveDynamicValue(RabbleStorage.userKey);
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));
    myDataSubject$.sink.add(userModel);
  }

  Future<void> initPusher(String teamName) async {
     const String API_KEY =
         kDebugMode ? '748c798ef5d23aa4750d' : '87b6fa5d4ff005ec100e';
     //  const String API_KEY = '748c798ef5d23aa4750d';

    const String API_CLUSTER = 'eu';
    await pusher.init(
        apiKey: API_KEY,
        cluster: API_CLUSTER,
        onConnectionStateChange: onConnectionStateChange,
        onError: (String message, int? code, dynamic e) {
          print('onError $message');
        },
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onAuthorizer: (String channelName, String socketId, authData) async {
          // return <String, String>{
          //   "auth":
          //       "748c798ef5d23aa4750d:${getSignature("$socketId:$channelName")}",
          // };
          return <String, String>{
            "auth": "$API_KEY:${getSignature("$socketId:$channelName")}",
          };
        });
    await pusher.connect();

    if (teamDetailSubject$.hasValue) {
      if (teamDetailSubject$.value.name != null) {
        myChannel = await pusher.subscribe(
          channelName:
              'private-${removeSpaces(removeIntegers(teamDetailSubject$.value.name!.trim()))}-chat',
          onEvent: (event) {
            print(event.toString());
          },
        );
      } else {
        myChannel = await pusher.subscribe(
          channelName:
              'private-${removeSpaces(removeIntegers(teamName.trim()))}-chat',
          onEvent: (event) {
            print(event.toString());
          },
        );
      }
    } else {
      myChannel = await pusher.subscribe(
        channelName:
            'private-${removeSpaces(removeIntegers(teamName.trim()))}-chat',
        onEvent: (event) {
          print(event.toString());
        },
      );
    }
  }

  String removeIntegers(String input) {
    return input.replaceAll(RegExp(r'\d+'), '');
  }

  String removeSpaces(String input) {
    String tempText = input.replaceAll(' ', '');
    return tempText.length > 2 ? tempText : 'Rabble$tempText';
  }

  Future<BaseModel> connectPusher(String channelName, String socketId) async {
    final loginRes = await chatRepo
        .connectionPusher(socketId, throwOnError: false, errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (loginRes!.status == 200) {
      print(loginRes.data.toString());
      return loginRes;
    } else {
      return loginRes;
    }
  }

  Future<void> fetchChatList(String teamId) async {
    if (offset == 0) {
      emit(RabbleBaseState.primaryBusy());
    } else {
      emit(RabbleBaseState.tertiaryBusy());
    }

    final chatRes = await chatRepo.fetchChatList(
      teamId,
      offset.toString(),
      throwOnError: false,
      errorCallBack: () {
        emit(RabbleBaseState.idle());
      },
    );

    if (chatRes!.statusCode == 201) {
      List<ConversationData> tempList = conversationListSubject$.hasValue
          ? conversationListSubject$.value
          : [];

      if (chatRes.data!.isEmpty) {
        isEmpty = true;
      } else {
        // Insert the new messages at the beginning of the list
        tempList.insertAll(0, chatRes.data!);
        conversationListSubject$.sink.add(tempList);
      }
    }
    emit(RabbleBaseState.idle());
  }

  Future<void> sendMessage(String teamId, String? name) async {
    if (_messageSubject$.value.isNotEmpty) {
      if (teamDetailSubject$.hasValue) {
        if (teamDetailSubject$.value.name != null) {
          pusher.trigger(
            PusherEvent(
              channelName: 'private-${teamDetailSubject$.value.name}-chat',
              eventName: 'client-chat',
              data: jsonEncode(ConversationData(
                  text: _messageSubject$.value,
                  userId: myDataSubject$.value.id,
                  user: User.fromLocalStorage(myDataSubject$.value),
                  producer: Producer.fromLocalStorage(),
                  createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                      .format(DateTime.now()))),
            ),
          );
        } else {
          pusher.trigger(
            PusherEvent(
              channelName: 'private-$name-chat',
              eventName: 'client-chat',
              data: jsonEncode(ConversationData(
                  text: _messageSubject$.value,
                  userId: myDataSubject$.value.id,
                  user: User.fromLocalStorage(myDataSubject$.value),
                  producer: Producer.fromLocalStorage(),
                  createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                      .format(DateTime.now()))),
            ),
          );
        }
      } else {
        pusher.trigger(
          PusherEvent(
            channelName: 'private-$name-chat',
            eventName: 'client-chat',
            data: jsonEncode(ConversationData(
                text: _messageSubject$.value,
                userId: myDataSubject$.value.id,
                user: User.fromLocalStorage(myDataSubject$.value),
                producer: Producer.fromLocalStorage(),
                createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                    .format(DateTime.now()))),
          ),
        );
      }

      List<ConversationData> tempList = conversationListSubject$.hasValue
          ? conversationListSubject$.value
          : [];

      if (tempList.length > 10) {
        tempList.insert(
            0,
            ConversationData(
                text: _messageSubject$.value,
                userId: myDataSubject$.value.id,
                user: User.fromLocalStorage(myDataSubject$.value),
                producer: Producer.fromLocalStorage(),
                createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                    .format(DateTime.now())));
      } else {
        tempList.insert(
            tempList.length,
            ConversationData(
                text: _messageSubject$.value,
                userId: myDataSubject$.value.id,
                user: User.fromLocalStorage(myDataSubject$.value),
                producer: Producer.fromLocalStorage(),
                createdAt: DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                    .format(DateTime.now())));
      }
      conversationListSubject$.sink.add(tempList);
      msgController.clear();

      await chatRepo.sendMessage(teamId, teamDetailSubject$.value.producer!.id!,
          _messageSubject$.value,
          throwOnError: false, errorCallBack: () {
        emit(RabbleBaseState.idle());
      });
    }
  }

  getSignature(String value) {
    List<int> key = utf8.encode('dcb7ca821d596d2a5be3');
    List<int> bytes = utf8.encode(value);

    Hmac hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    Digest digest = hmacSha256.convert(bytes);
    return digest;
  }

  void onConnectionStateChange(
      dynamic currentState, dynamic previousState) async {}

  void onEvent(PusherEvent event) {
    print('onEvent event name ${event.eventName}');
    print('onEvent event data ${event.data}');
    List<ConversationData> tempList = conversationListSubject$.hasValue
        ? conversationListSubject$.value
        : <ConversationData>[];

    dynamic temp = jsonDecode(event.data);
    if (temp['text'] != null) {
      tempList.add(ConversationData.fromJson(temp));
      conversationListSubject$.sink.add(tempList);
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print('onSubscriptionSucceeded ${channelName}');
  }

  void onSubscriptionError(String message, dynamic e) {
    print('onSubscriptionError $message');
  }

  void onDecryptionFailure(String event, String reason) {}

  void onMemberAdded(String channelName, PusherMember member) {}

  void onMemberRemoved(String channelName, PusherMember member) {}

  Future<void> fetchTeamChatList() async {
    emit(RabbleBaseState.primaryBusy());

    final chatRes = await chatRepo.fetchTeamChatList(
        throwOnError: false,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });
    if (chatRes!.statusCode == 200) {
      if (chatRes.data!.isNotEmpty) {
        teamChatListSubject$.sink.add(chatRes.data!);
      }
    }
    emit(RabbleBaseState.idle());
  }

  Future<void> fetchTeamDetail(String teamId) async {
    final chatRes = await chatRepo.fetchTeamDetail(teamId, throwOnError: false,
        errorCallBack: () {
      emit(RabbleBaseState.idle());
    });
    if (chatRes!.statusCode == 200) {
      teamDetailSubject$.sink.add(chatRes.data!);
      initPusher(chatRes.data!.name!);
    }
  }
}
