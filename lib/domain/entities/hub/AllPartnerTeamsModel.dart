import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';

class AllPartnerTeamsModel {
  AllPartnerTeamsModel({
    num? statusCode,
    String? message,
    List<PartnersTeamData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  AllPartnerTeamsModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PartnersTeamData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<PartnersTeamData>? _data;

  AllPartnerTeamsModel copyWith({
    num? statusCode,
    String? message,
    List<PartnersTeamData>? data,
  }) =>
      AllPartnerTeamsModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<PartnersTeamData>? get data => _data;

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

class PartnersTeamData {
  PartnersTeamData({
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
    String? productLimit,
    String? deliveryDay,
    String? createdAt,
    String? updatedAt,
    String? partnerId,
    List<BuyingTeamMembers>? members,
    Producer? producer,
    Host? host,
    List<RequestSendData>? requests,
    Partner? partner,
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
    _productLimit = productLimit;
    _deliveryDay = deliveryDay;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _partnerId = partnerId;
    _members = members;
    _producer = producer;
    _host = host;
    _requests = requests;

    _partner = partner;
  }

  PartnersTeamData.fromJson(dynamic json) {
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
    _productLimit = json['productLimit'];
    _deliveryDay = json['deliveryDay'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _partnerId = json['partnerId'];
    if (json['members'] != null) {
      _members = [];
      json['members'].forEach((v) {
        _members?.add(BuyingTeamMembers.fromJson(v));
      });
    }
    _producer =
        json['producer'] != null ? Producer.fromJson(json['producer']) : null;
    _host = json['host'] != null ? Host.fromJson(json['host']) : null;
    _partner =
        json['Partner'] != null ? Partner.fromJson(json['Partner']) : null;

    if (json['requests'] != null) {
      _requests = [];
      json['requests'].forEach((v) {
        _requests?.add(RequestSendData.fromJson(v));
      });
    }

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
  String? _nextDeliveryDate;
  String? _productLimit;
  String? _deliveryDay;
  String? _createdAt;
  String? _updatedAt;
  String? _partnerId;
  List<BuyingTeamMembers>? _members;
  Producer? _producer;
  Host? _host;
  Partner? _partner;
  List<RequestSendData>? _requests;


  PartnersTeamData copyWith({
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
    String? productLimit,
    String? deliveryDay,
    String? createdAt,
    String? updatedAt,
    String? partnerId,
    List<BuyingTeamMembers>? members,
    Producer? producer,
    Host? host,
    List<RequestSendData>? requests,

    Partner? partner,
  }) =>
      PartnersTeamData(
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
        productLimit: productLimit ?? _productLimit,
        deliveryDay: deliveryDay ?? _deliveryDay,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        partnerId: partnerId ?? _partnerId,
        members: members ?? _members,
        producer: producer ?? _producer,
        requests: requests ?? _requests,

        host: host ?? _host,
        partner: partner ?? _partner,
      );


  List<RequestSendData>? get requests => _requests;

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

  String? get productLimit => _productLimit;

  String? get deliveryDay => _deliveryDay;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get partnerId => _partnerId;

  List<BuyingTeamMembers>? get members => _members;

  Producer? get producer => _producer;

  Host? get host => _host;

  Partner? get partner => _partner;

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
    map['productLimit'] = _productLimit;
    map['deliveryDay'] = _deliveryDay;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['partnerId'] = _partnerId;
    if (_members != null) {
      map['members'] = _members?.map((v) => v.toJson()).toList();
    }
    if (_producer != null) {
      map['producer'] = _producer?.toJson();
    }
    if (_host != null) {
      map['host'] = _host?.toJson();
    }
    if (_partner != null) {
      map['Partner'] = _partner?.toJson();
    }
    return map;
  }
}


class Host {
  Host({
    String? firstName,
    String? lastName,
  }) {
    _firstName = firstName;
    _lastName = lastName;
  }

  Host.fromJson(dynamic json) {
    _firstName = json['firstName'];
    _lastName = json['lastName'];
  }

  String? _firstName;
  String? _lastName;

  Host copyWith({
    String? firstName,
    String? lastName,
  }) =>
      Host(
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
      );

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    return map;
  }
}

class Producer {
  Producer({
    String? id,
    String? userId,
    dynamic stripeConnectId,
    bool? isVerified,
    String? imageUrl,
    dynamic imageKey,
    String? businessName,
    String? businessAddress,
    dynamic accountsEmail,
    dynamic salesEmail,
    String? minimumTreshold,
    dynamic website,
    dynamic description,
    dynamic vat,
    num? paymentTerm,
    String? createdAt,
    String? updatedAt,
    User? user,
    List<Categories>? categories,
  }) {
    _id = id;
    _userId = userId;
    _stripeConnectId = stripeConnectId;
    _isVerified = isVerified;
    _imageUrl = imageUrl;
    _imageKey = imageKey;
    _businessName = businessName;
    _businessAddress = businessAddress;
    _accountsEmail = accountsEmail;
    _salesEmail = salesEmail;
    _minimumTreshold = minimumTreshold;
    _website = website;
    _description = description;
    _vat = vat;
    _paymentTerm = paymentTerm;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    _categories = categories;
  }

  Producer.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _stripeConnectId = json['stripeConnectId'];
    _isVerified = json['isVerified'];
    _imageUrl = json['imageUrl'];
    _imageKey = json['imageKey'];
    _businessName = json['businessName'];
    _businessAddress = json['businessAddress'];
    _accountsEmail = json['accountsEmail'];
    _salesEmail = json['salesEmail'];
    _minimumTreshold = json['minimumTreshold'];
    _website = json['website'];
    _description = json['description'];
    _vat = json['vat'];
    _paymentTerm = json['paymentTerm'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
  }

  String? _id;
  String? _userId;
  dynamic _stripeConnectId;
  bool? _isVerified;
  String? _imageUrl;
  dynamic _imageKey;
  String? _businessName;
  String? _businessAddress;
  dynamic _accountsEmail;
  dynamic _salesEmail;
  String? _minimumTreshold;
  dynamic _website;
  dynamic _description;
  dynamic _vat;
  num? _paymentTerm;
  String? _createdAt;
  String? _updatedAt;
  User? _user;
  List<Categories>? _categories;

  Producer copyWith({
    String? id,
    String? userId,
    dynamic stripeConnectId,
    bool? isVerified,
    String? imageUrl,
    dynamic imageKey,
    String? businessName,
    String? businessAddress,
    dynamic accountsEmail,
    dynamic salesEmail,
    String? minimumTreshold,
    dynamic website,
    dynamic description,
    dynamic vat,
    num? paymentTerm,
    String? createdAt,
    String? updatedAt,
    User? user,
    List<Categories>? categories,
  }) =>
      Producer(
        id: id ?? _id,
        userId: userId ?? _userId,
        stripeConnectId: stripeConnectId ?? _stripeConnectId,
        isVerified: isVerified ?? _isVerified,
        imageUrl: imageUrl ?? _imageUrl,
        imageKey: imageKey ?? _imageKey,
        businessName: businessName ?? _businessName,
        businessAddress: businessAddress ?? _businessAddress,
        accountsEmail: accountsEmail ?? _accountsEmail,
        salesEmail: salesEmail ?? _salesEmail,
        minimumTreshold: minimumTreshold ?? _minimumTreshold,
        website: website ?? _website,
        description: description ?? _description,
        vat: vat ?? _vat,
        paymentTerm: paymentTerm ?? _paymentTerm,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        user: user ?? _user,
        categories: categories ?? _categories,
      );

  String? get id => _id;

  String? get userId => _userId;

  dynamic get stripeConnectId => _stripeConnectId;

  bool? get isVerified => _isVerified;

  String? get imageUrl => _imageUrl;

  dynamic get imageKey => _imageKey;

  String? get businessName => _businessName;

  String? get businessAddress => _businessAddress;

  dynamic get accountsEmail => _accountsEmail;

  dynamic get salesEmail => _salesEmail;

  String? get minimumTreshold => _minimumTreshold;

  dynamic get website => _website;

  dynamic get description => _description;

  dynamic get vat => _vat;

  num? get paymentTerm => _paymentTerm;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  User? get user => _user;

  List<Categories>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['stripeConnectId'] = _stripeConnectId;
    map['isVerified'] = _isVerified;
    map['imageUrl'] = _imageUrl;
    map['imageKey'] = _imageKey;
    map['businessName'] = _businessName;
    map['businessAddress'] = _businessAddress;
    map['accountsEmail'] = _accountsEmail;
    map['salesEmail'] = _salesEmail;
    map['minimumTreshold'] = _minimumTreshold;
    map['website'] = _website;
    map['description'] = _description;
    map['vat'] = _vat;
    map['paymentTerm'] = _paymentTerm;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
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
    Category? category,
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
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  String? _id;
  String? _producerId;
  String? _producerCategoryOptionId;
  String? _createdAt;
  String? _updatedAt;
  Category? _category;

  Categories copyWith({
    String? id,
    String? producerId,
    String? producerCategoryOptionId,
    String? createdAt,
    String? updatedAt,
    Category? category,
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

  Category? get category => _category;

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

class Category {
  Category({
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

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;

  Category copyWith({
    String? id,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      Category(
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

