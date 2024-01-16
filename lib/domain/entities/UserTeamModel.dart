import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/TeamCountModel.dart';

import 'TeamModel.dart';

class UserTeamModel {
  UserTeamModel({
    num? statusCode,
    String? message,
    List<HostTeamData>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  UserTeamModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(HostTeamData.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<HostTeamData>? _data;

  UserTeamModel copyWith({
    num? statusCode,
    String? message,
    List<HostTeamData>? data,
  }) =>
      UserTeamModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<HostTeamData>? get data => _data;

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

class HostTeamData {
  HostTeamData({
    String? id,
    String? teamId,
    String? userId,
    String? status,
    bool? skipNextDelivery,
    String? createdAt,
    String? updatedAt,
    Team? team,
  }) {
    _id = id;
    _teamId = teamId;
    _userId = userId;
    _status = status;
    _skipNextDelivery = skipNextDelivery;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _team = team;
  }

  HostTeamData.fromJson(dynamic json) {
    _id = json['id'];
    _teamId = json['teamId'];
    _userId = json['userId'];
    _status = json['status'];
    _skipNextDelivery = json['skipNextDelivery'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _team = json['team'] != null ? Team.fromJson(json['team']) : null;
  }

  String? _id;
  String? _teamId;
  String? _userId;
  String? _status;
  bool? _skipNextDelivery;
  String? _createdAt;
  String? _updatedAt;
  Team? _team;

  HostTeamData copyWith({
    String? id,
    String? teamId,
    String? userId,
    String? status,
    bool? skipNextDelivery,
    String? createdAt,
    String? updatedAt,
    Team? team,
  }) =>
      HostTeamData(
        id: id ?? _id,
        teamId: teamId ?? _teamId,
        userId: userId ?? _userId,
        status: status ?? _status,
        skipNextDelivery: skipNextDelivery ?? _skipNextDelivery,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        team: team ?? _team,
      );

  String? get id => _id;

  String? get teamId => _teamId;

  String? get userId => _userId;

  String? get status => _status;

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
  Team(
      {String? id,
      String? name,
      String? postalCode,
      String? producerId,
      String? hostId,
      num? frequency,
      String? description,
      bool? isPublic,
      dynamic imageUrl,
      dynamic imageKey,
      dynamic nextDeliveryDate,
      String? createdAt,
      String? updatedAt,
      List<Members>? members,
      Producer? producer,
      Host? host,
      Count? count,
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
    _count = count;
    _basket = basket;
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
    if (json['members'] != null) {
      _members = [];
      json['members'].forEach((v) {
        _members?.add(Members.fromJson(v));
      });
    }
    _producer =
        json['producer'] != null ? Producer.fromJson(json['producer']) : null;
    _host = json['host'] != null ? Host.fromJson(json['host']) : null;
    _count = json['_count'] != null ? Count.fromJson(json['_count']) : null;

    if(json['basket']!=null){
      _basket = [];
      json['basket'].forEach((v) {
        _basket?.add(Basket.fromJson(v));
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
  dynamic _imageUrl;
  dynamic _imageKey;
  dynamic _nextDeliveryDate;
  String? _createdAt;
  String? _updatedAt;
  List<Members>? _members;
  Producer? _producer;
  Host? _host;
  Count? _count;
  List<Basket>? _basket;

  Team copyWith({
    String? id,
    String? name,
    String? postalCode,
    String? producerId,
    String? hostId,
    num? frequency,
    String? description,
    bool? isPublic,
    dynamic imageUrl,
    dynamic imageKey,
    dynamic nextDeliveryDate,
    String? createdAt,
    String? updatedAt,
    List<Members>? members,
    Producer? producer,
    Host? host,
    Count? count,
    List<Basket>? basket,

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
        members: members ?? _members,
        producer: producer ?? _producer,
        host: host ?? _host,
        count: count ?? _count,
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

  dynamic get imageUrl => _imageUrl;

  dynamic get imageKey => _imageKey;

  dynamic get nextDeliveryDate => _nextDeliveryDate;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<Members>? get members => _members;

  List<Basket>? get basket => _basket;

  Producer? get producer => _producer;

  Count? get count => _count;

  Host? get host => _host;

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
    dynamic imageUrl,
    dynamic imageKey,
    String? businessName,
    String? businessAddress,
    num? minimumTreshold,
    dynamic website,
    dynamic description,
    String? createdAt,
    String? updatedAt,
    User? user,
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
    _user = user;
    _categories = categories;
    _count = count;

  }

  Producer.fromJson(dynamic json) {
    _id = json['id'] ?? '';
    _userId = json['userId'] ?? '';
    _imageUrl = json['imageUrl'] ?? '';
    _imageKey = json['imageKey'] ?? '';
    _businessName = json['businessName'] ?? '';
    _businessAddress = json['businessAddress'] ?? '';
    _minimumTreshold = json['minimumTreshold'] ?? 0;
    _website = json['website'] ?? '';
    _description = json['description'] ?? '';
    _createdAt = json['createdAt'] ?? '';
    _updatedAt = json['updatedAt'] ?? '';
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
    _count = json['_count'] != null ? Count.fromJson(json['_count']) : null;
  }


  Producer.fromLocalStorage() {
    _businessName = "ABC";
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
  User? _user;
  List<Categories>? _categories;
  Count? _count;

  Producer copyWith({
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
    User? user,
    Count? count,

    List<Categories>? categories,
  }) =>
      Producer(
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
        user: user ?? _user,
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
  Count? get count => _count;

  User? get user => _user;

  List<Categories>? get categories => _categories;

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
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}



class Members {
  Members({
    String? id,
    String? teamId,
    String? userId,
    String? status,
    bool? skipNextDelivery,
    String? createdAt,
    String? updatedAt,
    User? user,

  }) {
    _id = id;
    _teamId = teamId;
    _userId = userId;
    _status = status;
    _skipNextDelivery = skipNextDelivery;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;

  }

  Members.fromJson(dynamic json) {
    _id = json['id'];
    _teamId = json['teamId'];
    _userId = json['userId'];
    _status = json['status'];
    _skipNextDelivery = json['skipNextDelivery'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    if(json['user'] != null) {
      _user = json['user'] != null ? User.fromJson(json['user']) : null;
    }

  }

  String? _id;
  String? _teamId;
  String? _userId;
  String? _status;
  bool? _skipNextDelivery;
  String? _createdAt;
  String? _updatedAt;
  User? _user;


  Members copyWith({
    String? id,
    String? teamId,
    String? userId,
    String? status,
    bool? skipNextDelivery,
    String? createdAt,
    String? updatedAt,
    User? user,

  }) =>
      Members(
        id: id ?? _id,
        teamId: teamId ?? _teamId,
        userId: userId ?? _userId,
        status: status ?? _status,
        skipNextDelivery: skipNextDelivery ?? _skipNextDelivery,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        user: user ?? _user,

      );

  String? get id => _id;

  String? get teamId => _teamId;

  String? get userId => _userId;

  String? get status => _status;

  bool? get skipNextDelivery => _skipNextDelivery;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  User? get user => _user;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['teamId'] = _teamId;
    map['userId'] = _userId;
    map['status'] = _status;
    map['skipNextDelivery'] = _skipNextDelivery;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}
