class PaymentIntentModel {
  PaymentIntentModel({
    num? statusCode,
    String? message,
    PaymentIntentData? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  PaymentIntentModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'] is List && json['message'].toString().contains(',') ? json['message'][0] : json['message'];
    _data = json['data'] != null ? PaymentIntentData.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _message;
  PaymentIntentData? _data;

  PaymentIntentModel copyWith({
    num? statusCode,
    String? message,
    PaymentIntentData? data,
  }) =>
      PaymentIntentModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  PaymentIntentData? get data => _data;

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

class PaymentIntentData {
  PaymentIntentData({
    String? paymentIntentId,
    String? clientSecret,
  }) {
    _paymentIntentId = paymentIntentId;
    _clientSecret = clientSecret;
  }

  PaymentIntentData.fromJson(dynamic json) {
    _paymentIntentId = json['paymentIntentId'];
    _clientSecret = json['clientSecret'];
  }

  String? _paymentIntentId;
  String? _clientSecret;

  PaymentIntentData copyWith({
    String? paymentIntentId,
    String? clientSecret,
  }) =>
      PaymentIntentData(
        paymentIntentId: paymentIntentId ?? _paymentIntentId,
        clientSecret: clientSecret ?? _clientSecret,
      );

  String? get paymentIntentId => _paymentIntentId;

  String? get clientSecret => _clientSecret;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['paymentIntentId'] = _paymentIntentId;
    map['clientSecret'] = _clientSecret;
    return map;
  }
}
