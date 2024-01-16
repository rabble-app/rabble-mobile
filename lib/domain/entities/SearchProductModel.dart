import 'package:rabble/domain/entities/product_model.dart';

class SearchProductModel {
  SearchProductModel({
    num? statusCode,
    String? message,
    List<dynamic>? data,}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  SearchProductModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data =  json['data'];
    }
  }

  num? _statusCode;
  String?  _message;
  List<dynamic>? _data;

  SearchProductModel copyWith({ num? statusCode,
    String? message,
    List<ProductDetail>? data,
  }) =>
      SearchProductModel(statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<dynamic>? get data => _data;

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

