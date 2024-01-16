class RequestModel {
  RequestModel({
    num? statusCode,
    String? message,
    List<RequestData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  RequestModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RequestData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<RequestData>? _data;

  RequestModel copyWith({
    num? statusCode,
    String? message,
    List<RequestData>? data,
  }) =>
      RequestModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<RequestData>? get data => _data;

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

class RequestData {
  RequestData({
    String? id,
    String? teamId,
    String? userId,
    String? introduction,
    String? status,
    String? createdAt,
    String? updatedAt,
    RequestTeam? team,
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

  RequestData.fromJson(dynamic json) {
    _id = json['id'];
    _teamId = json['teamId'];
    _userId = json['userId'];
    _introduction = json['introduction'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _team = json['team'] != null ? RequestTeam.fromJson(json['team']) : null;
  }

  String? _id;
  String? _teamId;
  String? _userId;
  String? _introduction;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  RequestTeam? _team;

  RequestData copyWith({
    String? id,
    String? teamId,
    String? userId,
    String? introduction,
    String? status,
    String? createdAt,
    String? updatedAt,
    RequestTeam? team,
  }) =>
      RequestData(
        id: id ?? _id,
        teamId: teamId ?? _teamId,
        userId: userId ?? _userId,
        introduction: introduction ?? _introduction,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        team: team ?? _team,
      );

  String? get id => _id;

  String? get teamId => _teamId;

  String? get userId => _userId;

  String? get introduction => _introduction;

  String? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  RequestTeam? get team => _team;

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
  }) {
    _name = name;
    _postalCode = postalCode;
  }

  RequestTeam.fromJson(dynamic json) {
    _name = json['name'];
    _postalCode = json['postalCode'];
  }

  String? _name;
  String? _postalCode;

  RequestTeam copyWith({
    String? name,
    String? postalCode,
  }) =>
      RequestTeam(
        name: name ?? _name,
        postalCode: postalCode ?? _postalCode,
      );

  String? get name => _name;

  String? get postalCode => _postalCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['postalCode'] = _postalCode;
    return map;
  }
}
