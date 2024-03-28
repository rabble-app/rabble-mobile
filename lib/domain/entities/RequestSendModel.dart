import '../../core/config/export.dart';

class RequestSendModel {
  RequestSendModel({
    num? statusCode,
    String? message,
    List<RequestSendData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  RequestSendModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RequestSendData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<RequestSendData>? _data;

  RequestSendModel copyWith({
    num? statusCode,
    String? message,
    List<RequestSendData>? data,
  }) =>
      RequestSendModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<RequestSendData>? get data => _data;

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

class RequestSendData {
  RequestSendData({
    String? id,
    String? teamId,
    String? userId,
    String? introduction,
    String? status,
    String? createdAt,
    String? updatedAt,
    RequestTeam? team,
    User? user,
  }) {
    _id = id;
    _teamId = teamId;
    _userId = userId;
    _introduction = introduction;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _team = team;
  }

  RequestSendData.fromJson(dynamic json) {
    _id = json['id'];
    _teamId = json['teamId'];
    _userId = json['userId'];
    _introduction = json['introduction'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _team = json['team'] != null ? RequestTeam.fromJson(json['team']) : null;
    if (json['user'] != null)
      _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? _id;
  String? _teamId;
  String? _userId;
  String? _introduction;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  RequestTeam? _team;
  User? _user;

  RequestSendData copyWith(
      {String? id,
        String? teamId,
        String? userId,
        String? introduction,
        String? status,
        String? createdAt,
        String? updatedAt,
        RequestTeam? team,
        User? user}) =>
      RequestSendData(
        id: id ?? _id,
        teamId: teamId ?? _teamId,
        userId: userId ?? _userId,
        introduction: introduction ?? _introduction,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        team: team ?? _team,
        user: user ?? _user,
      );

  String? get id => _id;

  String? get teamId => _teamId;

  String? get userId => _userId;

  String? get introduction => _introduction;

  String? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  RequestTeam? get team => _team;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['teamId'] = _teamId;
    map['userId'] = _userId;
    map['introduction'] = _introduction;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_team != null) {
      map['team'] = _team?.toJson();
    }
    return map;
  }
}

class RequestTeam {
  RequestTeam({
    String? name,
    String? postalCode,
    String? imageUrl,
  }) {
    _name = name;
    _postalCode = postalCode;
    _imageUrl = imageUrl;
  }

  RequestTeam.fromJson(dynamic json) {
    _name = json['name'];
    _postalCode = json['postalCode'];
    _imageUrl = json['imageUrl'];
  }

  String? _name;
  String? _postalCode;
  String? _imageUrl;

  RequestTeam copyWith({
    String? name,
    String? postalCode,
    String? imageUrl,
  }) =>
      RequestTeam(
        name: name ?? _name,
        postalCode: postalCode ?? _postalCode,
        imageUrl: imageUrl ?? _imageUrl,
      );

  String? get name => _name;

  String? get postalCode => _postalCode;

  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['postalCode'] = _postalCode;
    map['imageUrl'] = _imageUrl;
    return map;
  }
}
