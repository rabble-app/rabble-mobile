import 'package:rabble/config/export.dart';

class MoreProductModel {
  MoreProductModel({
    num? statusCode,
    String? message,
    List<ProductDetail>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  MoreProductModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProductDetail.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<ProductDetail>? _data;

  MoreProductModel copyWith({
    num? statusCode,
    String? message,
    List<ProductDetail>? data,
  }) =>
      MoreProductModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<ProductDetail>? get data => _data;

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


