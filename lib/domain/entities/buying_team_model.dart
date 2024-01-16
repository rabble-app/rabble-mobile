import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/HostData.dart';

import 'RequestSendModel.dart';
import 'TeamModel.dart';
import 'UserTeamModel.dart';

class BuyingTeamModel {
  BuyingTeamModel({
    num? statusCode,
    String? message,
    List<BuyingTeamDetail>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  BuyingTeamModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BuyingTeamDetail.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<BuyingTeamDetail>? _data;

  BuyingTeamModel copyWith({
    num? statusCode,
    String? message,
    List<BuyingTeamDetail>? data,
  }) =>
      BuyingTeamModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<BuyingTeamDetail>? get data => _data;

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

class BuyingTeamDetail {
  BuyingTeamDetail({
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
    String? nextDeliveryDate,
    String? createdAt,
    String? updatedAt,
    List<BuyingTeamMembers>? members,
    Producer? producer,
    HostData? host,
    List<RequestSendData>? requests,
    List<Basket>? basket,
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
    _members = members;
    _producer = producer;
    _host = host;
    _requests = requests;
    _basket = basket;
  }

  BuyingTeamDetail.fromJson(dynamic json) {
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
    if (json['members'] != null) {
      _members = [];

      json['members'].forEach((v) {
        _members?.add(BuyingTeamMembers.fromJson(v));
      });
    }
    if (json['basket'] != null) {
      _basket = [];
      json['basket'].forEach((v) {
        _basket?.add(Basket.fromJson(v));
      });
    }
    _producer =
        json['producer'] != null ? Producer.fromJson(json['producer']) : null;
    _host = json['host'] != null ? HostData.fromJson(json['host']) : null;

    if (json['requests'] != null) {
      _requests = [];
      json['requests'].forEach((v) {
        _requests?.add(RequestSendData.fromJson(v));
      });
    }
  }

  String? _id;
  HostData? _host;
  String? _name;
  String? _postalCode;
  String? _producerId;
  String? _hostId;
  num? _frequency;
  String? _description;
  bool? _isPublic;
  String? _imageUrl;
  dynamic _imageKey;
  String? _nextDeliveryDate;
  String? _createdAt;
  String? _updatedAt;
  List<BuyingTeamMembers>? _members;
  Producer? _producer;
  List<RequestSendData>? _requests;
  List<Basket>? _basket;

  BuyingTeamDetail copyWith({
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
    String? nextDeliveryDate,
    String? createdAt,
    String? updatedAt,
    List<BuyingTeamMembers>? members,
    Producer? producer,
    List<RequestSendData>? requests,
    List<Basket>? basket,
    HostData? host,
  }) =>
      BuyingTeamDetail(
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
        members: members ?? _members,
        producer: producer ?? _producer,
        requests: requests ?? _requests,
        host: host ?? _host,
        basket: basket ?? _basket,
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

  String? get nextDeliveryDate => _nextDeliveryDate;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<BuyingTeamMembers>? get members => _members;

  Producer? get producer => _producer;

  List<RequestSendData>? get requests => _requests;

  HostData? get host => _host;

  List<Basket>? get basket => _basket;

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
    if (_members != null) {
      map['members'] = _members?.map((v) => v.toJson()).toList();
    }
    if (_producer != null) {
      map['producer'] = _producer?.toJson();
    }

    if (_host != null) {
      map['host'] = _host?.toJson();
    }
    return map;
  }

  int epochToTotalWeeks(int epochTimestamp) {
    print(epochTimestamp);
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(epochTimestamp * 1000);
    final int days = dateTime.difference(DateTime(1970)).inDays;
    final int weeks = days ~/ 7;
    return weeks == 0 ? 1 : weeks;
  }
}

class BuyingCategories {
  BuyingCategories({
    String? id,
    String? producerId,
    String? producerCategoryOptionId,
    String? createdAt,
    String? updatedAt,
    BuyingCategoryData? category,
  }) {
    _id = id;
    _producerId = producerId;
    _producerCategoryOptionId = producerCategoryOptionId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _category = category;
  }

  BuyingCategories.fromJson(dynamic json) {
    _id = json['id'];
    _producerId = json['producerId'];
    _producerCategoryOptionId = json['producerCategoryOptionId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _category = json['category'] != null
        ? BuyingCategoryData.fromJson(json['category'])
        : null;
  }

  String? _id;
  String? _producerId;
  String? _producerCategoryOptionId;
  String? _createdAt;
  String? _updatedAt;
  BuyingCategoryData? _category;

  BuyingCategories copyWith({
    String? id,
    String? producerId,
    String? producerCategoryOptionId,
    String? createdAt,
    String? updatedAt,
    BuyingCategoryData? category,
  }) =>
      BuyingCategories(
        id: id ?? _id,
        producerId: producerId ?? _producerId,
        producerCategoryOptionId:
            producerCategoryOptionId ?? _producerCategoryOptionId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        category: category ?? _category,
      );

  String? get id => _id;

  String? get producerId => _producerId;

  String? get producerCategoryOptionId => _producerCategoryOptionId;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  BuyingCategoryData? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['producerId'] = _producerId;
    map['producerCategoryOptionId'] = _producerCategoryOptionId;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    return map;
  }
}

class BuyingCategoryData {
  BuyingCategoryData({
    String? id,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  BuyingCategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;

  BuyingCategoryData copyWith({
    String? id,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      BuyingCategoryData(
        id: id ?? _id,
        name: name ?? _name,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  String? get name => _name;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

class BuyingTeamMembers {
  BuyingTeamMembers({
    String? id,
    String? teamId,
    String? userId,
    String? status,
    bool? skipNextDelivery,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _teamId = teamId;
    _userId = userId;
    _status = status;
    _skipNextDelivery = skipNextDelivery;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  BuyingTeamMembers.fromJson(dynamic json) {
    _id = json['id'];
    _teamId = json['teamId'];
    _userId = json['userId'];
    _status = json['status'];
    _skipNextDelivery = json['skipNextDelivery'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _teamId;
  String? _userId;
  String? _status;
  bool? _skipNextDelivery;
  String? _createdAt;
  String? _updatedAt;

  BuyingTeamMembers copyWith({
    String? id,
    String? teamId,
    String? userId,
    String? status,
    bool? skipNextDelivery,
    String? createdAt,
    String? updatedAt,
  }) =>
      BuyingTeamMembers(
        id: id ?? _id,
        teamId: teamId ?? _teamId,
        userId: userId ?? _userId,
        status: status ?? _status,
        skipNextDelivery: skipNextDelivery ?? _skipNextDelivery,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  String? get teamId => _teamId;

  String? get userId => _userId;

  String? get status => _status;

  bool? get skipNextDelivery => _skipNextDelivery;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['teamId'] = _teamId;
    map['userId'] = _userId;
    map['status'] = _status;
    map['skipNextDelivery'] = _skipNextDelivery;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
