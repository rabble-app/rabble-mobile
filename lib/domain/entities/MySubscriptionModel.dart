import 'package:http/http.dart';

import 'OrderModel.dart';
import 'RequestSendModel.dart';
import 'UserTeamModel.dart';

class MySubscriptionModel {
  MySubscriptionModel({
    num? statusCode,
    String? message,
    List<MySubscriptionData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  MySubscriptionModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MySubscriptionData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<MySubscriptionData>? _data;

  MySubscriptionModel copyWith({
    num? statusCode,
    String? message,
    List<MySubscriptionData>? data,
  }) =>
      MySubscriptionModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<MySubscriptionData>? get data => _data;

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

class MySubscriptionData {
  MySubscriptionData({
    String? id,
    String? teamId,
    String? userId,
    String? status,
    String? role,
    bool? skipNextDelivery,
    String? createdAt,
    String? updatedAt,
    Team? team,
  }) {
    _id = id;
    _teamId = teamId;
    _userId = userId;
    _status = status;
    _role = role;
    _skipNextDelivery = skipNextDelivery;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _team = team;
  }

  MySubscriptionData.fromJson(dynamic json) {
    _id = json['id'];
    _teamId = json['teamId'];
    _userId = json['userId'];
    _status = json['status'];
    _role = json['role'];
    _skipNextDelivery = json['skipNextDelivery'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _team = json['team'] != null ? Team.fromJson(json['team']) : null;
  }

  String? _id;
  String? _teamId;
  String? _userId;
  String? _status;
  String? _role;
  bool? _skipNextDelivery;
  String? _createdAt;
  String? _updatedAt;
  Team? _team;

  MySubscriptionData copyWith({
    String? id,
    String? teamId,
    String? userId,
    String? status,
    String? role,
    bool? skipNextDelivery,
    String? createdAt,
    String? updatedAt,
    Team? team,
  }) =>
      MySubscriptionData(
        id: id ?? _id,
        teamId: teamId ?? _teamId,
        userId: userId ?? _userId,
        status: status ?? _status,
        role: role ?? _role,
        skipNextDelivery: skipNextDelivery ?? _skipNextDelivery,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        team: team ?? _team,
      );

  String? get id => _id;

  String? get teamId => _teamId;

  String? get userId => _userId;

  String? get status => _status;

  String? get role => _role;

  bool? get skipNextDelivery => _skipNextDelivery;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Team? get team => _team;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['teamId'] = _teamId;
    map['userId'] = _userId;
    map['status'] = _status;
    map['role'] = _role;
    map['skipNextDelivery'] = _skipNextDelivery;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_team != null) {
      map['team'] = _team?.toJson();
    }
    return map;
  }
}

class Team {
  Team({
    String? id,
    String? name,
    String? postalCode,
    String? producerId,
    String? hostId,
    num? frequency,
    String? description,
    bool? isPublic,
    String? imageUrl,
    dynamic imageKey,
    dynamic nextDeliveryDate,
    String? createdAt,
    String? updatedAt,
    List<Orders>? orders,
    Host? host,
    List<Members>? members,
    List<RequestSendData>? requests,
    Producer? producer,
  }) {
    _id = id;
    _name = name;
    _postalCode = postalCode;
    _producerId = producerId;
    _hostId = hostId;
    _frequency = frequency;
    _description = description;
    _isPublic = isPublic;
    _imageUrl = imageUrl;
    _imageKey = imageKey;
    _nextDeliveryDate = nextDeliveryDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _orders = orders;
    _host = host;
    _members = members;
    _requests = requests;
    _producer = producer;
  }

  Team.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _postalCode = json['postalCode'];
    _producerId = json['producerId'];
    _hostId = json['hostId'];
    _frequency = json['frequency'];
    _description = json['description'];
    _isPublic = json['isPublic'];
    _imageUrl = json['imageUrl'];
    _imageKey = json['imageKey'];
    _nextDeliveryDate = json['nextDeliveryDate'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    if (json['orders'] != null) {
      _orders = [];
      json['orders'].forEach((v) {
        _orders?.add(Orders.fromJson(v));
      });
    }
    _host = json['host'] != null ? Host.fromJson(json['host']) : null;
    if (json['members'] != null) {
      _members = [];
      json['members'].forEach((v) {
        _members?.add(Members.fromJson(v));
      });
    }
    if (json['requests'] != null) {
      _requests = [];
      json['requests'].forEach((v) {
        _requests?.add(RequestSendData.fromJson(v));
      });
    }
    _producer =
        json['producer'] != null ? Producer.fromJson(json['producer']) : null;
  }

  String? _id;
  String? _name;
  String? _postalCode;
  String? _producerId;
  String? _hostId;
  num? _frequency;
  String? _description;
  bool? _isPublic;
  String? _imageUrl;
  dynamic _imageKey;
  dynamic _nextDeliveryDate;
  String? _createdAt;
  String? _updatedAt;
  List<Orders>? _orders;
  Host? _host;
  List<Members>? _members;
  List<RequestSendData>? _requests;
  Producer? _producer;

  Team copyWith({
    String? id,
    String? name,
    String? postalCode,
    String? producerId,
    String? hostId,
    num? frequency,
    String? description,
    bool? isPublic,
    String? imageUrl,
    dynamic imageKey,
    dynamic nextDeliveryDate,
    String? createdAt,
    String? updatedAt,
    List<Orders>? orders,
    Host? host,
    List<Members>? members,
    List<RequestSendData>? requests,
    Producer? producer,
  }) =>
      Team(
        id: id ?? _id,
        name: name ?? _name,
        postalCode: postalCode ?? _postalCode,
        producerId: producerId ?? _producerId,
        hostId: hostId ?? _hostId,
        frequency: frequency ?? _frequency,
        description: description ?? _description,
        isPublic: isPublic ?? _isPublic,
        imageUrl: imageUrl ?? _imageUrl,
        imageKey: imageKey ?? _imageKey,
        nextDeliveryDate: nextDeliveryDate ?? _nextDeliveryDate,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        orders: orders ?? _orders,
        host: host ?? _host,
        members: members ?? _members,
        requests: requests ?? _requests,
        producer: producer ?? _producer,
      );

  String? get id => _id;

  String? get name => _name;

  String? get postalCode => _postalCode;

  String? get producerId => _producerId;

  String? get hostId => _hostId;

  num? get frequency => _frequency;

  String? get description => _description;

  bool? get isPublic => _isPublic;

  String? get imageUrl => _imageUrl;

  dynamic get imageKey => _imageKey;

  dynamic get nextDeliveryDate => _nextDeliveryDate;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<Orders>? get orders => _orders;

  Host? get host => _host;

  List<Members>? get members => _members;

  List<RequestSendData>? get requests => _requests;

  Producer? get producer => _producer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['postalCode'] = _postalCode;
    map['producerId'] = _producerId;
    map['hostId'] = _hostId;
    map['frequency'] = _frequency;
    map['description'] = _description;
    map['isPublic'] = _isPublic;
    map['imageUrl'] = _imageUrl;
    map['imageKey'] = _imageKey;
    map['nextDeliveryDate'] = _nextDeliveryDate;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_orders != null) {
      map['orders'] = _orders?.map((v) => v.toJson()).toList();
    }
    if (_host != null) {
      map['host'] = _host?.toJson();
    }
    if (_members != null) {
      map['members'] = _members?.map((v) => v.toJson()).toList();
    }
    if (_requests != null) {
      map['requests'] = _requests?.map((v) => v.toJson()).toList();
    }
    if (_producer != null) {
      map['producer'] = _producer?.toJson();
    }
    return map;
  }
}




class User {
  User({
    dynamic firstName,
    dynamic lastName,
  }) {
    _firstName = firstName;
    _lastName = lastName;
  }

  User.fromJson(dynamic json) {
    _firstName = json['firstName'];
    _lastName = json['lastName'];
  }

  dynamic _firstName;
  dynamic _lastName;

  User copyWith({
    dynamic firstName,
    dynamic lastName,
  }) =>
      User(
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
      );

  dynamic get firstName => _firstName;

  dynamic get lastName => _lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    return map;
  }
}

class Orders {
  Orders({
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
  }

  Orders.fromJson(dynamic json) {
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

  Orders copyWith({
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
  }) =>
      Orders(
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

  List<dynamic>? get basket => _basket;

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
    return map;
  }
}
