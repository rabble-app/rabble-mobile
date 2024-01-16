class CheckModel {
  CheckModel({
    num? statusCode,
    String? message,
    bool? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  CheckModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'];
  }

  num? _statusCode;
  String? _message;
  bool? _data;

  CheckModel copyWith({
    num? statusCode,
    String? message,
    bool? data,
  }) =>
      CheckModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  bool? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }
}
