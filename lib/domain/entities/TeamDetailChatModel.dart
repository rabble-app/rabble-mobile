import 'TeamModel.dart';
import 'UserTeamModel.dart';

class TeamDetailChatModel {
  TeamDetailChatModel({
    num? statusCode,
    String? message,
    TeamDetailChatData? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  TeamDetailChatModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? TeamDetailChatData.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _message;
  TeamDetailChatData? _data;

  TeamDetailChatModel copyWith({
    num? statusCode,
    String? message,
    TeamDetailChatData? data,
  }) =>
      TeamDetailChatModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  TeamDetailChatData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class TeamDetailChatData {
  TeamDetailChatData({
    String? name,
    String? hostId,
    Producer? producer,
    List<ChatMembers>? members,
  }) {
    _name = name;
    _hostId = hostId;
    _producer = producer;
    _members = members;
  }

  TeamDetailChatData.fromJson(dynamic json) {
    _name = json['name'];
    _hostId = json['hostId'];
    _producer =
        json['producer'] != null ? Producer.fromJson(json['producer']) : null;
    if (json['members'] != null) {
      _members = [];
      json['members'].forEach((v) {
        _members?.add(ChatMembers.fromJson(v));
      });
    }
  }

  String? _name;
  String? _hostId;
  Producer? _producer;
  List<ChatMembers>? _members;

  TeamDetailChatData copyWith({
    String? name,
    String? hostId,
    Producer? producer,
    List<ChatMembers>? members,
  }) =>
      TeamDetailChatData(
        name: name ?? _name,
        hostId: hostId ?? _hostId,
        producer: producer ?? _producer,
        members: members ?? _members,
      );

  String? get name => _name;


  String? get hostId => _hostId;

  Producer? get producer => _producer;

  List<ChatMembers>? get members => _members;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    if (_producer != null) {
      map['producer'] = _producer?.toJson();
    }
    if (_members != null) {
      map['members'] = _members?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ChatMembers {
  ChatMembers({
    User? user,
  }) {
    _user = user;
  }

  ChatMembers.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  User? _user;

  ChatMembers copyWith({
    User? user,
  }) =>
      ChatMembers(
        user: user ?? _user,
      );

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}
