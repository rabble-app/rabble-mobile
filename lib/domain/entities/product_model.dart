import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/PartionedProductsData.dart';
import 'package:rabble/feature/product/product_detail/portioned_product_sheet.dart';

class ProductModel {
  ProductModel({
    num? statusCode,
    String? message,
    List<ProductData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  ProductModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProductData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<ProductData>? _data;

  ProductModel copyWith({
    num? statusCode,
    String? message,
    List<ProductData>? data,
  }) =>
      ProductModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<ProductData>? get data => _data;

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

class ProductData {
  ProductData({
    String? id,
    String? name,
    String? createdAt,
    String? updatedAt,
    List<ProductDetail>? products,
  }) {
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _products = products;
  }

  ProductData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(ProductDetail.fromJson(v));
      });
    }
  }

  String? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
  List<ProductDetail>? _products;

  ProductData copyWith({
    String? id,
    String? name,
    String? createdAt,
    String? updatedAt,
    List<ProductDetail>? products,
  }) =>
      ProductData(
        id: id ?? _id,
        name: name ?? _name,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        products: products ?? _products,
      );

  String? get id => _id;

  String? get name => _name;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<ProductDetail>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProductDetail {
  ProductDetail({
    String? id,
    String? name,
    dynamic imageUrl,
    String? description,
    String? producerId,
    num? price,
    num? rrp,
    String? status,
    String? createdAt,
    String? updatedAt,
    ProducerDetail? producer,
    String? type,
    List<PartionedProducts>? partionedProducts,
    int? thresholdQuantity,
    String? orderUnit,
    String? orderSubUnit,
    int? unitsPerOrder,
    String? unitsOfMeasure,
  }) {
    _id = id;
    _name = name;
    _imageUrl = imageUrl;
    _description = description;
    _producerId = producerId;
    _price = price;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _thresholdQuantity = thresholdQuantity;
    _type = type;
    _partionedProducts = partionedProducts;
    _orderUnit = orderUnit;
    _orderSubUnit = orderSubUnit;
    _unitsPerOrder = unitsPerOrder;
    _unitsOfMeasure = unitsOfMeasure;
    _producer = producer;
    _rrp = rrp;
  }

  ProductDetail.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imageUrl = json['imageUrl'];
    _description = json['description'];
    _producerId = json['producerId'];
    _price = num.tryParse(json['price']);
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _qty = 0;


    _type = json['type'] ?? '';
    if (json['type'] == 'PORTIONED_SINGLE_PRODUCT') {
      if (json['partionedProducts'] != null) {
        _partionedProducts = [];
        json['partionedProducts'].forEach((v) {
          _partionedProducts!.add(PartionedProducts.fromJson(v));
        });
      }
    }
    if (json['producer'] != null) {
      _producer = ProducerDetail.fromJson(json['producer']);
    }

    if (json['orderUnit'] != null) {
      _orderUnit = json['orderUnit'];
    }

    if (json['subUnit'] != null) {
      _orderSubUnit = json['subUnit'];
    }


    if (json['measuresPerSubUnit'] != null) {
      _unitsPerOrder = json['measuresPerSubUnit'];
    }
    if (json['rrp'] != null) {
      _rrp = num.tryParse(json['rrp']);

    }

    if (json['unitsOfMeasurePerSubUnit'] != null) {
      _unitsOfMeasure = json['unitsOfMeasurePerSubUnit'];
    }

    if (_partionedProducts != null && _partionedProducts!.isNotEmpty) {
      if (_partionedProducts!.first.accumulator != null) {

        int tempThresholdQuantity =
            json['quantityOfSubUnitPerOrder'] - _partionedProducts!.first.accumulator!.toInt();



        _thresholdQuantity = tempThresholdQuantity;
        _totalThresholdQuantity = json['quantityOfSubUnitPerOrder'] ?? 0;

      } else {
        _thresholdQuantity = json['quantityOfSubUnitPerOrder'] ?? 0;
        _totalThresholdQuantity = json['quantityOfSubUnitPerOrder'] ?? 0;

      }
    } else {
      _thresholdQuantity = json['quantityOfSubUnitPerOrder'] ?? 0;
      _totalThresholdQuantity = json['quantityOfSubUnitPerOrder'] ?? 0;

    }

  }

  ProductDetail.fromDb(dynamic json) {
    _id = json['productId'];
    _producerId = json['producerId'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _qty = json['quantity'] ?? 0;
    _producerName = json['producerName'];
    _type = json['type'] ?? '';
    _thresholdQuantity = json['thresholdQuantity'] ?? 0;
    _unitsPerOrder = json['unitPerOrder'] ?? 0;
    _orderSubUnit = json['orderSubUnit'] ?? '';
    _orderUnit = json['orderUnit'] ?? '';
    _unitsOfMeasure = json['unitsOfMeasure'] ?? '';
    _totalThresholdQuantity = json['totalThresholdQuantity'] ?? 0;

  }

  ProductDetail.fromDbWithId(dynamic json, String orderId, String userId) {
    orderId = orderId;
    userId = userId;
    _id = json['productId'];
    _price = json['price'];
    _qty = json['quantity'] ?? 0;
    _producerName = json['producerName'];
    _type = json['type'] ?? '';
    _thresholdQuantity = json['thresholdQuantity'] ?? 0;
    _unitsPerOrder = json['unitPerOrder'] ?? 0;
    _orderSubUnit = json['orderSubUnit'] ?? '';
    _orderUnit = json['orderUnit'] ?? '';
    _unitsOfMeasure = json['unitsOfMeasure'] ?? '';
    _totalThresholdQuantity = json['totalThresholdQuantity']  ?? 0;
  }

  String? _id;
  String? _name;
  dynamic _imageUrl;
  String? _description;
  String? _producerId;
  num? _price;
  num? _rrp;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  int? _qty;
  String? orderId;
  String? userId;
  String? _producerName;
  int? _thresholdQuantity;
  int? _totalThresholdQuantity;
  String? _type;
  List<PartionedProducts>? _partionedProducts;


  int? get totalThresholdQuantity => _totalThresholdQuantity;
  String? _orderUnit;
  String? _orderSubUnit;
  int? _unitsPerOrder;
  String? _unitsOfMeasure;
  ProducerDetail? _producer;

  ProducerDetail? get producer => _producer;

  List<PartionedProducts>? get partionedProducts => _partionedProducts;

  set partionedProducts(List<PartionedProducts>? value) {
    _partionedProducts = value;
  }

  int? get qty => _qty;

  set qty(int? value) {
    _qty = value;
  }

  String? get producerName => _producerName;

  String? get orderUnit => _orderUnit;

  set producerName(String? value) {
    _producerName = value;
  }

  ProductDetail copyWith({
    String? id,
    String? name,
    dynamic imageUrl,
    String? description,
    String? producerId,
    num? price,
    num? rrp,
    String? status,
    String? createdAt,
    String? updatedAt,
    int? thresholdQuantity,
    ProducerDetail? producer,
    List<PartionedProducts>? partionedProducts,
    String? type,
  }) =>
      ProductDetail(
          id: id ?? _id,
          name: name ?? _name,
          imageUrl: imageUrl ?? _imageUrl,
          description: description ?? _description,
          producerId: producerId ?? _producerId,
          price: price ?? _price,
          rrp: rrp ?? _rrp,
          status: status ?? _status,
          createdAt: createdAt ?? _createdAt,
          updatedAt: updatedAt ?? _updatedAt,
          thresholdQuantity: thresholdQuantity ?? _thresholdQuantity,
          type: type ?? _type,
          producer: producer ?? _producer,
          partionedProducts: partionedProducts ?? _partionedProducts);

  String? get id => _id;


  num? get rrp => _rrp;

  String? get name => _name;

  dynamic get imageUrl => _imageUrl;

  String? get description => _description;

  String? get producerId => _producerId;

  num? get price => _price;

  String? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  int? get thresholdQuantity => _thresholdQuantity;


  set thresholdQuantity(int? value) {
    _thresholdQuantity = value;
  }

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _id;
    map['producerId'] = _producerId;
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    map['quantity'] = 1;
    map['producerName'] = producerName ?? '';
    map['type'] = type ?? '';
    map['thresholdQuantity'] = thresholdQuantity ?? 0;
    map['unitPerOrder'] = unitsPerOrder ?? 0;
    map['orderSubUnit'] = orderSubUnit ?? '';
    map['orderUnit'] = orderUnit ?? '';
    map['unitsOfMeasure'] = unitsOfMeasure ?? '';
    map['totalThresholdQuantity'] = totalThresholdQuantity ?? 0;

    return map;
  }

  String? get orderSubUnit => _orderSubUnit;

  int? get unitsPerOrder => _unitsPerOrder;

  String? get unitsOfMeasure => _unitsOfMeasure;
}
