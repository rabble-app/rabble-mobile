import 'package:rabble/domain/entities/product_model.dart';

class UserBasketModel {
  UserBasketModel({
    num? statusCode,
    String? message,
    List<UserBasketData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  UserBasketModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(UserBasketData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<UserBasketData>? _data;

  UserBasketModel copyWith({
    num? statusCode,
    String? message,
    List<UserBasketData>? data,
  }) =>
      UserBasketModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<UserBasketData>? get data => _data;

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

class UserBasketData {
  UserBasketData({
    String? id,
    String? teamId,
    String? userId,
    String? productId,
    num? quantity,
    num? price,
    String? createdAt,
    String? updatedAt,
    ProductDetail? product,
  }) {
    _id = id;
    _teamId = teamId;
    _userId = userId;
    _productId = productId;
    _quantity = quantity;
    _price = price;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _product = product;
  }

  UserBasketData.fromJson(dynamic json) {
    _id = json['id'];
    _teamId = json['teamId'];
    _userId = json['userId'];
    _productId = json['productId'];
    _quantity = json['quantity'];
    _price = json['price'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _product = json['product'] != null
        ? ProductDetail.fromJson(json['product'])
        : null;
  }

  String? _id;
  String? _teamId;
  String? _userId;
  String? _productId;
  num? _quantity;
  num? _price;
  String? _createdAt;
  String? _updatedAt;
  ProductDetail? _product;

  bool? _update = false;
  bool? _deacreased = false;

  bool? get deacreased => _deacreased;

  set deacreased(bool? value) {
    _deacreased = value;
  }

  bool? get update => _update;

  set update(bool? value) {
    _update = value;
  }

  UserBasketData copyWith({
    String? id,
    String? teamId,
    String? userId,
    String? productId,
    num? quantity,
    num? price,
    String? createdAt,
    String? updatedAt,
    ProductDetail? product,
  }) =>
      UserBasketData(
        id: id ?? _id,
        teamId: teamId ?? _teamId,
        userId: userId ?? _userId,
        productId: productId ?? _productId,
        quantity: quantity ?? _quantity,
        price: price ?? _price,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        product: product ?? _product,
      );

  String? get id => _id;

  String? get teamId => _teamId;

  String? get userId => _userId;

  String? get productId => _productId;

  num? get quantity => _quantity;

  num? get price => _price;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  ProductDetail? get product => _product;

  set quantity(num? value) {
    _quantity = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['teamId'] = _teamId;
    map['userId'] = _userId;
    map['productId'] = _productId;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }
}
