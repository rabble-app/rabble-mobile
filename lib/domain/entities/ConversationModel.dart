import '../../config/export.dart';
import 'TeamModel.dart';

class ConversationModel {
  ConversationModel({
    num? statusCode,
    String? message,
    List<ConversationData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  ConversationModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ConversationData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<ConversationData>? _data;

  ConversationModel copyWith({
    num? statusCode,
    String? message,
    List<ConversationData>? data,
  }) =>
      ConversationModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<ConversationData>? get data => _data;

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

class ConversationData {
  ConversationData({
    String? text,
    String? userId,
    User? user,
    Producer? producer,
    String? createdAt,
  }) {
    _text = text;
    _user = user;
    _userId = userId;
    _producer = producer;
    _createdAt = createdAt;
  }

  ConversationData.fromJson(dynamic json) {
    _text = json['text'] ?? '';
    _userId = json['userId'] ?? '';
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _producer =
        json['producer'] != null ? Producer.fromJson(json['producer']) : null;
    _createdAt = json['createdAt'];
  }

  String? _text;
  String? _userId;
  User? _user;
  Producer? _producer;
  String? _createdAt;

  ConversationData copyWith({
    String? text,
    String? userId,
    User? user,
    Producer? producer,
    String? createdAt,
  }) =>
      ConversationData(
        text: text ?? _text,
        user: user ?? _user,
        userId: userId ?? _userId,
        producer: producer ?? _producer,
        createdAt: createdAt ?? _createdAt,
      );

  String? get text => _text;

  String? get userId => _userId;

  User? get user => _user;

  Producer? get producer => _producer;

  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['userId'] = _userId;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_producer != null) {
      map['producer'] = _producer?.toJson();
    }
    map['createdAt'] = _createdAt;
    return map;
  }

  @override
  String toString() {
    return 'ConversationData{_text: $_text}';
  }
}
