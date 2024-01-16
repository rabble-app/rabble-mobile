/// statusCode : 200
/// message : "Notification returned successfully"
/// data : [{"id":"4794e2a1-b6dc-48bb-afbf-7fcfb47c7eb9","orderId":null,"userId":"1a505a08-66c3-4925-b7a7-73e841409ace","teamId":null,"producerId":null,"title":"Payment Success","text":"Your Payment was successful","isRead":false,"createdAt":"2023-06-21T11:46:23.540Z","updatedAt":"2023-06-21T11:46:23.540Z"},{"id":"7b42976c-432f-492c-95e9-d5482899fe8e","orderId":null,"userId":"1a505a08-66c3-4925-b7a7-73e841409ace","teamId":null,"producerId":null,"title":"Payment Failure","text":"Your payment failed","isRead":false,"createdAt":"2023-06-21T11:45:55.361Z","updatedAt":"2023-06-21T11:45:55.361Z"}]

class NotificationModel {
  NotificationModel({
    num? statusCode,
    String? message,
    List<NotificationData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  NotificationModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(NotificationData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<NotificationData>? _data;

  NotificationModel copyWith({
    num? statusCode,
    String? message,
    List<NotificationData>? data,
  }) =>
      NotificationModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<NotificationData>? get data => _data;

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

/// id : "4794e2a1-b6dc-48bb-afbf-7fcfb47c7eb9"
/// orderId : null
/// userId : "1a505a08-66c3-4925-b7a7-73e841409ace"
/// teamId : null
/// producerId : null
/// title : "Payment Success"
/// text : "Your Payment was successful"
/// isRead : false
/// createdAt : "2023-06-21T11:46:23.540Z"
/// updatedAt : "2023-06-21T11:46:23.540Z"

class NotificationData {
  NotificationData({
    String? id,
    dynamic orderId,
    String? userId,
    dynamic teamId,
    dynamic producerId,
    String? title,
    String? text,
    bool? isRead,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _orderId = orderId;
    _userId = userId;
    _teamId = teamId;
    _producerId = producerId;
    _title = title;
    _text = text;
    _isRead = isRead;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  NotificationData.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['orderId'];
    _userId = json['userId'];
    _teamId = json['teamId'];
    _producerId = json['producerId'];
    _title = json['title'];
    _text = json['text'];
    _isRead = json['isRead'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  dynamic _orderId;
  String? _userId;
  dynamic _teamId;
  dynamic _producerId;
  String? _title;
  String? _text;
  bool? _isRead;
  String? _createdAt;
  String? _updatedAt;

  NotificationData copyWith({
    String? id,
    dynamic orderId,
    String? userId,
    dynamic teamId,
    dynamic producerId,
    String? title,
    String? text,
    bool? isRead,
    String? createdAt,
    String? updatedAt,
  }) =>
      NotificationData(
        id: id ?? _id,
        orderId: orderId ?? _orderId,
        userId: userId ?? _userId,
        teamId: teamId ?? _teamId,
        producerId: producerId ?? _producerId,
        title: title ?? _title,
        text: text ?? _text,
        isRead: isRead ?? _isRead,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  dynamic get orderId => _orderId;

  String? get userId => _userId;

  dynamic get teamId => _teamId;

  dynamic get producerId => _producerId;

  String? get title => _title;

  String? get text => _text;

  bool? get isRead => _isRead;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['orderId'] = _orderId;
    map['userId'] = _userId;
    map['teamId'] = _teamId;
    map['producerId'] = _producerId;
    map['title'] = _title;
    map['text'] = _text;
    map['isRead'] = _isRead;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
