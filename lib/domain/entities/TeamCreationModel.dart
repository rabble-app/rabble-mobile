class TeamCreationModel {
  TeamCreationModel({
      num? statusCode, 
      String? message, 
      TeamCreationData? data,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  TeamCreationModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'] is List && json['message'].toString().contains(',') ? json['message'][0] : json['message'];
    _data = json['data'] != null ? TeamCreationData.fromJson(json['data']) : null;
  }
  num? _statusCode;
  String? _message;
  TeamCreationData? _data;
TeamCreationModel copyWith({  num? statusCode,
  String? message,
  TeamCreationData? data,
}) => TeamCreationModel(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get statusCode => _statusCode;
  String? get message => _message;
  TeamCreationData? get data => _data;

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

class TeamCreationData {
  TeamCreationData({
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
      String? createdAt, 
      String? updatedAt, 
      String? orderId,}){
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
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _orderId = orderId;
}

  TeamCreationData.fromJson(dynamic json) {
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
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _orderId = json['orderId'];
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
  String? _createdAt;
  String? _updatedAt;
  String? _orderId;
TeamCreationData copyWith({  String? id,
  String? name,
  String? postalCode,
  String? producerId,
  String? hostId,
  num? frequency,
  String? description,
  bool? isPublic,
  dynamic imageUrl,
  dynamic imageKey,
  String? createdAt,
  String? updatedAt,
  String? orderId,
}) => TeamCreationData(  id: id ?? _id,
  name: name ?? _name,
  postalCode: postalCode ?? _postalCode,
  producerId: producerId ?? _producerId,
  hostId: hostId ?? _hostId,
  frequency: frequency ?? _frequency,
  description: description ?? _description,
  isPublic: isPublic ?? _isPublic,
  imageUrl: imageUrl ?? _imageUrl,
  imageKey: imageKey ?? _imageKey,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  orderId: orderId ?? _orderId,
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
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get orderId => _orderId;

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
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['orderId'] = _orderId;
    return map;
  }

}