import 'PartionedProductsData.dart';

class OrderModel {
  OrderModel({
    num? statusCode,
    String? message,
    CurrentOrderData? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  OrderModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data =
        json['data'] != null ? CurrentOrderData.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _message;
  CurrentOrderData? _data;

  OrderModel copyWith({
    num? statusCode,
    String? message,
    CurrentOrderData? data,
  }) =>
      OrderModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  CurrentOrderData? get data => _data;

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

class CurrentOrderData {
  CurrentOrderData({
    String? id,
    String? teamId,
    String? status,
    num? minimumTreshold,
    num? accumulatedAmount,
    String? deadline,
    String? createdAt,
    String? updatedAt,
    String? deliveryDate,
    List<Basket>? basket,
    List<Payments>? payments,
    List<PartionedProducts>? partionedProducts,

  }) {
    _id = id;
    _teamId = teamId;
    _status = status;
    _minimumTreshold = minimumTreshold;
    _accumulatedAmount = accumulatedAmount;
    _deadline = deadline;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _basket = basket;
    _payments = payments;
    _deliveryDate = deliveryDate;
    _partionedProducts = partionedProducts;

  }

  CurrentOrderData.fromJson(dynamic json) {
    _id = json['id'];
    _teamId = json['teamId'];
    _status = json['status'];
    _minimumTreshold = json['minimumTreshold'];
    _accumulatedAmount = json['accumulatedAmount'];
    _deadline = json['deadline'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _deliveryDate = json['deliveryDate'];
    if (json['basket'] != null) {
      _basket = [];
      json['basket'].forEach((v) {
        _basket?.add(Basket.fromJson(v));
      });
    }
    if (json['payments'] != null) {
      _payments = [];
      json['payments'].forEach((v) {
        _payments?.add(Payments.fromJson(v));
      });
    }

    if (json['partionedProducts'] != null) {
      _partionedProducts = [];
      json['partionedProducts'].forEach((v) {
        _partionedProducts!.add(PartionedProducts.fromJson(v));
      });
    }
  }

  String? _id;
  String? _teamId;
  String? _status;
  num? _minimumTreshold;
  num? _accumulatedAmount;
  String? _deadline;
  String? _deliveryDate;
  String? _createdAt;
  String? _updatedAt;
  List<Basket>? _basket;
  List<Payments>? _payments;
  List<PartionedProducts>? _partionedProducts;

  CurrentOrderData copyWith({
    String? id,
    String? teamId,
    String? status,
    num? minimumTreshold,
    num? accumulatedAmount,
    String? deadline,
    String? createdAt,
    String? deliveryDate,
    String? updatedAt,
    List<Basket>? basket,
    List<Payments>? payments,
    List<PartionedProducts>? partionedProducts,

  }) =>
      CurrentOrderData(
        id: id ?? _id,
        teamId: teamId ?? _teamId,
        status: status ?? _status,
        minimumTreshold: minimumTreshold ?? _minimumTreshold,
        accumulatedAmount: accumulatedAmount ?? _accumulatedAmount,
        deadline: deadline ?? _deadline,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        basket: basket ?? _basket,
        payments: payments ?? _payments,
        deliveryDate: deliveryDate ?? _deliveryDate,
          partionedProducts: partionedProducts ?? _partionedProducts

      );

  String? get id => _id;

  List<PartionedProducts>? get partionedProducts => _partionedProducts;

  String? get teamId => _teamId;

  String? get status => _status;

  num? get minimumTreshold => _minimumTreshold;

  num? get accumulatedAmount => _accumulatedAmount;

  String? get deadline => _deadline;

  String? get createdAt => _createdAt;

  String? get deliveryDate => _deliveryDate;

  String? get updatedAt => _updatedAt;

  List<Basket>? get basket => _basket;

  List<Payments>? get payments => _payments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['teamId'] = _teamId;
    map['status'] = _status;
    map['minimumTreshold'] = _minimumTreshold;
    map['accumulatedAmount'] = _accumulatedAmount;
    map['deadline'] = _deadline;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['deliveryDate'] = _deliveryDate;
    if (_basket != null) {
      map['basket'] = _basket?.map((v) => v.toJson()).toList();
    }
    if (_payments != null) {
      map['payments'] = _payments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'CurrentOrderData{_id: $_id, _teamId: $_teamId, _status: $_status, _deliveryDate: $_deliveryDate}';
  }
}

class Payments {
  Payments({
    String? id,
    String? orderId,
    String? userId,
    num? amount,
    String? paymentIntentId,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _orderId = orderId;
    _userId = userId;
    _amount = amount;
    _paymentIntentId = paymentIntentId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Payments.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['orderId'];
    _userId = json['userId'];
    _amount = json['amount'];
    _paymentIntentId = json['paymentIntentId'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _orderId;
  String? _userId;
  num? _amount;
  String? _paymentIntentId;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  Payments copyWith({
    String? id,
    String? orderId,
    String? userId,
    num? amount,
    String? paymentIntentId,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      Payments(
        id: id ?? _id,
        orderId: orderId ?? _orderId,
        userId: userId ?? _userId,
        amount: amount ?? _amount,
        paymentIntentId: paymentIntentId ?? _paymentIntentId,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  String? get orderId => _orderId;

  String? get userId => _userId;

  num? get amount => _amount;

  String? get paymentIntentId => _paymentIntentId;

  String? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['orderId'] = _orderId;
    map['userId'] = _userId;
    map['amount'] = _amount;
    map['paymentIntentId'] = _paymentIntentId;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

class Basket {
  Basket({
    String? id,
    String? orderId,
    String? userId,
    String? productId,
    num? quantity,
    num? price,
    String? createdAt,
    String? updatedAt,
    Product? product,
  }) {
    _id = id;
    _orderId = orderId;
    _userId = userId;
    _productId = productId;
    _quantity = quantity;
    _price = price;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _product = product;
  }

  Basket.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['orderId'];
    _userId = json['userId'];
    _productId = json['productId'];
    _quantity = json['quantity'];
    _price = json['price'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  String? _id;
  String? _orderId;
  String? _userId;
  String? _productId;
  num? _quantity;
  num? _price;
  String? _createdAt;
  String? _updatedAt;
  Product? _product;

  Basket copyWith({
    String? id,
    String? orderId,
    String? userId,
    String? productId,
    num? quantity,
    num? price,
    String? createdAt,
    String? updatedAt,
    Product? product,
  }) =>
      Basket(
        id: id ?? _id,
        orderId: orderId ?? _orderId,
        userId: userId ?? _userId,
        productId: productId ?? _productId,
        quantity: quantity ?? _quantity,
        price: price ?? _price,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        product: product ?? _product,
      );

  String? get id => _id;

  String? get orderId => _orderId;

  String? get userId => _userId;

  String? get productId => _productId;

  num? get quantity => _quantity;

  num? get price => _price;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Product? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['orderId'] = _orderId;
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

  set quantity(num? value) {
    _quantity = value;
  }

  @override
  String toString() {
    return 'Basket{_id: $_id, _quantity: $_quantity, _price: $_price}';
  }
}

class Product {
  Product({
    String? name,
  }) {
    _name = name;
  }

  Product.fromJson(dynamic json) {
    _name = json['name'];
  }

  String? _name;

  Product copyWith({
    String? name,
  }) =>
      Product(
        name: name ?? _name,
      );

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }
}
