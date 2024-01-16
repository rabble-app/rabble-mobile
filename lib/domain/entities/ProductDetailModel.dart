import 'product_model.dart';

class ProductDetailModel {
  ProductDetailModel({
    num? statusCode,
    String? message,
    ProductDetail? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  ProductDetailModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? ProductDetail.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _message;
  ProductDetail? _data;

  ProductDetailModel copyWith({
    num? statusCode,
    String? message,
    ProductDetail? data,
  }) =>
      ProductDetailModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  ProductDetail? get data => _data;

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
