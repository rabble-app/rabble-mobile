import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/ConversationModel.dart';
import 'package:rabble/domain/entities/TeamCountModel.dart';

import 'RequestSendModel.dart';
import 'UserTeamModel.dart';

/// statusCode : 200
/// message : "Buying team returned successfully"
/// data : {"id":"2c868557-b407-461c-8f31-21cd86e10a06","name":"Hatesh Test","postalCode":"1234","producerId":"ba775083-5f9a-41d9-b724-0ea280f5ea43","hostId":"cb4e4c37-83c7-49be-9aaa-5e3188e8b235","frequency":104500,"description":"test","isPublic":true,"imageUrl":"https://rabble-dev1.s3.us-east-2.amazonaws.com/teams/renaissance16.png","imageKey":null,"nextDeliveryDate":null,"createdAt":"2023-06-13T18:47:37.532Z","updatedAt":"2023-06-13T18:47:37.532Z","members":[{"id":"8dfc2cd0-7f20-46cb-bba3-6454e10ce8fa","teamId":"2c868557-b407-461c-8f31-21cd86e10a06","userId":"cb4e4c37-83c7-49be-9aaa-5e3188e8b235","status":"APPROVED","skipNextDelivery":false,"createdAt":"2023-06-13T18:47:38.024Z","updatedAt":"2023-06-13T18:47:38.024Z","user":{"email":null,"firstName":"Hatesh","lastName":"Kumar","phone":"+4407872076691","imageUrl":"https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/img.png"}}],"host":{"id":"cb4e4c37-83c7-49be-9aaa-5e3188e8b235","phone":"+4407872076691","email":null,"firstName":"Hatesh","lastName":"Kumar","postalCode":"1234","stripeCustomerId":"cus_O4hMIyW1e1Z4we","stripeDefaultPaymentMethodId":"pm_1NIY1WLOm4z6MbsxuEPRDqh6","cardLastFourDigits":null,"imageUrl":"https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/img.png","imageKey":null,"role":"USER","createdAt":"2023-06-13T14:12:26.665Z","updatedAt":"2023-06-16T11:07:43.773Z","shipping":{"id":"0de3a165-86e8-4abb-bd93-84d2038278a6","userId":"cb4e4c37-83c7-49be-9aaa-5e3188e8b235","buildingNo":"test","address":"assadas","city":"tess","createdAt":"2023-06-13T14:17:17.865Z","updatedAt":"2023-06-16T16:46:19.011Z"}},"producer":{"id":"ba775083-5f9a-41d9-b724-0ea280f5ea43","userId":"1a505a08-66c3-4925-b7a7-73e841409ace","imageUrl":null,"imageKey":null,"businessName":"Rabble21","businessAddress":"22 Kate Road","minimumTreshold":10000,"website":null,"description":null,"createdAt":"2023-06-05T14:44:27.956Z","updatedAt":"2023-06-05T14:44:27.956Z","user":{"firstName":"Chijioke","lastName":"Okwuosa"},"categories":[{"id":"1","producerId":"ba775083-5f9a-41d9-b724-0ea280f5ea43","producerCategoryOptionId":"1","createdAt":"2023-06-13T12:31:34.386Z","updatedAt":"2023-06-13T12:31:34.386Z","category":{"id":"1","name":"Vegetables","createdAt":"2023-06-13T12:31:34.386Z","updatedAt":"2023-06-13T12:31:34.386Z"}}]},"requests":[{"id":"9422f374-de51-4e2a-a8eb-14c1268d3bd7","teamId":"2c868557-b407-461c-8f31-21cd86e10a06","userId":"1a505a08-66c3-4925-b7a7-73e841409ace","introduction":"test","status":"PENDING","createdAt":"2023-06-21T17:04:45.568Z","updatedAt":"2023-06-21T17:04:45.568Z","user":{"firstName":"Chijioke","lastName":"Okwuosa"}}]}

