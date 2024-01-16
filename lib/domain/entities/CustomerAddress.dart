class CustomerAddress {
  CustomerAddress({
    num? statusCode,
    String? message,
    AddressData? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  CustomerAddress.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? AddressData.fromJson(json['data']) : AddressData();
  }

  num? _statusCode;
  String? _message;
  AddressData? _data;

  CustomerAddress copyWith({
    num? statusCode,
    String? message,
    AddressData? data,
  }) =>
      CustomerAddress(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  AddressData? get data => _data;

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

class AddressData {
  AddressData({
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

  AddressData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _buildingNo = json['buildingNo'];
    _address = json['address'];
    _city = json['city'];
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

  AddressData copyWith({
    String? id,
    String? userId,
    String? buildingNo,
    String? address,
    String? city,
    String? createdAt,
    String? updatedAt,
  }) =>
      AddressData(
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
