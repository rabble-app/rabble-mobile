class PusherModel {
  PusherModel({
    num? statusCode,
    String? message,
    PusherData? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  PusherModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? PusherData.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _message;
  PusherData? _data;

  PusherModel copyWith({
    num? statusCode,
    String? message,
    PusherData? data,
  }) =>
      PusherModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  PusherData? get data => _data;

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

class PusherData {
  PusherData({
    String? auth,
    String? userData,
  }) {
    _auth = auth;
    _userData = userData;
  }

  PusherData.fromJson(dynamic json) {
    _auth = json['auth'];
    _userData = json['user_data'];
  }

  String? _auth;
  String? _userData;

  PusherData copyWith({
    String? auth,
    String? userData,
  }) =>
      PusherData(
        auth: auth ?? _auth,
        userData: userData ?? _userData,
      );

  String? get auth => _auth;

  String? get userData => _userData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['auth'] = _auth;
    map['user_data'] = _userData;
    return map;
  }
}
