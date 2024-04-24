import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/ConversationModel.dart';

class TeamChatListModel {
  TeamChatListModel({
    num? statusCode,
    String? message,
    List<TeamChatData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  TeamChatListModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TeamChatData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<TeamChatData>? _data;

  TeamChatListModel copyWith({
    num? statusCode,
    String? message,
    List<TeamChatData>? data,
  }) =>
      TeamChatListModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<TeamChatData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TeamChatData {
  TeamChatData({
    ChatTeam? team,
  }) {
    _team = team;
  }

  TeamChatData.fromJson(dynamic json) {
    _team = json['team'] != null ? ChatTeam.fromJson(json['team']) : null;
  }

  ChatTeam? _team;

  TeamChatData copyWith({
    ChatTeam? team,
  }) =>
      TeamChatData(
        team: team ?? _team,
      );

  ChatTeam? get team => _team;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_team != null) {
      map['team'] = _team?.toJson();
    }
    return map;
  }
}

class ChatTeam {
  ChatTeam({
    String? id,
    String? name,
    String? imageUrl,
    List<ConversationData>? chats,
  }) {
    _id = id;
    _name = name;
    _imageUrl = imageUrl;
    _chats = chats;
  }

  ChatTeam.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imageUrl = json['imageUrl'];
    if (json['chats'] != null) {
      _chats = [];
      json['chats'].forEach((v) {
        _chats?.add(ConversationData.fromJson(v));
      });
    }
  }

  String? _id;
  String? _name;
  String? _imageUrl;
  List<ConversationData>? _chats;

  ChatTeam copyWith({
    String? id,
    String? name,
    String? imageUrl,
    List<ConversationData>? chats,
  }) =>
      ChatTeam(
        id: id ?? _id,
        name: name ?? _name,
        imageUrl: imageUrl ?? _imageUrl,
        chats: chats ?? _chats,
      );

  String? get id => _id;

  String? get name => _name;

  String? get imageUrl => _imageUrl;

  List<ConversationData>? get chats => _chats;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['imageUrl'] = _imageUrl;
    if (_chats != null) {
      map['chats'] = _chats?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