class TeamModel {
  TeamModel({
    num? statusCode,
    String? message,
    TeamData? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  TeamModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? TeamData.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _message;
  TeamData? _data;

  TeamModel copyWith({
    num? statusCode,
    String? message,
    TeamData? data,
  }) =>
      TeamModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  TeamData? get data => _data;

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

/// id : "2c868557-b407-461c-8f31-21cd86e10a06"
/// name : "Hatesh Test"
/// postalCode : "1234"
/// producerId : "ba775083-5f9a-41d9-b724-0ea280f5ea43"
/// hostId : "cb4e4c37-83c7-49be-9aaa-5e3188e8b235"
/// frequency : 104500
/// description : "test"
/// isPublic : true
/// imageUrl : "https://rabble-dev1.s3.us-east-2.amazonaws.com/teams/renaissance16.png"
/// imageKey : null
/// nextDeliveryDate : null
/// createdAt : "2023-06-13T18:47:37.532Z"
/// updatedAt : "2023-06-13T18:47:37.532Z"
/// members : [{"id":"8dfc2cd0-7f20-46cb-bba3-6454e10ce8fa","teamId":"2c868557-b407-461c-8f31-21cd86e10a06","userId":"cb4e4c37-83c7-49be-9aaa-5e3188e8b235","status":"APPROVED","skipNextDelivery":false,"createdAt":"2023-06-13T18:47:38.024Z","updatedAt":"2023-06-13T18:47:38.024Z","user":{"email":null,"firstName":"Hatesh","lastName":"Kumar","phone":"+4407872076691","imageUrl":"https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/img.png"}}]
/// host : {"id":"cb4e4c37-83c7-49be-9aaa-5e3188e8b235","phone":"+4407872076691","email":null,"firstName":"Hatesh","lastName":"Kumar","postalCode":"1234","stripeCustomerId":"cus_O4hMIyW1e1Z4we","stripeDefaultPaymentMethodId":"pm_1NIY1WLOm4z6MbsxuEPRDqh6","cardLastFourDigits":null,"imageUrl":"https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/img.png","imageKey":null,"role":"USER","createdAt":"2023-06-13T14:12:26.665Z","updatedAt":"2023-06-16T11:07:43.773Z","shipping":{"id":"0de3a165-86e8-4abb-bd93-84d2038278a6","userId":"cb4e4c37-83c7-49be-9aaa-5e3188e8b235","buildingNo":"test","address":"assadas","city":"tess","createdAt":"2023-06-13T14:17:17.865Z","updatedAt":"2023-06-16T16:46:19.011Z"}}
/// producer : {"id":"ba775083-5f9a-41d9-b724-0ea280f5ea43","userId":"1a505a08-66c3-4925-b7a7-73e841409ace","imageUrl":null,"imageKey":null,"businessName":"Rabble21","businessAddress":"22 Kate Road","minimumTreshold":10000,"website":null,"description":null,"createdAt":"2023-06-05T14:44:27.956Z","updatedAt":"2023-06-05T14:44:27.956Z","user":{"firstName":"Chijioke","lastName":"Okwuosa"},"categories":[{"id":"1","producerId":"ba775083-5f9a-41d9-b724-0ea280f5ea43","producerCategoryOptionId":"1","createdAt":"2023-06-13T12:31:34.386Z","updatedAt":"2023-06-13T12:31:34.386Z","category":{"id":"1","name":"Vegetables","createdAt":"2023-06-13T12:31:34.386Z","updatedAt":"2023-06-13T12:31:34.386Z"}}]}
/// requests : [{"id":"9422f374-de51-4e2a-a8eb-14c1268d3bd7","teamId":"2c868557-b407-461c-8f31-21cd86e10a06","userId":"1a505a08-66c3-4925-b7a7-73e841409ace","introduction":"test","status":"PENDING","createdAt":"2023-06-21T17:04:45.568Z","updatedAt":"2023-06-21T17:04:45.568Z","user":{"firstName":"Chijioke","lastName":"Okwuosa"}}]

class TeamData {
  TeamData({
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
    List<Members>? members,
    TeamHost? host,
    Producer? producer,
    List<RequestSendData>? requests,
    List<ConversationData>? chats,
    Count? count,
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
    _host = host;
    _producer = producer;
    _requests = requests;
    _chats = chats;
    _count = count;
  }

  TeamData.fromJson(dynamic json) {
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
    _host = json['host'] != null ? TeamHost.fromJson(json['host']) : null;
    _producer =
        json['producer'] != null ? Producer.fromJson(json['producer']) : null;
    if (json['requests'] != null) {
      _requests = [];
      json['requests'].forEach((v) {
        _requests?.add(RequestSendData.fromJson(v));
      });
    }
    if (json['chats'] != null) {
      _chats = [];
      json['chats'].forEach((v) {
        _chats?.add(ConversationData.fromJson(v));
      });
    }
    _count = json['_count'] != null ? Count.fromJson(json['_count']) : null;
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
  List<Members>? _members;
  TeamHost? _host;
  Producer? _producer;
  List<RequestSendData>? _requests;
  List<ConversationData>? _chats;

  Count? _count;

  TeamData copyWith({
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
    List<Members>? members,
    TeamHost? host,
    Producer? producer,
    List<RequestSendData>? requests,
    List<ConversationData>? chats,
    Count? count,
  }) =>
      TeamData(
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
          host: host ?? _host,
          producer: producer ?? _producer,
          requests: requests ?? _requests,
          chats: chats ?? _chats,
          count: count ?? _count);

  String? get id => _id;

  String? get name => _name;

  String? get postalCode => _postalCode;

  String? get producerId => _producerId;

  String? get hostId => _hostId;

  num? get frequency => _frequency;

  String? get description => _description;

  bool? get isPublic => _isPublic;

  List<ConversationData>? get chats => _chats;


  set chats(List<ConversationData>? value) {
    _chats = value;
  }

  String? get imageUrl => _imageUrl;

  dynamic get imageKey => _imageKey;

  dynamic get nextDeliveryDate => _nextDeliveryDate;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<Members>? get members => _members;

  TeamHost? get host => _host;

  Producer? get producer => _producer;

  List<RequestSendData>? get requests => _requests;

  Count? get count => _count;

  set frequency(num? value) {
    _frequency = value;
  }

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
    if (_host != null) {
      map['host'] = _host?.toJson();
    }
    if (_producer != null) {
      map['producer'] = _producer?.toJson();
    }
    if (_requests != null) {
      map['requests'] = _requests?.map((v) => v.toJson()).toList();
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

  set nextDeliveryDate(dynamic? value) {
    _nextDeliveryDate = value;
  }

  set isPublic(bool? value) {
    _isPublic = value;
  }

  set description(String? value) {
    _description = value;
  }

  set name(String? value) {
    _name = value;
  }
}

/// id : "9422f374-de51-4e2a-a8eb-14c1268d3bd7"
/// teamId : "2c868557-b407-461c-8f31-21cd86e10a06"
/// userId : "1a505a08-66c3-4925-b7a7-73e841409ace"
/// introduction : "test"
/// status : "PENDING"
/// createdAt : "2023-06-21T17:04:45.568Z"
/// updatedAt : "2023-06-21T17:04:45.568Z"
/// user : {"firstName":"Chijioke","lastName":"Okwuosa"}

/// firstName : "Chijioke"
/// lastName : "Okwuosa"

/// id : "ba775083-5f9a-41d9-b724-0ea280f5ea43"
/// userId : "1a505a08-66c3-4925-b7a7-73e841409ace"
/// imageUrl : null
/// imageKey : null
/// businessName : "Rabble21"
/// businessAddress : "22 Kate Road"
/// minimumTreshold : 10000
/// website : null
/// description : null
/// createdAt : "2023-06-05T14:44:27.956Z"
/// updatedAt : "2023-06-05T14:44:27.956Z"
/// user : {"firstName":"Chijioke","lastName":"Okwuosa"}
/// categories : [{"id":"1","producerId":"ba775083-5f9a-41d9-b724-0ea280f5ea43","producerCategoryOptionId":"1","createdAt":"2023-06-13T12:31:34.386Z","updatedAt":"2023-06-13T12:31:34.386Z","category":{"id":"1","name":"Vegetables","createdAt":"2023-06-13T12:31:34.386Z","updatedAt":"2023-06-13T12:31:34.386Z"}}]

/// firstName : "Chijioke"
/// lastName : "Okwuosa"

/// id : "cb4e4c37-83c7-49be-9aaa-5e3188e8b235"
/// phone : "+4407872076691"
/// email : null
/// firstName : "Hatesh"
/// lastName : "Kumar"
/// postalCode : "1234"
/// stripeCustomerId : "cus_O4hMIyW1e1Z4we"
/// stripeDefaultPaymentMethodId : "pm_1NIY1WLOm4z6MbsxuEPRDqh6"
/// cardLastFourDigits : null
/// imageUrl : "https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/img.png"
/// imageKey : null
/// role : "USER"
/// createdAt : "2023-06-13T14:12:26.665Z"
/// updatedAt : "2023-06-16T11:07:43.773Z"
/// shipping : {"id":"0de3a165-86e8-4abb-bd93-84d2038278a6","userId":"cb4e4c37-83c7-49be-9aaa-5e3188e8b235","buildingNo":"test","address":"assadas","city":"tess","createdAt":"2023-06-13T14:17:17.865Z","updatedAt":"2023-06-16T16:46:19.011Z"}

class TeamHost {
  TeamHost({
    String? id,
    String? phone,
    dynamic email,
    String? firstName,
    String? lastName,
    String? postalCode,
    String? stripeCustomerId,
    String? stripeDefaultPaymentMethodId,
    dynamic cardLastFourDigits,
    String? imageUrl,
    dynamic imageKey,
    String? role,
    String? createdAt,
    String? updatedAt,
    Shipping? shipping,
  }) {
    _id = id;
    _phone = phone;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _postalCode = postalCode;
    _stripeCustomerId = stripeCustomerId;
    _stripeDefaultPaymentMethodId = stripeDefaultPaymentMethodId;
    _cardLastFourDigits = cardLastFourDigits;
    _imageUrl = imageUrl;
    _imageKey = imageKey;
    _role = role;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _shipping = shipping;
  }

  TeamHost.fromJson(dynamic json) {
    _id = json['id'];
    _phone = json['phone'];
    _email = json['email'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _postalCode = json['postalCode'];
    _stripeCustomerId = json['stripeCustomerId'];
    _stripeDefaultPaymentMethodId = json['stripeDefaultPaymentMethodId'];
    _cardLastFourDigits = json['cardLastFourDigits'];
    _imageUrl = json['imageUrl'];
    _imageKey = json['imageKey'];
    _role = json['role'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    if (json['shipping'] != null) {
      _shipping =
          json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    }
  }

  String? _id;
  String? _phone;
  dynamic _email;
  String? _firstName;
  String? _lastName;
  String? _postalCode;
  String? _stripeCustomerId;
  String? _stripeDefaultPaymentMethodId;
  dynamic _cardLastFourDigits;
  String? _imageUrl;
  dynamic _imageKey;
  String? _role;
  String? _createdAt;
  String? _updatedAt;
  Shipping? _shipping;

  TeamHost copyWith({
    String? id,
    String? phone,
    dynamic email,
    String? firstName,
    String? lastName,
    String? postalCode,
    String? stripeCustomerId,
    String? stripeDefaultPaymentMethodId,
    dynamic cardLastFourDigits,
    String? imageUrl,
    dynamic imageKey,
    String? role,
    String? createdAt,
    String? updatedAt,
    Shipping? shipping,
  }) =>
      TeamHost(
        id: id ?? _id,
        phone: phone ?? _phone,
        email: email ?? _email,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        postalCode: postalCode ?? _postalCode,
        stripeCustomerId: stripeCustomerId ?? _stripeCustomerId,
        stripeDefaultPaymentMethodId:
            stripeDefaultPaymentMethodId ?? _stripeDefaultPaymentMethodId,
        cardLastFourDigits: cardLastFourDigits ?? _cardLastFourDigits,
        imageUrl: imageUrl ?? _imageUrl,
        imageKey: imageKey ?? _imageKey,
        role: role ?? _role,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        shipping: shipping ?? _shipping,
      );

  String? get id => _id;

  String? get phone => _phone;

  dynamic get email => _email;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get postalCode => _postalCode;

  String? get stripeCustomerId => _stripeCustomerId;

  String? get stripeDefaultPaymentMethodId => _stripeDefaultPaymentMethodId;

  dynamic get cardLastFourDigits => _cardLastFourDigits;

  String? get imageUrl => _imageUrl;

  dynamic get imageKey => _imageKey;

  String? get role => _role;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Shipping? get shipping => _shipping;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['phone'] = _phone;
    map['email'] = _email;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['postalCode'] = _postalCode;
    map['stripeCustomerId'] = _stripeCustomerId;
    map['stripeDefaultPaymentMethodId'] = _stripeDefaultPaymentMethodId;
    map['cardLastFourDigits'] = _cardLastFourDigits;
    map['imageUrl'] = _imageUrl;
    map['imageKey'] = _imageKey;
    map['role'] = _role;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    if (_shipping != null) {
      map['shipping'] = _shipping?.toJson();
    }
    return map;
  }
}

/// id : "0de3a165-86e8-4abb-bd93-84d2038278a6"
/// userId : "cb4e4c37-83c7-49be-9aaa-5e3188e8b235"
/// buildingNo : "test"
/// address : "assadas"
/// city : "tess"
/// createdAt : "2023-06-13T14:17:17.865Z"
/// updatedAt : "2023-06-16T16:46:19.011Z"

class Shipping {
  Shipping({
    String? id,
    String? userId,
    String? buildingNo,
    String? address,
    String? city,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _buildingNo = buildingNo;
    _address = address;
    _city = city;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Shipping.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _buildingNo = json['buildingNo'] ?? '';
    _address = json['address'] ?? '';
    _city = json['city'] ?? '';
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _userId;
  String? _buildingNo;
  String? _address;
  String? _city;
  String? _createdAt;
  String? _updatedAt;

  Shipping copyWith({
    String? id,
    String? userId,
    String? buildingNo,
    String? address,
    String? city,
    String? createdAt,
    String? updatedAt,
  }) =>
      Shipping(
        id: id ?? _id,
        userId: userId ?? _userId,
        buildingNo: buildingNo ?? _buildingNo,
        address: address ?? _address,
        city: city ?? _city,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  String? get userId => _userId;

  String? get buildingNo => _buildingNo;

  String? get address => _address;

  String? get city => _city;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['buildingNo'] = _buildingNo;
    map['address'] = _address;
    map['city'] = _city;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

/// email : null
/// firstName : "Hatesh"
/// lastName : "Kumar"
/// phone : "+4407872076691"
/// imageUrl : "https://rabble-dev1.s3.us-east-2.amazonaws.com/profile/img.png"

class User {
  User({
    dynamic email,
    String? firstName,
    String? lastName,
    String? phone,
    String? imageUrl,
    String? id,
    String? cardLastFourDigits,
  }) {
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _phone = phone;
    _imageUrl = imageUrl;
    _id = id;
    _cardLastFourDigits = cardLastFourDigits;
  }

  User.fromJson(dynamic json) {
    if(json['id']!=null) {
      _id = json['id'] ?? '';
    }
    _email = json['email'] ?? '';
    _firstName = json['firstName'] ?? '';
    _lastName = json['lastName'] ?? '';
    _phone = json['phone'] ?? '';
    _imageUrl = json['imageUrl'] ?? '';
    _cardLastFourDigits = json['cardLastFourDigits'] ?? '';
  }

  User.fromLocalStorage(UserModel data) {
    _email = data.email ?? '';
    _firstName = data.firstName ?? '';
    _lastName = data.lastName ?? '';
    _imageUrl = data.imageUrl ?? '';
  }

  dynamic _email;
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _phone;
  String? _imageUrl;
  String? _cardLastFourDigits;

  User copyWith({
    dynamic email,
    String? firstName,
    String? lastName,
    String? phone,
    String? id,
    String? imageUrl,
    String? cardLastFourDigits,
  }) =>
      User(
        email: email ?? _email,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        phone: phone ?? _phone,
        id: id ?? _id,
        imageUrl: imageUrl ?? _imageUrl,
        cardLastFourDigits: cardLastFourDigits ?? _cardLastFourDigits,
      );


  String? get id => _id;

  dynamic get email => _email;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get phone => _phone;

  String? get imageUrl => _imageUrl;

  String? get cardLastFourDigits => _cardLastFourDigits;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['phone'] = _phone;
    map['imageUrl'] = _imageUrl;
    map['cardLastFourDigits'] = _cardLastFourDigits;
    return map;
  }
}
