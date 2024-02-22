import '../../config/export.dart';

class ProducerModel {
  ProducerModel({
    num? statusCode,
    String? message,
    List<ProducerDetail>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  ProducerModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProducerDetail.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<ProducerDetail>? _data;

  ProducerModel copyWith({
    num? statusCode,
    String? message,
    List<ProducerDetail>? data,
  }) =>
      ProducerModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<ProducerDetail>? get data => _data;

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

class ProducerDetail {
  ProducerDetail({
    String? id,
    String? userId,
    dynamic imageUrl,
    dynamic imageKey,
    String? businessName,
    String? businessAddress,
    num? minimumTreshold,
    dynamic website,
    dynamic description,
    String? createdAt,
    String? updatedAt,
    List<Categories>? categories,
    Count? count,
  }) {
    _id = id;
    _userId = userId;
    _imageUrl = imageUrl;
    _imageKey = imageKey;
    _businessName = businessName;
    _businessAddress = businessAddress;
    _minimumTreshold = minimumTreshold;
    _website = website;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _categories = categories;
    _count = count;
  }

  ProducerDetail.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _imageUrl = json['imageUrl'];
    _imageKey = json['imageKey'];
    _businessName = json['businessName'];
    _businessAddress = json['businessAddress'];
    _minimumTreshold = num.tryParse(json['minimumTreshold'])??0;
    _website = json['website'];
    _description = json['description'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
    _count = json['_count'] != null ? Count.fromJson(json['_count']) : null;
  }

  String? _id;
  String? _userId;
  dynamic _imageUrl;
  dynamic _imageKey;
  String? _businessName;
  String? _businessAddress;
  num? _minimumTreshold;
  dynamic _website;
  dynamic _description;
  String? _createdAt;
  String? _updatedAt;
  List<Categories>? _categories;
  Count? _count;

  ProducerDetail copyWith({
    String? id,
    String? userId,
    dynamic imageUrl,
    dynamic imageKey,
    String? businessName,
    String? businessAddress,
    num? minimumTreshold,
    dynamic website,
    dynamic description,
    String? createdAt,
    String? updatedAt,
    List<Categories>? categories,
    Count? count,
  }) =>
      ProducerDetail(
        id: id ?? _id,
        userId: userId ?? _userId,
        imageUrl: imageUrl ?? _imageUrl,
        imageKey: imageKey ?? _imageKey,
        businessName: businessName ?? _businessName,
        businessAddress: businessAddress ?? _businessAddress,
        minimumTreshold: minimumTreshold ?? _minimumTreshold,
        website: website ?? _website,
        description: description ?? _description,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        categories: categories ?? _categories,
        count: count ?? _count,
      );

  String? get id => _id;

  String? get userId => _userId;

  dynamic get imageUrl => _imageUrl;

  dynamic get imageKey => _imageKey;

  String? get businessName => _businessName;

  String? get businessAddress => _businessAddress;

  num? get minimumTreshold => _minimumTreshold;

  dynamic get website => _website;

  dynamic get description => _description;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<Categories>? get categories => _categories;

  Count? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['imageUrl'] = _imageUrl;
    map['imageKey'] = _imageKey;
    map['businessName'] = _businessName;
    map['businessAddress'] = _businessAddress;
    map['minimumTreshold'] = _minimumTreshold;
    map['website'] = _website;
    map['description'] = _description;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Categories {
  Categories({
    String? id,
    String? producerId,
    String? producerCategoryOptionId,
    String? createdAt,
    String? updatedAt,
    CategoryData? category,
  }) {
    _id = id;
    _producerId = producerId;
    _producerCategoryOptionId = producerCategoryOptionId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _category = category;
  }

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _producerId = json['producerId'];
    _producerCategoryOptionId = json['producerCategoryOptionId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _category = json['category'] != null
        ? CategoryData.fromJson(json['category'])
        : null;
  }

  String? _id;
  String? _producerId;
  String? _producerCategoryOptionId;
  String? _createdAt;
  String? _updatedAt;
  CategoryData? _category;

  Categories copyWith({
    String? id,
    String? producerId,
    String? producerCategoryOptionId,
    String? createdAt,
    String? updatedAt,
    CategoryData? category,
  }) =>
      Categories(
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

  CategoryData? get category => _category;

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

class CategoryData {
  CategoryData({
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

  CategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;

  CategoryData copyWith({
    String? id,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      CategoryData(
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
