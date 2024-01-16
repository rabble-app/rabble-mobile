class DeadlineModel {
  DeadlineModel({
    num? statusCode,
    String? message,
    Deadline? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  DeadlineModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? Deadline.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _message;
  Deadline? _data;

  DeadlineModel copyWith({
    num? statusCode,
    String? message,
    Deadline? data,
  }) =>
      DeadlineModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  Deadline? get data => _data;

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

class Deadline {
  Deadline({
    String? deadline,
    String? id,
  }) {
    _deadline = deadline;
    _id = id;
  }

  Deadline.fromJson(dynamic json) {
    _deadline = json['deadline'];
    _id = json['id'];
  }

  String? _deadline;
  String? _id;

  Deadline copyWith({
    String? deadline,
    String? id,
  }) =>
      Deadline(
        deadline: deadline ?? _deadline,
        id: id ?? _id,
      );

  String? get deadline => _deadline;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['deadline'] = _deadline;
    map['id'] = _id;
    return map;
  }
}
