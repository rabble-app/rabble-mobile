import 'OrderModel.dart';
import 'UserTeamModel.dart';

class OrderHistoryModel {
  OrderHistoryModel({
    num? statusCode,
    String? message,
    List<OrderHistoryData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  OrderHistoryModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(OrderHistoryData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<OrderHistoryData>? _data;

  OrderHistoryModel copyWith({
    num? statusCode,
    String? message,
    List<OrderHistoryData>? data,
  }) =>
      OrderHistoryModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<OrderHistoryData>? get data => _data;

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

class OrderHistoryData {
  OrderHistoryData({
    String? id,
    String? orderId,
    String? userId,
    num? amount,
    String? paymentIntentId,
    String? status,
    String? createdAt,
    String? updatedAt,
    Order? order,
  }) {
    _id = id;
    _orderId = orderId;
    _userId = userId;
    _amount = amount;
    _paymentIntentId = paymentIntentId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _order = order;
  }

  OrderHistoryData.fromJson(dynamic json) {
    _id = json['id'];
    _orderId = json['orderId'];
    _userId = json['userId'];
    _amount = num.parse(json['amount'])??0;
    _paymentIntentId = json['paymentIntentId'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  String? _id;
  String? _orderId;
  String? _userId;
  num? _amount;
  String? _paymentIntentId;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  Order? _order;

  OrderHistoryData copyWith({
    String? id,
    String? orderId,
    String? userId,
    num? amount,
    String? paymentIntentId,
    String? status,
    String? createdAt,
    String? updatedAt,
    Order? order,
  }) =>
      OrderHistoryData(
        id: id ?? _id,
        orderId: orderId ?? _orderId,
        userId: userId ?? _userId,
        amount: amount ?? _amount,
        paymentIntentId: paymentIntentId ?? _paymentIntentId,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        order: order ?? _order,
      );

  String? get id => _id;

  String? get orderId => _orderId;

  String? get userId => _userId;

  num? get amount => _amount;

  String? get paymentIntentId => _paymentIntentId;

  String? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Order? get order => _order;

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
    if (_order != null) {
      map['order'] = _order?.toJson();
    }
    return map;
  }
}

class Order {
  Order({
    String? id,
    String? teamId,
    String? status,
    num? minimumTreshold,
    num? accumulatedAmount,
    String? deadline,
    dynamic lastNudge,
    dynamic deliveryDate,
    String? createdAt,
    String? updatedAt,
    List<Basket>? basket,
    Team? team,
  }) {
    _id = id;
    _teamId = teamId;
    _status = status;
    _minimumTreshold = minimumTreshold;
    _accumulatedAmount = accumulatedAmount;
    _deadline = deadline;
    _lastNudge = lastNudge;
    _deliveryDate = deliveryDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _basket = basket;
    _team = team;
  }

  Order.fromJson(dynamic json) {
    _id = json['id'];
    _teamId = json['teamId'];
    _status = json['status'];
    _minimumTreshold = num.parse(json['minimumTreshold'])??0;
    _accumulatedAmount = num.parse(json['accumulatedAmount'])??0;
    _deadline = json['deadline'];
    _lastNudge = json['lastNudge'];
    _deliveryDate = json['deliveryDate'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    if (json['basket'] != null) {
      _basket = [];
      json['basket'].forEach((v) {
        _basket?.add(Basket.fromJson(v));
      });
    }
    _team = json['team'] != null ? Team.fromJson(json['team']) : null;
  }

  String? _id;
  String? _teamId;
  String? _status;
  num? _minimumTreshold;
  num? _accumulatedAmount;
  String? _deadline;
  dynamic _lastNudge;
  dynamic _deliveryDate;
  String? _createdAt;
  String? _updatedAt;
  List<Basket>? _basket;
  Team? _team;

  Order copyWith({
    String? id,
    String? teamId,
    String? status,
    num? minimumTreshold,
    num? accumulatedAmount,
    String? deadline,
    dynamic lastNudge,
    dynamic deliveryDate,
    String? createdAt,
    String? updatedAt,
    List<Basket>? basket,
    Team? team,
  }) =>
      Order(
        id: id ?? _id,
        teamId: teamId ?? _teamId,
        status: status ?? _status,
        minimumTreshold: minimumTreshold ?? _minimumTreshold,
        accumulatedAmount: accumulatedAmount ?? _accumulatedAmount,
        deadline: deadline ?? _deadline,
        lastNudge: lastNudge ?? _lastNudge,
        deliveryDate: deliveryDate ?? _deliveryDate,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        basket: basket ?? _basket,
        team: team ?? _team,
      );

  String? get id => _id;

  String? get teamId => _teamId;

  String? get status => _status;

  num? get minimumTreshold => _minimumTreshold;

  num? get accumulatedAmount => _accumulatedAmount;

  String? get deadline => _deadline;

  dynamic get lastNudge => _lastNudge;

  dynamic get deliveryDate => _deliveryDate;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<Basket>? get basket => _basket;

  Team? get team => _team;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['teamId'] = _teamId;
    map['status'] = _status;
    map['minimumTreshold'] = _minimumTreshold;
    map['accumulatedAmount'] = _accumulatedAmount;
    map['deadline'] = _deadline;
    map['lastNudge'] = _lastNudge;
    map['deliveryDate'] = _deliveryDate;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_basket != null) {
      map['basket'] = _basket?.map((v) => v.toJson()).toList();
    }
    if (_team != null) {
      map['team'] = _team?.toJson();
    }
    return map;
  }
}





