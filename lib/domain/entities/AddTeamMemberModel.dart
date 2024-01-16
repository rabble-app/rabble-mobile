class AddTeamMemberModel {
  AddTeamMemberModel({
      num? statusCode, 
      String? message, 
      Data? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  AddTeamMemberModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _statusCode;
  String? _message;
  Data? _data;
AddTeamMemberModel copyWith({  num? statusCode,
  String? message,
  Data? data,
}) => AddTeamMemberModel(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get statusCode => _statusCode;
  String? get message => _message;
  Data? get data => _data;

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

class Data {
  Data({
      String? id, 
      String? teamId, 
      String? userId, 
      String? status, 
      bool? skipNextDelivery, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _teamId = teamId;
    _userId = userId;
    _status = status;
    _skipNextDelivery = skipNextDelivery;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
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
Data copyWith({  String? id,
  String? teamId,
  String? userId,
  String? status,
  bool? skipNextDelivery,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
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